
# Loading necessary libraries        
library(shiny)
library(ggplot2)

# Loading data set
data(mtcars)

# Shiny application server code
shinyServer(function(input, output, session) {
                                                
                                                # Take note that the formula and Model fit 1 are event reactive and need the actionButton to execute
                                                # Setting up regression formula for Model fit 1 from ui.R inputs
                                                formula <- eventReactive(input$runModel,{as.formula(paste("mpg","~", paste(input$choice)))})
        
                                                # Setting up regression formula for Model fit 3 for use in results section as well
                                                formula2 <- eventReactive(input$runModel, {as.formula(paste("mpg ~ wt + qsec + am"))})   
                                                
                                                # Model fit 1 fitting one predictor to the outcome mpg
                                                fit1 <- eventReactive(input$runModel,{
                                                                                       f2 <- lm(formula(), data = mtcars)
                                                                                       f2
                                                                                       })
                                                        
                                                # Model fit 2 fitting ALL predictors in step wise fashion to find best suited predictors to the outcome mpg        
                                                fit2 <- eventReactive(input$runModel,{
                                                                                       fit2 <- lm(mpg ~ ., data = mtcars)
                                                                                       fit2 <- step(fit2, direction = "both")
                                                                                       })
                                                
                                                # Rerunning best AIC predictor selection from Model fit 2 fitting the best suited predictors to the outcome mpg
                                                fit3 <- eventReactive(input$runModel,{
                                                                                      fit3 <- lm(formula2(), data = mtcars)
                                                                                      })
                                                
                                                        
                                                # _____________________________________________________________________________________________________________
                        
                                                # RESULTS GENERATION SECTION for output to ui.R
                                                # DATA EXPLORATION DATA TABLES AND PLOTS        
                                                # Data file size
                                                output$result0 <- renderPrint({
                                                                                object.size(mtcars)
                                                                               }) 
                                                # Data set dimensions
                                                output$result00 <- renderPrint({
                                                                                 dim(mtcars)
                                                                                }) 
                                                # Predictor Variable Class
                                                output$result000 <- renderPrint({
                                                                                  sapply(mtcars, class)
                                                                                 }) 
                                                # Top 6 lines of data set
                                                output$result0000 <- renderPrint({
                                                                                   head(mtcars)
                                                                                  })
                                                # General summary of data set
                                                output$result00000 <- renderPrint({
                                                                                    summary(mtcars)
                                                                                   })
                                                # Exploratory data plots
                                                output$result000000 <- renderPlot({
                                                                                    par(mfrow = c(2,2))
                                                                                    plot(mpg~am, data=mtcars, xlab="Transmission Type (am)", ylab="Miles per Gallon (mpg)")
                                                                                    legend("bottom", inset=.02, title="Transmission Type", c("manual=1.0", "automatic=0.0"))
                                                                
                                                                                    boxplot(mpg~am, data=mtcars, xlab="Transmission Type (am)", ylab="Miles per Gallon (mpg)")
                                                                                    legend("topleft", inset=.02, title="Transmission Type", c("manual=1.0", "automatic=0.0"))
                                                                
                                                                                    plot(mpg~vs, data=mtcars, xlab="Cylinder Arrangement (VS)", ylab="Miles per Gallon (mpg)")
                                                                                    legend("bottom", inset=.02, title="Cylinder Arrangement", c("straight=1.0", "automatic=0.0"))
                                                                
                                                                                    boxplot(mpg~vs, data=mtcars, xlab="Cylinder Arrangement (VS)", ylab="Miles per Gallon (mpg)")
                                                                                    legend("topleft", inset=.02, title="Cylinder Arrangement", c("straight=1.0", "V engine=0.0"))
                                                                                    })
                       
                     
                                                # Summary Model Fit1, Fit2, & Fit3
                                                output$result1 <- renderPrint({
                                                                                summary(fit1())
                                                                                })
                        
                                                output$result2 <- renderPrint({
                                                                                summary(fit2())
                                                                                })   
                        
                                                output$result4 <- renderPrint({
                                                                                summary(fit3())
                                                                                }) 
                        
                                                # ANOVA plot on Fit1 and Fit3
                                                output$result3 <- renderPrint({
                                                                                anova(fit1(), fit3())
                                                                                })
                         
                                                # t-test
                                                output$result5 <- renderPrint({
                                                                               t.test(formula(), data = mtcars)
                                                                                })  
                         
                                                # Plotting Residuals vs Fitted values
                                                output$result6 <- renderPlot({
                                                                                par(mfrow=c(2, 2))
                                                                                plot(fit2())
                                                                                })  
                         
                                                # Generate relationship plot Fit 1
                                                output$result7 <- renderPlot({
                                                                                plot(formula(),  col="blue", data = mtcars, xlab= input$choice, ylab= "Miles per Gallon (mpg)")
                                                                                title(main= paste("Miles per Gallon as a function of ", paste(input$choice)), cex.main=1.5, adj = 0, line = 2)
                                                                                })
                         
                                                # Generate Residuals vs Fitted for Fit3
                                                output$result8 <- renderPlot({
                                                                                plot(fit3(), which = 1)
                                                                                })
                         
                         
                       })