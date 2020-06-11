# load prebuilt predictive model 
preprocessor <- readRDS('app_objects/data_preprocessor.RDS')
logistic_model <- readRDS('app_objects/logisticreg.RDS')
coefficients <- readRDS('app_objects/coefficients.RDS')

#Read RDS file
diabetes <- readRDS('cleaned_data/diabetes.RDS') 

diabetes <- diabetes %>% 
  mutate(case_number =paste("patient", row_number()))


bake_case <- function(case) {
  case %>% 
    bake(preprocessor, .) 
}


predict_risk_diabetes <- function(case) {
  predict(logistic_model, bake_case(case), type = "prob") %>% 
    pull(.pred_pos) %>% 
    percent(accuracy = 1)
}

# explain_risk_ml <- function(case) {
#   #set.seed(33)
#   lime::explain(
#     x = bake_case(case),
#     model_explainer,
#     n_features = length(case),
#     labels = "Yes",
#     n_permutations = 5000,
#     feature_select = "forward_selection"
#   )
# }

explain_risk_logistic <- function(case){
  bake_case(case) %>% 
    gather(key = "variable", "value") %>% 
    inner_join(coefficients, by = "variable") %>% 
    mutate(estimate = as.numeric(value)*Coefficient) %>% 
    select(variable, estimate) 
}
