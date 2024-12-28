library(shiny)
library(bslib)
library(plotly)

ui <- navbarPage("GraduateEmployment", theme = bs_theme(bootswatch = 'flatly'),
                 tabPanel("Main",
                          titlePanel(div(windowTitle = 'GraduatEmploymentSG', img(src = 'sg0.jpg', width = '100%', class = 'bg'),)),
                          tags$br(),

                          #Panel: Main>Summary
                          
                          tabsetPanel(type = 'tabs',
                                      
                                      tabPanel("Summary",
                                               sidebarLayout(
                                                 sidebarPanel(h3('Data by Year'),
                                                              tags$br(),
                                                              selectInput("checkYear", 'Select Year', choices = list('2018', '2017', '2016', '2015', '2014', '2013'), selected = "2018")),
                                                 
                                                 mainPanel(
                                                   tabsetPanel(type = 'tabs',
                                                               tabPanel('Ranking', uiOutput('datahead')),
                                                               tabPanel('No. of Graduates', plotOutput(outputId = 'piePlot'))),
                                                   tags$br(),
                                                   tags$br()
                                                   )
                                                 ),
                                               tags$hr(),
                                               
                                               fluidPage(
                                                 # Add custom CSS for sliders
                                                 tags$style(HTML("
    .js-irs-0 .irs-bar,
    .js-irs-0 .irs-handle {
      background-color: #2c3e50;  /* Set color for the first slider (incomeRange) */
      border-color: #2c3e50;
    }
    .js-irs-1 .irs-bar,
    .js-irs-1 .irs-handle {
      background-color: #e67e22;  /* Set color for the second slider (employRange) */
      border-color: #e67e22;
    }
  ")),
                                                 
                                                 sidebarLayout(
                                                   sidebarPanel(
                                                     # Data Overview filters
                                                     h3("Data Overview"),
                                                     tags$br(),
                                                     
                                                     # Slider for Salary Range
                                                     sliderInput(
                                                       "incomeRange",
                                                       label = 'Salary Range',
                                                       min = 1600,
                                                       max = 5000,
                                                       value = c(1600, 5000)
                                                     ),
                                                     
                                                     # Slider for Employment Rate Range
                                                     sliderInput(
                                                       'employRange',
                                                       label = 'Employment Rate Range',
                                                       min = 0,
                                                       max = 100,
                                                       value = c(0, 100)
                                                     ),
                                                     
                                                     # Dropdown for Year Selection
                                                     selectInput(
                                                       'checkYearGroup',
                                                       'Select Year',
                                                       choices = list("2013", "2014", "2015", "2016", "2017", "2018"),
                                                       selected = '2018',
                                                       multiple = TRUE
                                                     ),
                                                     
                                                     #checkboxGroupInput("checkYear", label = "Select Year",
                                                                       #choices = list("2013", "2014", "2015", "2016", "2017", "2018"),
                                                                      #selected = list("2013", "2014", "2015", "2016", "2017", "2018"), inline = TRUE),
                                                     
                                                     # Action Button
                                                     actionButton('actionDT', 'Filter', class = 'btn btn-warning')
                                                   ),
                                                   
                                                   mainPanel(
                                                     h3('Browse All'),
                                                     tags$br(),
                                                     dataTableOutput('myTable'),
                                                     tags$br(),
                                                     tags$br()
                                                   )
                                                 ),
                                                 
                                                 tags$hr()
                                               ),
                                      
                                      # Panel: Main > Plots
                                               tabPanel(
                                                "Visual Comparison",
                                                
                                                # Density Plot Section
                                                
                                                sidebarLayout(
                                                  sidebarPanel(
                                                    h3('Density Plot Panel'),
                                                    tags$br(),
                                                    selectInput(
                                                      'selectVar',
                                                      label = 'Choose a variable to display',
                                                      choices = c(
                                                        'Basic Monthly Salary (Median)' = 'basic_monthly_median',
                                                        'Fulltime Employment Rate' = 'employment_rate_ft_perm'
                                                      ),
                                                      selected = 'basic monthly mean'
                                                    ),
                                                    
                                                    checkboxGroupInput(
                                                      'checkGroup',
                                                      label = 'Select University',
                                                      choices = list(
                                                        "Nanyang Technological University" = "Nanyang Technological University",
                                                        "National University of Singapore" = "National University of Singapore",
                                                        "Singapore Institute of Technology" = "Singapore Institute of Technology",
                                                        "Singapore Management University" = "Singapore Management University",
                                                        "Singapore University of Social Sciences" = "Singapore University of Social Sciences",
                                                        "Singapore University of Technology and Design" = "Singapore University of Technology and Design"
                                                      ),
                                                      selected = list(
                                                        "Nanyang Technological University" = "Nanyang Technological University",
                                                        "National University of Singapore" = "National University of Singapore",
                                                        "Singapore Institute of Technology" = "Singapore Institute of Technology",
                                                        "Singapore Management University" = "Singapore Management University",
                                                        "Singapore University of Social Sciences" = "Singapore University of Social Sciences",
                                                        "Singapore University of Technology and Design" = "Singapore University of Technology and Design"
                                                      )
                                                    ),
                                                  ),
                                                  mainPanel(
                                                    h3("Distribution"),
                                                    plotlyOutput(outputId = 'densityPlot'),
                                                    tags$br(),
                                                    tags$br()
                                                  )
                                                ),
                                                tags$hr(),
                                                
                                                #bar plot selection
                                                
                                                sidebarLayout(
                                                  sidebarPanel(
                                                    h3("Bar Plot Panel"),
                                                    tags$br(),
                                                    radioButtons(
                                                      'radio',
                                                      label = 'Select University',
                                                      choices = list(
                                                        "Nanyang Technological University" = "Nanyang Technological University",
                                                        "National University of Singapore" = "National University of Singapore",
                                                        "Singapore Institute of Technology" = "Singapore Institute of Technology",
                                                        "Singapore Management University" = "Singapore Management University",
                                                        "Singapore University of Social Sciences" = "Singapore University of Social Sciences",
                                                        "Singapore University of Technology and Design" = "Singapore University of Technology and Design"
                                                      ),
                                                      selected = 'Nanyang Technological University'
                                                    ),
                                                    tags$hr()
                                                  ),
                                                  mainPanel(
                                                    h3("Median Income by School (aggregate)"),
                                                    plotlyOutput(outputId = 'uniPlot'),
                                                    tags$br(),
                                                    tags$hr()
                                                  )
                                                ),
                                                tags$hr(),
                                                
                                                
                                              #Box plot Section
                                              
                                              sidebarLayout(
                                                sidebarPanel(
                                                  h3("Box Plot Panel"),
                                                  tags$br(),
                                                  checkboxGroupInput(
                                                    "checkGroupbox",
                                                    label = "Select University",
                                                    choices = list(
                                                      "Nanyang Technological University" = "Nanyang Technological University",
                                                      "National University of Singapore" = "National University of Singapore",
                                                      "Singapore Institute of Technology" = "Singapore Institute of Technology",
                                                      "Singapore Management University" = "Singapore Management University",
                                                      "Singapore University of Social Sciences" = "Singapore University of Social Sciences",
                                                      "Singapore University of Technology and Design" = "Singapore University of Technology and Design"
                                                    ),
                                                    selected = list(
                                                      "Nanyang Technological University" = "Nanyang Technological University",
                                                      "National University of Singapore" = "National University of Singapore",
                                                      "Singapore Institute of Technology" = "Singapore Institute of Technology",
                                                      "Singapore Management University" = "Singapore Management University",
                                                      "Singapore University of Social Sciences" = "Singapore University of Social Sciences",
                                                      "Singapore University of Technology and Design" = "Singapore University of Technology and Design"
                                                    )
                                                  ),
                                                  
                                                  tags$hr()
                                                ),
                                                mainPanel(
                                                  h3("Median Income Comparison (aggregate)"),
                                                  plotlyOutput(outputId = "boxPlot"),
                                                  tags$br(),
                                                  tags$br(),
                                                  tags$br(),
                                                )
                                              ),
                                              
                                              tags$hr(),
                                              
                                              #Scatter Plot Section
                                              
                                              fluidPage(fluidRow(
                                                h3("Fulltime Employment Rate vs. Median Income by University in 2018"),
                                                align = 'center',
                                                plotlyOutput(outputId = 'scatPlot', width = "100%"),
                                                div(style = "height:400px")
                                              )),
                                              
                                              tags$br(),
                                              tags$br(),
                                              tags$hr(),
                                              
                                              
                                               ),
                                      
                                      
                                      
                                      
                                      # Panel: Main > Details
                                      
                                      tabPanel(
                                        "Details by University",
                                        h3("Graduates' Income by Employment Rate by Year", align = "center"),
                                        br(),
                                        div(style = "display:vertical-align:center-align",
                                            fluidRow(
                                              column(
                                                4,
                                                selectInput(
                                                  "detailUniversity",
                                                  label = "Select University",
                                                  choices = unique(employ_data$university),
                                                  selected = "National University of Singapore",
                                                  width = 400
                                                ),
                                              ),
                                              column(
                                                4,
                                                selectInput(
                                                  "detailSchool",
                                                  "Select School",
                                                  choices = "",
                                                  selected = "",
                                                  width = 400
                                                )
                                              ),
                                              column(4,
                                                     column(
                                                       8,
                                                       selectInput(
                                                         "detailMajor",
                                                         'Select Program',
                                                         choices = "",
                                                         selected = "",
                                                         width = 400
                                                       )
                                                     ),
                                                     column(
                                                       4,
                                                       tags$br(),
                                                       actionButton("detailFilter", "Filter", class = "btn btn-warning btn-sm")
                                                     ))
                                                     
                                            )),
                                        
                                        tags$br(),
                                        tags$br(),
                                        tags$hr(),
                                        tags$br(),
                                        
                                        fluidRow(
                                          column(4, uiOutput("detailTable")),
                                          column(4, h5("Montly Median Income", align="center"), plotOutput(outputId = "detailPlot", height = "300px")),
                                          column(4, h5("Fulltime Employment rate", align="center"), plotOutput(outputId = "detailPlotem", height = "300px"))
                                        ),
                                        
                                        tags$br(),
                                        tags$br(),
                                        tags$br(),
                                        tags$br(),
                                        tags$hr(),
                                        tags$br()
                                      )
                                    )
                          ),
                          
                          
                          
                          ################################################
                          #### Panel: Documentation                   ####
                          ################################################
                          
                          tabPanel("Documentation",
                                   fluidPage(htmlOutput("doc"))),
                          
                          ################################################
                          #### Panel: About                           ####
                          ################################################
                          tabPanel("About",
                                   fluidPage(htmlOutput("abo")))
              ))
                 
                 
shinyApp(ui = ui, server = server)
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      

