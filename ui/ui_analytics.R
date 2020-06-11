####--UI ANALYTICS--------------------------------------------------------------------------------------------

#
# ANALYTICS
#


tabItem_analytics <-
  tabItem(tabName = "analytics",
          fluidRow(
            column(width = 3,
                   h2(icon("chart-line"), HTML("&nbsp;"),"Analytics")
            )
          ),
          tabsetPanel(
            type = "tabs",
            id = "analytics_tabset",
            
####--Tab 1-------------------------------------------------------------------------------------------
            tabPanel(
              tags$b('Chance of diabetes'), br(),
              fluidPage(
                theme = shinytheme("simplex"),
                titlePanel(" "),
                tags$style(type="text/css",
                           ".shiny-output-error { visibility: hidden; }",
                           ".shiny-output-error:before { visibility: hidden; }"
                ),
                
                sidebarLayout(
                  sidebarPanel(
                    uiOutput('case_select'),
                    htmlOutput("predicted_risk"),
                    br(),
                    h3("Predictors"),
                    p("Pregnant: Number of times pregnant"),

                    p("Glucose: Plasma glucose concentration (glucose tolerance test)"),

                    p("Pressure: Diastolic blood pressure (mm Hg)"),

                    p("Inslulin: 2-Hour serum insulin (mu U/ml)"),

                    p("Mass: Body mass index (weight in kg/(height in m)^2)"),
  
                    p("Pedigree: 	Diabetes pedigree function"),
                    
                    br(),
                    
                    h3("Data source"),
                    p("National Institute of Diabetes and Digestive and Kidney Diseases"),
                    p("These data are from the UCI Repository Of Machine Learning Databases located ",
                    a(href="ftp://ftp.ics.uci.edu/pub/machine-learning-databases", "here"),
                    a(href="http://www.ics.uci.edu/~mlearn/MLRepository.html", "and here"))
 
                  ),
                  
                  
                  mainPanel(
                    tabsetPanel(
                      tabPanel("Feature Plot", withLoader(plotOutput("explain_case"))) ,
                      tabPanel("Data Drill Down", 
                               gt_output("gtCaseBin")
                      )
                    )
                  )
                  
                )
              )
            ))
          )
 















  
