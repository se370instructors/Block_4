shinyUI(fluidPage(
  plotOutput(outputId = "myplot", height = "300px"),
  selectInput(inputId = "xAxis", label = 'Select x axis variable',
              choices = colnames(mtcars)),
  selectInput(inputId = "yAxis", label = 'Select y axis variable',
              choices = colnames(mtcars)),
  sliderInput(inputId = 'pointSize', label = 'Slide to change the point size',
              min = 1, max = 10, value = 2)
))

