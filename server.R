####--SERVER------------------------------------------------------------------------------------------------

shinyServer(function(input, output, session, options = options(warn = -1)) {

####--UI BLOCK----------------------------------------------------------------------------------------------
  default_tab = "analytics"
  current_version = "0.01"

  output$app_version <- renderUI({
    fluidRow(
      column(12, 
             offset = 1, 
             br(),
             h5(str_c("Version ", current_version)),
             h6("Mocha-AI")
             )
    )
  })
    
  output$ui_sidebar <- renderUI({
    sidebarMenu(id = "tab",
                menuItem(text = "Home", 
                         tabName = "home", 
                         icon = icon("home")
                ),
                menuItem(text = "Analytics", 
                         tabName = "analytics", 
                         icon = icon("chart-line")
                         ),
                
                # menuItem(text = "Descriptives", 
                #          tabName = "descriptives", 
                #          icon = icon("balance-scale")
                #          ),
                
                # menuItem(text = "Data", 
                #          tabName = "data", 
                #          icon = icon("cube")
                #          ),
                
                uiOutput("app_version")
                # br(),
                # br(),
                # img(src = "ahpra_logo_30.PNG") #attempt to add the logo
    )
  })
  
  output$ui_body <- renderUI({
    updateTabsetPanel(session, "tab", selected = "home")
    tabItems(
      tabItem_home,
      tabItem_analytics
      # tabItem_descriptives,
      # tabItem_data
    )
  })
  
####--SERVER BLOCK-----------------------------------------------------------------------------------------
  
  ## ReactiveValues
  v <- reactiveValues(analytics_slider_time = NULL)
  
  # Server modules 
  # source('server/s_data.R', local = TRUE)
  # source('server/s_descriptives.R', local = TRUE)
  source('server/s_analytics.R', local = TRUE)



})  
