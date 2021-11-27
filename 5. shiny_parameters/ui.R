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

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel( 
            sliderInput('bins', 
                        'Numero Bins', 
                        min = 1, 
                        max = 50, 
                        value = 30),
            selectInput('set_col',
                        'escoger color: ',
                        choices = c('aquamarine', 'blue', 'blueviolet', 
                                    'darkgray', 'chocolate', 'green', 'white'), 
                        selected = 'darkgray'), 
            textInput('url_param', "Marcador", value = "")
    ),
    mainPanel(
        plotOutput('distPlot', 
                   click = 'clk', 
                   dblclick = 'dclk', 
                   hover = 'mouse_hover', 
                   brush = 'mouse_brush'),
        verbatimTextOutput("click_data"),
        plotOutput('distPlot2')
    ))
))
