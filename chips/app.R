
library(shiny)
library(tidyverse)
library(plotly)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectizeInput("type",
                           selected = c("CPU", "GPU"), 
                           choices = c("CPU", "GPU"),
                           label = "Types",
                           multi = TRUE)
            ), 
        
        # Show a plot of the generated distribution
        mainPanel(
           plotlyOutput("chipsPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$chipsPlot <- renderPlotly({
        chips |> 
        filter( type %in% input$type) |> 
        ggplot(aes(release_date, transistors_million)) +
        geom_point() + 
       geom_smooth(method = "loess") +
        scale_y_log10() +
        labs(x = "Chip release date", 
             y = "# of transistors (millioins)")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
