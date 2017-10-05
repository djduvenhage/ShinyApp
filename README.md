

# Shiny App Assignment [Week 4 Building Data Products]

The Shiny Application presented for the assignment is based on a Linear Prediction Model designed during Week 4 of the Coursera "Linear Regression" course. 

The notes below describe the background to the prediction model and how to operate the Shiny App.

# Background: Data & Task

In this project we evaluate the impact of vehicle transmission on miles per gallon (MPG). The mtcars dataset (1974) is used to answer:

[1] which has the better mileage (MPG), automatic or manual transmission vehicles?    
[2] what is the difference is the fuel consumption between an automatic and manual transmission vehicle?

Conclusion:
Using simple linear regression analysis, it has been determined that manual transmission vehicles has a significant higher fuel usage, measured in miles per gallon (MPG), than vehicles with automatic transmissions. Under comparative testing a manual vehicle uses 2.94 MPG more fuel than an automatic transmission vehicle.

# Linear Prediction Model Assignment:

Exploratory Data Analysis:
The data set is explored using dim(mtcars), sapply(mtcars, class), head(mtcars), summary(mtcars) to assess the dataframe size, structure, variable (11) and observation (32) entries, and basic mean, median, min, max and quantile values.

The data exploration is expanded considering four rough plots to assess the MPG to Transmission Type and MPG to Cylinder Alignment relationship making use of a scatter and box plot. For this assignment the scope has been expanded to include engine cylinder arrangement (V-type or straight). It is evident that there is a significant difference in the magnitude of MPG per Transmission Type for the automatic ("0") compared to manual ("1") transmission with the former having values around 17 MPG and the latter values around 23 MPG.

Regression Analysis:
Two obvious models can be evaluated. A [1] model considering all the variables considered during the MPG tests, and [2] a model only containing either the vehicle's transmission type, or cylinder arrangement. For the former it is critical to get rid of confounding variables which can be obtained by a "best fit" model stepping automatically through each of the variables and performing elimination on AIC score.

[1] fit1 <- lm(mpg ~ am, data = mtcars) or fit1 <- lm(mpg ~ sv, data = mtcars)    
[2] fit2 <- lm(mpg ~ ., data = mtcars) followed by fit2 <- step(fit2, direction = "both")

Model Comparison, Diagnostics, and Statistical Inference:
From the R-squared data fit it is clear that the comprehensive model has a much better fit at 0.8497 than the single variable model fit with an R-square at 0.3598.
And, the manual transmission type vehicles uses nearly 2.94 times the amount of fuel used by the automatic vehicles.

As well, an anova comparison of the two models reveal the p-value is significant enough to reject the hypothesis that variables other than vehicle transmission do not contribute to the validity / accuracy of the model.

Furthermore a t-test supports the observations during the Exploratory Data Analysis, that the manual vehicles (designator "1") has a mean MPG at 24.39 and the automatic vehicles (designator "0") a mean at 17.15.

Model Residuals:
Residual versus Fitted values in graphs show large scatter with no distinct pattern which is indicative of a reasonable model fit.
The Q-Q Standard Residuals versus Theoretical Quantiles mostly follow a linear trend in the middle section with some deviation at the bottom and most the top.
Scale-location plots also suggest no particular trends supporting an acceptable model fit.
The Standard residuals versus Leverage plot also shows large scatter.
In general the residuals support the model fit.

# How to operate Application

The App is simple. It has two radio buttons and a blue run model button at the bottom of the side panel.

On loading the App ten radio buttons are observed in the side panel with which the 'predictor' variable for Model Fit 1 can be varied. This is a deviation from the earlier project in that only vehicle transmission type was considered as predictor during the Regression Analysis Assignment.

The 10 radio buttons represent: cyl= Number of cylinders, disp= Displacement (cu.in.), hp= Gross horsepower, drat= Rear axle ratio, wt= Weight (1000 lbs), qsec= 1/4 mile time, vs= enigne valve alignment, am= Transmission (0 = automatic, 1 = manual), gear= Number of forward gears, carb= Number of carburetors. Detalied information on the mtcars data set can be obtained by passing ?mtcars at the R-console prompt.

IT IS IMPORTANT TO NOTE THAT AFTER EACH RADIO BUTTON CHOICE SELECTION THE BLUE 'RUN MODEL !' BUTTON SHOULD BE CLICKED, TO ACTIVATE THE CHANGES.

The main page offers eight tabs. The first two considers Exploratory Data Analysis, giving an overview of data file size, data set dimensions, variable class, and overview of the first six lines of data, a summary of the data set, and four plots evaluating the fuel usage (as miles per gallon (mpg) versus transmission type (top two plots) and cylinder arrangement (bottom two plots).

The next couple of tabs give model fit summaries. The first for a linear model fit between 'mpg as outcome' and the predictor selected from the radio button selection in the side panel. A scatter plot of the data is also given. The second considers Model Fit 2 where all the predictor variables, listed on the Exploratory Data Analysis tab, are fitted. In this case it is critical to get rid of any confounding variables. This can be done by determining a 'Best fit' model, stepping automatically through each of the predictor variables and performing variable elimination on AIC score. The final outcome is an AIC score pointing to vehicle weight (wt), time over the quarter mile (qsec), and transmission (am) to be the most significant model predictors.

Model Fit 3 is the model run using only the three most suitable predictors from the AIC score accompanied by a residual plot. The result is also backed up by an ANOVA plot and t-test on the next tab as well as a set of residual versus fitted values under the QQ Plot tab. Take note, for the two project questions posted above, and the description given on the "ANOVA" tab, the radio button selection must be set to "am" (vehicle transmission type).





