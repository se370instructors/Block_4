library(ggplot2) 
shinyServer(function(input, output) {
  output$myplot <- renderPlot({
    ggplot(data = mtcars, aes_string(x = input$xAxis, y = input$yAxis)) +
      geom_point(size = input$pointSize) + theme_minimal()
  })
})