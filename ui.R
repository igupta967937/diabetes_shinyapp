####--UI--------------------------------------------------------------------------------------------

#  
# The UI isn't really here but in server.R
# This allows dynamic control over UI elements
#

dashboardPage(skin = "blue",
              dashboardHeader(
                title = "Medical Studio"),
              dashboardSidebar(uiOutput("ui_sidebar")),
              dashboardBody(
                uiOutput("ui_body")
              )
)
