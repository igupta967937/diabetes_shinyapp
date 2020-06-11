####--UI ANALYTICS--------------------------------------------------------------------------------------------

#
# ANALYTICS
#


tabItem_home <-
  tabItem(tabName='home',
          fluidPage(
            
            # headerPanel(
            #   h3("Patient Studio")
            # ),
            # 
            mainPanel(
              
              p("Welcome!"),
              
              # Nesting the paragraph in a HTML tab allows you to also embed words with bold font using <strong> </strong>
              p(HTML("The interactive platform presented here was produced by <strong>Shiny</strong> 
                        and <strong>R Studio</strong>. <strong>Shiny</strong> helps to communicate <strong>Artificial Intelligence (AI)</strong> in the one platform. 
                          This app contains examples of machine learning outputs that can be deployed to medical staff, 
                     leadership and stakeholders to support awareness and decision making.")),
              p("This app is currently in a state of development to consider its 
              potential to present case-by-case predictive analytics
              to support clinical decision-making. After navigating through this app please follow the link 
              below to complete a survey"),
              hr(),
              
              # Insert an accordian style menu using the bsplus package
              bs_accordion(id = "welcomeinfo") %>%
                bs_set_opts(panel_type = "info", use_heading_link = TRUE) %>%
                bs_append(title = "What is this dashboard for?",
                          # Have to embed content within shiny::HTML to render properly in content of accordian list
                          content = shiny::HTML("The purpose of this dashboard is to present AI analytic results
                          to support clinical decision-making about patients' risk of having diabetes: 
                                                 <ul>
                                                 <li>Demonstrate potential applications of R Shiny as an interactive analytics platform </li>
                                                 <li>Receive feedback (as per survey link below) about the usefulness of this dashboard</li>
                                                 </ul>")) %>%
                bs_append(title = "What is an interactive analytics platform?",
                          content = shiny::HTML("An interactive analytics platform is an application that supports 
                                                            non-static research outputs.  
                                                            <br> <br> Popular examples include:
                                                            <br> <br>
                                                             <ol>
                                                             <a href='https://shiny.rstudio.com/'>
                                                              <img src='rstudio.jpeg' width='25'/>
                                                              RMarkdown/knitr and R Shiny from R Studio
                                                            </a> 
                                                            </ol>
                                                            <ol>
                                                            <a href='https://jupyter.org/'>
                                                              <img src='jupyter.png' width='25'/>
                                                              Jupyter Notebooks from the Jupyter community
                                                            </a>
                                                             </ol>
                                                            These platforms allow researchers to weave together narrative text, 
                                                            code and the output of that code. They can help to make research results 
                                                            more <strong>open</strong> and <strong>accessible</strong>, and they can promote 
                                                            <strong>research reproducibility</strong> by allowing
                                                            other researchers to access and run code.")) %>%
                bs_append(title = "Who is developing this dashboard?",
                          content = shiny::HTML("This dashboard has been developed by members of the Research Unit
                                                            </p>
                                                            ")) %>%
                bs_append(title = "What do I need to do?",
                          content = shiny::HTML("We would like to receive feedback from workshop participants on the potential usefulness of this platform, 
                          as well as planned future use and any training needs or barriers to use.
                                                    </p>
                                                    This app illustrates two potential use-cases for an interactive analytics platform:
                                                    </p>
                                                    <ol>
                                                    <li>Supplementing traditional research outputs with engaging and responsive visualisations</li>
                                                    <li>Deployment of an Artificial Intelligence solution to support a decision making problem</li>
                                                    </ol>
                                                    </p>
                                                    When you are ready, please complete a short survey on your impression of this dashboard and potential 
                                                    future uses of interactive platforms - considering various use cases and stakeholders.
                                                    
                                                    <p></p>
                                                    <br/>
                                                    <strong>In brief:</strong>
                                                    <ul>
                                                    <p>
                                                    <i class='fa fa-chart-line'></i>
                                                    Use the panel on the left to navigate through the use-case examples
                                                    </p>
                                                    <p>
                                                    <i class='fa fa-edit'></i>
                                                    Complete the survey
                                                    </p>
                                                    </ul>
                                                     "))
              
            ) # Closes main panel
            
          ))

  
