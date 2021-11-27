 #
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(lubridate)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Titulo del App"),
    sidebarLayout(
        sidebarPanel(
            fileInput("cargar_archivo", "Cargar archivo",
                      buttonLabel = "Seleccionar",
                      placeholder = "No hay archivo seleccionado"), 
            dateRangeInput('fechas', "Seleccione Fechas", 
                           start = ymd('1900-01-05'), 
                           end = ymd('2007-09-30'), 
                           min = ymd('1900-01-05'), 
                           max = ymd('2007-09-30')),
            downloadButton("download_dataframe", "Descargar Archivo") 
        ),
        mainPanel(
             DT::dataTableOutput("contenido_archivo") 
        )
    )
 
))
