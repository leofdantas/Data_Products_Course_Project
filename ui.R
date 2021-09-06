data <- readRDS("data/Approval_Sentiment_AllPresidents.rds")

shinyUI(fluidPage(
    # Application title
    titlePanel("Correlating Media Sentiment and Presidential Approval in Brazil"),
    br(),
    h3("Introduction"),
    h5("Here I show the correlation between the monthly sentiment (positivity/negativity) 
    of the Brazilian media when talking about its Presidents and the approval of these leaders 
       during these months"),
    br(),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            # Dropdown Menu
            selectInput(inputId = "DropMenu",
                        label = "President to be Analyzed",
                        choices = c(unique(data$Presidente), "All"),
                        selected = "All"),
            checkboxInput("ShowReg", "Show Regression Model", value = TRUE)
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            h3("Media Sentiment and Approval Rate"),
            plotOutput("plot"),
            h3("Regression for Selected model"),
            htmlOutput("Regression")
        )
    ),
    br(),
    h3("Observations"),
    h5("This data is a very good example of how the Simpson's Paradox can be seen on Political Science. 
    If we look at the model of the three presidents together, there seems to be a (significant) positive
    correlation between the positivity of the media regarding the presidents and their approval 
    coming from the citizens. However, if we look at each individual president, the same correlation is no 
    longer significant. In fact, it even turned out to be negative for Bolsonaro."),
    h5("This happens because the approval rates for the presidents were very different from each other. The 
       positive correlation we see is just a reflection of this innate variation. The positivity of the media, 
       for each president, does not seem to play a factor at all."),
))
