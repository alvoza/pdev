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
shinyServer(function(input, output) {
    
    observeEvent(input$showall, {
        output$mtcars_tabl <- DT::renderDataTable({
            mtcars %>% DT::datatable( 
                                     filter = 'top', 
                                     extensions = 'Buttons', 
                                     options = list(
                                         pageLength = 5, 
                                         lengthMenu= c(5, 19,15),
                                         buttons = c('csv')
                                     ))
        })
    })
    
    
    output$grafica_base_r <- renderPlot({
        plot(mtcars$wt, mtcars$mpg, 
             xlab = "wt", ylab = "Millas por galon")
    })
    
    output$grafica_ggplot <- renderPlot({
        diamonds %>%
            ggplot(aes(x=carat, y = price, color = color))+
            geom_point() +
            ylab('Precio') +
            xlab('Kilates') +
            ggtitle("Precio de diamantes por kilate")
    })
    
    output$plot_click_options <- renderPlot({
        plot(mtcars$wt, mtcars$mpg, 
             xlab = "wt", ylab = "Millas por galon")
    })
    
    output$click_data <- renderPrint({
        rbind(c(input$clk$x, input$clk$y),
        c(input$dclk$x, input$dclk$y),
        c(input$mouse_hover$x, input$mouse_hover$y), 
        c(input$mouse_brush$xmin, input$mouse_brush$ymin),
        c(input$mouse_brush$xmax, input$mouse_brush$ymax))
    })
    
    observeEvent(input$mouse_brush, {
        df <- brushedPoints(mtcars, input$mouse_brush, xvar = 'wt', yvar = 'mpg')
        output$mtcars_tabl <- DT::renderDataTable({
            #df <- nearPoints(mtcars, input$clk, xvar = 'wt', yvar = 'mpg')
            
            df
        })
        
        output$plot_click_options <- renderPlot({
            plot(mtcars$wt, mtcars$mpg, xlab = "wt", ylab = "Millas por galon")
            points(df$wt, df$mpg, col = 'green')
        })
    })
    
    observeEvent(input$clk, {
        df <- nearPoints(mtcars, input$clk, xvar = 'wt', yvar = 'mpg')
        output$mtcars_tabl <- DT::renderDataTable({
            df
        })
        
        output$plot_click_options <- renderPlot({
            plot(mtcars$wt, mtcars$mpg, xlab = "wt", ylab = "Millas por galon")
            points(df$wt, df$mpg, col = 'green')
        })
    })
    
    observeEvent(input$mouse_hover, {
        df <- nearPoints(mtcars, input$mouse_hover, xvar = 'wt', yvar = 'mpg')
        
        output$plot_click_options <- renderPlot({
            plot(mtcars$wt, mtcars$mpg, xlab = "wt", ylab = "Millas por galon")
            #points(df$wt, df$mpg, col = 'gray')
        })
    })
    
    observeEvent(input$dclk, {
        df <- nearPoints(mtcars, input$dclk, xvar = 'wt', yvar = 'mpg')
        
        output$plot_click_options <- renderPlot({
            plot(mtcars$wt, mtcars$mpg, xlab = "wt", ylab = "Millas por galon")
            points(df$wt, df$mpg, col = 'white')
        })
    })

})
