#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),
    tabsetPanel(tabPanel("Ejemplo1", 
                         numericInput("min", "limite inferior", value = 5),
                         numericInput("max", "limite superior", value = 10), 
                         sliderInput("slider_eje1", "seleccione intervalo", 
                                     min = 0, max = 15, value = 5)
                         ),
                tabPanel("Ejemplo2", 
                         sliderInput("s1", "s1", value = 0, min = -5, max = 5),
                         sliderInput("s2", "s2", value = 0, min = -5, max = 5),
                         sliderInput("s3", "s3", value = 0, min = -5, max = 5),
                         sliderInput("s4", "s4", value = 0, min = -5, max = 5),
                         actionButton('clean', 'limpiar')),
                tabPanel("Ejemplo3", 
                         numericInput('n', "corridas", value = 10),
                         actionButton('correr', 'limpiar'))
                )
))
