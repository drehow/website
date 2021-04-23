#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
x <- NA
# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   # titlePanel("Old Faithful Geyser Data"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        actionButton("left_join", "Left"),
        actionButton("right_join", "Right"),
        actionButton("inner_join", "Inner"),
        actionButton("full_join", "Outer / Full")
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         # plotOutput("distPlot")
         verbatimTextOutput('message_1')
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  
    

  observeEvent(input$left_join, {
    x <<- 'left'
  })
  
  
  
  output$message_1 <- renderText({
    x
  })
  
   # output$distPlot <- renderPlot({
   #    # generate bins based on input$bins from ui.R
   #    x    <- faithful[, 2] 
   #    bins <- seq(min(x), max(x), length.out = input$bins + 1)
   #    
   #    # draw the histogram with the specified number of bins
   #    hist(x, breaks = bins, col = 'darkgray', border = 'white')
   # })
}

# Run the application 
shinyApp(ui = ui, server = server)

