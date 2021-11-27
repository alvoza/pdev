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
    titlePanel("Interacciones usuario con graficas"),
    
    tabsetPanel(
        tabPanel('plot', 
                 h1('graficas en shiny'),
                 plotOutput("grafica_base_r"),
                 plotOutput("grafica_ggplot")), 
        tabPanel('Clicks plots', 
                 plotOutput("plot_click_options", 
                            click = 'clk', 
                            dblclick = 'dclk', 
                            hover = 'mouse_hover', 
                            brush = 'mouse_brush'), 
                 verbatimTextOutput("click_data"),
                 actionButton('showall', 'Show All'),
                 DT::dataTableOutput(
                     'mtcars_tabl'
                 )
                 )
    )

))
