# Packages ----------------------------------------------------------------

library(tidymodels)
library(mlbench)
library(workflows)
library(tune)

# Setup ----------------------------------------------------------------

set.seed(1353)
options(max.print = 9999)
options("scipen"=999, "digits"=4)

# Data  --------------------------------------------------------------------

# Import data
data("PimaIndiansDiabetes")

# Change target variable - (yardstick has event of interest as first level)
PimaIndiansDiabetes <- PimaIndiansDiabetes %>%
  mutate(diabetes = relevel(diabetes, "pos"))

# Rsample see also https://rviews.rstudio.com/2019/06/19/a-gentle-intro-to-tidymodels/
train_test_split <- initial_split(PimaIndiansDiabetes)

train <- training(train_test_split)
count(train, diabetes)

test <- testing(train_test_split)
count(test, diabetes)

(train_cv <- vfold_cv(train, v = 10, repeats = 1, strata = diabetes))

# Prepare the recipe -----------------------------------------------------------------

recipe_cleanup <- function(dataset){
  dataset %>% 
    recipe(formula = diabetes ~ .) %>% 
    step_corr(all_numeric(), threshold = 0.4) %>%  #Removes overly correlated predictors (numeric only)
    step_center(all_numeric()) %>%
    step_scale(all_numeric()) %>%
    step_zv(all_predictors()) %>%    #Removes zero variance predictors (constant values)
    prep(data = dataset)
}

recipe_prepped <- recipe_cleanup(train)

# Model ------------------------------------------------------------------

(engine <- logistic_reg() %>% 
   set_mode("classification") %>% 
   set_engine("glm"))

# Fit resamples --------------------------------------------------------------------

(lr_diabetes <- fit_resamples(
  recipe_prepped,
  model = engine,
  resamples = train_cv,
  metrics = metric_set(roc_auc, j_index, sens, spec),
  control = control_resamples(save_pred = FALSE)
))

# Check resampled fits --------------------------------------------------------------------

resample_metrics <- collect_metrics(lr_diabetes) 

# Apply model to hold out test set and apply package probably to find a suitable threshold for class predictions -----------------

train <- juice(recipe_prepped)
logisticmodel <- fit(engine, diabetes ~ ., data = train)
test_baked <- bake(recipe_prepped, test)

predictions <- logisticmodel %>%
  predict(new_data = test_baked, type = "prob") %>% 
  bind_cols(test %>% select(diabetes))

estimates <- broom::tidy(logisticmodel)

saveRDS(logisticmodel, "app_objects/logisticreg.RDS")
saveRDS(PimaIndiansDiabetes, "app_objects/diabetes.RDS")

