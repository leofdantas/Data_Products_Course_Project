

shinyServer(function(input, output) {
    # Load Libraries
    library(shiny)
    library(ggplot2)
    library(dplyr)
    library(sjPlot)
    
    # Load Data
    data <- readRDS("data/Approval_Sentiment_AllPresidents.rds")
    names(data)[3] <- "Positive"
    names(data)[4] <- "Neutral"
    names(data)[5] <- "Negative"
    
    ### Interpret Inputs ###
    # Select President Given Input
    President <- reactive({
        Input_DropMenu <- input$DropMenu
    })
    
    ### Set Regression Model ###
    model <- reactive({
        if (President() == "All") {
            paste(unlist(tab_model(summary(lm(Positive ~ monthly_score, data = data))))[1:2], collapse = "")
        } else if (President() != "All") {
            paste(unlist(
            tab_model(summary(lm(Positive ~ monthly_score, data = data[data$Presidente %in% President(),])))
            )[1:2], collapse = "")
        }
    })
    
    ### Define Outputs ###
    # Plotting
    output$plot <- renderPlot({
        # If All Presidents
        if (President() == "All") {
            ggplot(data, aes(x = monthly_score, y = Positive)) +
                geom_point() +
                ylab("Positive Approval Rate") +
                xlab("Average Monthly Sentiment Score") +
                geom_smooth(method = "lm")
        # If Specific President
        } else if (President() != "All") {
            ggplot(data[data$Presidente %in% President(),], aes(x = monthly_score, y = Positive)) +
                geom_point() +
                ylab("Positive Approval Rate") +
                xlab("Average Monthly Sentiment Score") +
                geom_smooth(method = "lm")
        }
    })
    
    # Output Regression Table
    output$Regression <- renderText({
        if(input$ShowReg){
            model()
            }
        })
    })

