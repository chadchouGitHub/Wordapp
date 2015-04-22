
source('wordHelper.R')
##--------------------code above here will run only once in shiny-----------------------
shinyServer(
        function(input, output) {
                ## -----another place for code-----
                ntext <- eventReactive(input$goButton, {
                        input$inText
                })
                output$text1 <-renderText({paste(
                        predictW(ntext()))}) ## get inText to convert to lower case
 
         
                
        }
)