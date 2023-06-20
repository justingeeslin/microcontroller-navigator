#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Microcontroller Finder"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            checkboxGroupInput("connectivity", 
                               "Connectivity:",
                               c(
                                 "Bluetooth" = "bluetooth",
                                 "WiFi" = "wifi"
                               ))
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
          tableOutput("myTable")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  output$myTable <- renderTable({
    # Set the file path to your CSV file
    file_path <- "microcontrollers.csv"
    
    # Read the CSV file
    data <- read.csv(file_path)
    
    if ("wifi" %in% input$connectivity) {
      data <- subset(data, WiFi == TRUE)  
    }
    if ("bluetooth" %in% input$connectivity) {
      data <- subset(data, Bluetooth == TRUE)  
    }
    
    # Return the data frame
    data
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
