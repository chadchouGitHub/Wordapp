




##-------------------------------shyniUI mail code area----------------------------------------
shinyUI(fluidPage(
        titlePanel("Shiny App: Predicting your next word."),
        
        sidebarLayout(
                sidebarPanel(
                        helpText("Please type words in the text input box."),
                        
                        textInput("inText", label = h3("Text input"), 
                                  value = "Enter text you text"),
                        br(),
                        actionButton("goButton", "Go!"),
                        p("Click the button to update the value displayed in the main panel.")),
                
                mainPanel(
                        helpText("Your Next Word is......."),
                        textOutput("text1"))
        )
        
))

##-------------------------------shyniUI mail code area----------------------------------------



