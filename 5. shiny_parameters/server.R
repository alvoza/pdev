#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
    
    observe({
        bins <- input$bins
        color <- input$set_col
        hostname <- session$clientData$url_hostname
        protocol <- session$clientData$url_protocol 
        port <- session$clientData$url_port
        query <- paste('?bins=', bins, '&color=', color, sep = '')
        
        url <- paste(protocol, '//', hostname, ':', port, '/',query, sep = '')
        updateTextInput(session, 'url_param', value = url)
    })
    
    observe({
        query <- parseQueryString(session$clientData$url_search)
        bins <- query[['bins']]
        bar_col <- query[['color']]
        
        if(!is.null(bins)){
            updateSliderInput(session, 'bins', value = as.numeric(bins))
        }
        if(!is.null(bar_col)){
            updateSelectInput(session, 'set_col', selected = bar_col)
        }
        
    })

    output$distPlot <- renderPlot({
        x    <- faithful[, 2]
        #my_color= ifelse (x>input$mouse_brush$xmin & x<input$mouse_brush$xmax, "purple", rgb(0.2,0.2,0.2,0.2), ifelse(is.null(input$mouse_brush$xmin,col = input$set_col)))
        if(is.null(input$mouse_brush$xmin )){
            hist(x, breaks = input$bins, col=input$set_col, border = 'white')
        }
        else{
            my_color= ifelse(x>input$mouse_brush$xmin & x<input$mouse_brush$xmax, "purple", input$set_col)
            #x>input$mouse_brush$xmin & x<input$mouse_brush$xmax, "purple"
            h <- hist(x, breaks = input$bins, col=my_color, border = 'white')
            
            cuts <- .bincode(x, h$breaks, c(-Inf,x>input$mouse_brush$xmin,x<input$mouse_brush$xmax,Inf))
            plot(h, col=my_color)
        }
        

    })
    
    output$click_data <- renderPrint({
        rbind(c(input$clk$x, input$clk$y),
              c(input$dclk$x, input$dclk$y),
              c(input$mouse_hover$x, input$mouse_hover$y), 
              c(input$mouse_brush$xmin, input$mouse_brush$ymin),
              c(input$mouse_brush$xmax, input$mouse_brush$ymax))
    })
    
    observeEvent(input$clk, {
        updateSelectInput(session, 'set_col', selected = 'green')
    })
    
    observeEvent(input$mouse_hover, {
        updateSelectInput(session, 'set_col', selected = 'darkgray')
    })
    
    observeEvent(input$dclk, {
        updateSelectInput(session, 'set_col', selected = 'white')
    })
    
    observeEvent(input$mouse_brush, {
        # browser()
        x = faithful[, 2]
        selectedRange = x[x>input$mouse_brush$xmin & x<input$mouse_brush$xmax]
        print(selectedRange)
        output$distPlot2 <- renderPlot({
            hist(selectedRange, breaks = input$bins, col = input$set_col, border = 'white')
            })
    })

})
