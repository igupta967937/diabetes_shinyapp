####--SERVER ANALYTICS--------------------------------------------------------------------------------------------

#
# ANALYTICS
#

####-Tab 1-------------------------------------------------------------------------------------------

case_data <- reactive({
  req(input$case)
  diabetes %>% 
    filter(case_number == input$case) %>%
    collect()
})

output$case_select <- renderUI({
  choices <- diabetes %>% head(n = 30) %>% 
    pull(case_number) 
  selectizeInput('case', label = "Case Number", choices = choices)
})

output$predicted_risk <- renderText({
  risk_diabetes <- predict_risk_diabetes(case_data())
  HTML(glue('<h4 style="text-align:center; font-weight:bold; color:#7b8a8b;">Chance of diabetes: {risk_diabetes}</h4>'))
})

output$explain_case <- renderPlot({
  data <- explain_risk_logistic(case_data())
  data <- data %>% 
    select(variable, estimate) %>%
    mutate(feature = str_to_title(variable),
           color = ifelse(estimate >0, 'Increasing Risk','Decreasing Risk'))
  data %>% 
    ggplot(aes(reorder(feature, estimate), estimate, fill = color)) +
    geom_bar(stat = "identity") +
    coord_flip() +
    theme_minimal() +
    theme(text = element_text(size=20)) +
    scale_fill_manual(values = c('Decreasing Risk' = '#417fe2', 'Increasing Risk' = '#7f1c2e')) +
    labs(
      title = 'Factors included in predictive model',
      x = NULL,
      y = "Risk weighting",
      fill = NULL
    )
})


output$gtCaseBin <- render_gt({
  case_data() %>%
    gather("Variable", "Value") %>% 
    filter(Variable != "(Intercept)" & Variable != "diabetes") %>% 
    # mutate_if(is.character, ~str_to_title(.)) %>% 
    filter(Variable != "Case_number") %>%
    gt() %>% 
    fmt("Value",fns = function(x){ifelse(x, "Yes", "No")})
})
