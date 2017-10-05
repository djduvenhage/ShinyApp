library(shiny)

shinyUI(pageWithSidebar(
        
        # Assigns Main Title to application window
        headerPanel("Coursera Shiny App Assignment Week 4 Building Data Products"),
        
        # Creates Side Panel titles, variable inputs and model data loading busy icon 
        sidebarPanel(# Some application notes to take into account
                     h4("Shiny App based on Linear Regression Course Week 4 Assignment.", style="color:blue"),
                     
                        helpText(div(HTML("<font size='5'><em>DATA: data(mtcars)<em>")), style="color:blue"),
                     
                     (div(HTML("<font size='3'>"))),
                     br(),
                     radioButtons("choice", label= "Predictor Model Fit 1:", 
                                                                                        choices= names(mtcars[,2:11]),
                                                                                        selected= "am"),
                     
                        helpText(div(HTML("<font size='2'><em>am=auto transmission, vs= cylinder alignment<em>")), style="color:blue"),
                                                  
                     # Action button restrict model execution during radio button selections.
                     # Change color of action button
                     # see website for the color choices: https://www.w3schools.com/colors/colors_hex.asp
                     tags$head(
                             tags$style(HTML('#runModel{background-color:DeepSkyBlue}'))
                     ),
                     
                     actionButton("runModel","Run Model !", style="color:white"),
                     
                     helpText(div(HTML("<font size='2'><em>Hit button to execute Model after making radio button changes.<em>")), style="color:blue")
                     
                   
                     # Condition panel code that uses "uiOutput("predictor")" to check if system is busy
                     # Displays a busy .gif (from .www file) when loading the data on initial startup of application
                     #conditionalPanel(condition="input.predictor.indexOf('predictor') != -1", tags$img(src="loading_circle.gif")) 
        
                     ),
        
        # Create Main Panel title and outputs and model running busy icon
        mainPanel(# Output: Tabset for Results
                
                # Ceate tabs sets and names
                tabsetPanel(type = "tabs",
                            
                                                   # The Document tab describes how to operate and read the application results
                                                   # Descriptive notes are also given on main sheet to lead examiner through the process.
                            tabPanel("Documentation",br(),
                                                    h4("Executive Summary"),
                                                    h6("For this assignment the Week 4 Regression Analysis Assignment is build into a Shiny App. The mtcars data set is used for evaluation."),
                                                    br(),
                                                    h6("In this project we evaluate the impact of vehicle transmission on miles per gallon (MPG). The mtcars dataset (1974) is used to answer:"),    
                                                    h6("               [1] which has the better mileage (MPG), automatic or manual transmission vehicles?"),  
                                                    h6("               [2] what is the difference in the fuel consumption between an automatic and manual transmission vehicle?"),                                      
                                                    br(),
                                                    h6("Using simple linear regression analysis, it has been determined that manual transmission vehicles has a significant higher fuel usage, measured in miles"),     
                                                    h6("per gallon (MPG), than vehicles with automatic transmissions. Under comparative testing a manual vehicle uses 2.94 MPG more fuel than an automatic transmission"),
                                                    h6("vehicle."),
                                                    br(),
                                                    h4("How the App functions"),
                                                    h6("On loading the App ten radio buttons are observed in the side panel with which the 'predictor' variable for Model Fit 1 can be varied. This is a deviation from the"),    
                                                    h6("earlier project in that only vehicle transmission type was considered as predictor during the Regression Analysis Assignment."),
                                                    br(),
                                                    h6("The 10 radio buttons represent: cyl= Number of cylinders, disp= Displacement (cu.in.), hp= Gross horsepower, drat= Rear axle ratio, wt= Weight (1000 lbs),"),
                                                    h6("qsec= 1/4 mile time, vs= enigne valve alignment, am= Transmission (0 = automatic, 1 = manual), gear= Number of forward gears, carb= Number of carburetors."),
                                                    h6("Detailed information on the mtcars data set can be obtained passing ?mtcars at the R-console prompt."),    
                                                    br(),
                                                    h6("The main page offers eight tabs. The first two considers Exploratory Data Analysis, giving an overview of data file size, data set dimensions, variable class,"),
                                                    h6("and overview of the first six lines of data, a summary of the data set, and four plots evaluating the fuel usage (as miles per gallon (mpg) versus transmission"),
                                                    h6("type (top two plots) and cylinder arrangement (bottom two plots)."),
                                                    br(),
                                                    h6("The next couple of tabs give model fit summaries. The first for a linear model fit between 'mpg as outcome' and the predictor selected from the radio button"),
                                                    h6("selection in the side panel. The second considers Model Fit 2 where all the predictor variables, listed on the Exploratory Data Analysis tab, are fitted. In this"),
                                                    h6("case it is critical to get rid of any confounding variables. This can be done by determining a 'Best fit' model, stepping automatically through each of the predictor"),
                                                    h6("variables and performing variable elimination on AIC score. The final outcome is an AIC score pointing to vehicle weight (wt), time over the quarter mile (qsec), and"),
                                                    h6("transmission (am) to be the most significant model predictors."), 
                                                    br(),
                                                    h6("IT IS IMPORTANT TO NOTE THAT AFTER EACH RADIO BUTTON CHOICE SELECTION THE BLUE 'RUN MODEL !' BUTTON SHOULD BE CLICKED, TO ACTIVATE THE CHANGES.", style="color:red"),
                                                    br(),                                       
                                                    h6("Model Fit 3 is the model run using only the three most suitable predictors from the AIC score, and the result is backed up by an ANOVA plot and t-test on the next tab,"),
                                                    h6("as well as a set of residual versus fitted values under the QQ Plot tab.")   
                                                    
                                                ),
                            
                            tabPanel("Exploratory Data Analysis", br(), 
                                                                  h4("Data Tables"),
                                                                  h5("The data set is explored using object.size(mtcars), dim(mtcars), sapply(mtcars, class), head(mtcars), summary(mtcars) to assess the dataframe size, structure, variable (11)"),
                                                                  h5("and observation (32) entries, and basic mean, median, min, max and quantile values."),
                                                                  br(),
                                                                  h4("Data File Size"),
                                                                        verbatimTextOutput("result0"),
                                                                  br(), 
                                                                  h4("Data Set Dimensions"),      
                                                                        verbatimTextOutput("result00"),
                                                                  br(), 
                                                                  h4("Variable Class"),     
                                                                        verbatimTextOutput("result000"),
                                                                  br(), 
                                                                  h4("Top Six lines of Data"),       
                                                                        verbatimTextOutput("result0000"),
                                                                  br(), 
                                                                  h4("General Data Summary"),    
                                                                        verbatimTextOutput("result00000")),
        
                            tabPanel("Exploratory Data Plots", br(), 
                                                                h4("Exploratory Data Plots"),
                                                                h5("The data exploration is expanded considering two rough plots to assess the MPG to Transmission Type relationship making use of a scatter and box plot."),
                                                                h5("It is evident that there is a significant difference in the magnitude of MPG per Transmission Type for the automatic ('0') compared to manual ('1')"),
                                                                h5("transmission with the former having values around 17 MPG and the latter values around 23 MPG (consider the thick black median lines in the box plots)."),
                                                                        
                                                                          plotOutput("result000000")),
                            
                            
                            tabPanel("Model Fit 1", br(), 
                                                        h4("Simple One Predictor Model Fit"),
                                                        h5("Remember to hit 'Run Model !' after making choice (can toggle between the two selections).", style= "color:red"),
                                                        h5("A simple linear model with one predictor dependent on radio button selection (am= transmission, vs= engine cylinder alignment)."),
                                                        h5("For either selection the multiple and adjusted R-squared values are poor, with the residual standard error being around 5 on"),
                                                        h5("30 degrees of freedom."),
                                                                
                                                                verbatimTextOutput("result1"),
                                                        br(),
                                                        br(),
                                                                plotOutput("result7")),
                            
                            tabPanel("Model Fit 2", br(), 
                                                        h4("AIC Model Fit"),
                                                        h5("Stepping through all the model predictors the lowest AIC score at 61.31 came for a combination of vehicle weight (wt), time"),
                                                        h5("over the quarter mile (qsec), and transmission (am). See AIC at the bottom of the page. It is clear that the model has a much"),
                                                        h5("better fit with a R-squared at 0.8497."), 
                                                        
                                                                verbatimTextOutput("result2")),
                                                        
                                                        
                            tabPanel("Model Fit 3", br(), 
                                                        h4("Best Model Fit"),
                                                        h5("Using the best model predictors (vehicle weight (wt), time over the quarter mile (qsec), and transmission (am)) as selected"),
                                                        h5("from the AIC process the R-squared data fit below is obtained, and it is clear that the model has a much better fit at 0.8497"),
                                                        h5("compared to the single variable model fit with an R-square at 0.3598"),
                                                        h5("It is also evident that the manual transmission vehicles uses nearly 2.94 times the amount of fuel used by automatic vehicles."),
                                                                
                                                                verbatimTextOutput("result4"),
                                                        br(),
                                                        br(),
                                                        h4("Residual versus Fitted Value Points Plot"),
                                                        h5("Evaluating the residuals plot(i.e. plot of residuals versus Fitted values), it is evident that the red line, which is a smoothed"),
                                                        h5("scatter plot depicting the residuals average value at each fitted value, is reasonably trendless. This suggests there is no visible"),
                                                        h5("non-linear trend to the residuals. It also appear if the residuals are equally variable across the entire range of fitted values."),
                                                        h5("There is therefore no clear indication of non-constant variance."),
                                                        
                                                                plotOutput("result8")),
                            
                            tabPanel("ANOVA", br(), 
                                                        h4("ANOVA"),
                                                        h5("Specifically considering, as per problem statement, mpg as a function of transmission type, an anova comparison of the two models reveal the"),
                                                        h5("p-value is significant enough to reject the hypothesis that variables other than vehicle transmission do not contribute to the"),
                                                        h5("validity / accuracy of the model."),
                                                                
                                                                verbatimTextOutput("result3"),
                
                                                        br(),
                                                        h4("t-test"),
                                                        h5("Similarly, a t-test for mpg as a function of transmission type, supports the observation during the Exploratory Data Analysis, showed on the"),
                                                        h5("Exploratory Data Plots tab, that the manual vehicles (designator '1') has a mean MPG at 24.39 and the automatic vehicles (designator '0') a"),
                                                        h5("mean at 17.15 ( Consider, the thick black median lines in the middle of the box plots."),
                                                        h5("Take note, not all predictors will have valid t-tests. If a variable is not suitable an 'Error', 'grouping factor must have exaclty 2 levels', will be outputted.", style="color:red"),
                                                        br(),        
                                                                verbatimTextOutput("result5")),     
                
                            tabPanel("QQ Plot", br(), 
                                                        h4("Model Residuals"),
                                                        h5("Plotting Residuals versusFitted values in the graphs below show large scatter with no distinct pattern which is indicative of a reasonable model fit."),
                                                        h5("The Q-Q Standard Residuals versus Theoretical Quantiles mostly follow a linear trend in the middle section with some deviation at the bottom"),
                                                        h5("and most at the top."),
                                                        h5("The Scale-location plot also suggests no particular trends supporting an acceptable model fit."),
                                                        h5("The Standard residuals versus Leverage plot also shows large scatter with no distinct trend."),
                                                        h5("In general the residuals support the model fit."),
                                     
                                                                plotOutput("result6")))            
                
                # Condition panel code shows busy .gif (in (wwwfile) after making a new radio button choice
                #conditionalPanel(condition="$('html').hasClass('shiny-busy')", tags$img(src="loading_circle.gif"))
                
               )
                
        )

)
