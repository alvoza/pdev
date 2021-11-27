
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {

    observeEvent(input$min, {
        updateSliderInput(session, "slider_eje1", min = input$min)
    })
    
    observeEvent(input$max, {
        updateSliderInput(session, "slider_eje1", max = input$max )
    })
    
    observeEvent(input$clean, {
        updateSliderInput(session, 's1', value = 0)
        updateSliderInput(session, 's2', value = 0)
        updateSliderInput(session, 's3', value = 0)
        updateSliderInput(session, 's4', value = 0)
    })
    
    observeEvent(input$n, {
        if(is.na(input$n)){
            label <- paste0('correr ')
        }else if(input$n > 1){
            label <- paste0('correr ', input$n, ' veces')
        }
        else if((input$n == 1)){
            label <- paste0('correr ', input$n, ' vez')
        }
        else{
            label <- paste0('correr ')
        }
        updateActionButton(session, 'correr', label = label)
    })

})
