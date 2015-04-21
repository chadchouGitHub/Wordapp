
source('wordHelper.R')
##--------------------code above here will run only once in shiny-----------------------
shinyServer(
        function(input, output) {
                ## -----another place for code-----
                output$text1 <-renderText({paste(
                        predictW(input$inText))}) ## get inText to convert to lower case
 
         
                
        }
)