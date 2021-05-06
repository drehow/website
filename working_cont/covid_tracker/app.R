#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(readr)
library(ggplot2)

states <- read_csv('https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv')
ok <- states[states$state=='Oklahoma',]

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Oklahoma Covid Cases"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
     ggplot(ok) + 
       geom_line(aes(date, cases))
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

