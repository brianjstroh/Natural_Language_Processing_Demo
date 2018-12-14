library(shiny)
library(shinyjs)

loadingCSS <- "
#loading-content {
position: absolute;
background: #000034;
opacity: 0.9;
z-index: 100;
left: 0;
right: 0;
height: 100%;
text-align: center;
color: #FFFFFF;
}
"
shinyUI(fluidPage(
      style = "background: #000034;
                    color: #FFFFFF",
      useShinyjs(),
      
      div(id = "loading-content",
            inlineCSS(loadingCSS),
            br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),
            h2("Loading, please wait...")),
      
      
      hidden(
            div(id = "my-content",
                  h1(strong("Predict Next NLP Demo")),
                  h4("Author: ",em("Brian Stroh")),
                  h4("Date: ",em("December 13th, 2018")),
                  br(),
                  pageWithSidebar(
                        headerPanel(title = "",windowTitle = "Predict Text"),
                        sidebarPanel(
                              style = "color: #000000",
                              textInput("phrase","Input phrase: ",""),
                              br(),
                              sliderInput("num_suggestions", "Number of Suggestions:", value = 5, min = 1, max = 18, step = 1),
                              br(),
                              p(strong("Stumped? Try these!")),
                              br(),
                              p(em("Never put off")),
                              p(em("If at first")),
                              p(em("Do unto")),
                              p(em("The apple doesn't")),
                              p(em("If you're happy")),
                              p(em("A bird")),
                              p(em("A rose by")),
                              p(em("Early to bed")),
                              p(em("Pizza makes")),
                              p(em("We wish")),
                              p(em("Let me"))
                              #actionButton("submit", "Predict Next") <- Don't need this because of reactive table values.
                        ),
                        mainPanel(
                              tabsetPanel(
                                    tabPanel("Predict Next Word",
                                          tableOutput("words")),
                                    tabPanel("About",
                                          p("This tool uses Natural Language Processing to predict the next word that the user types."),
                                          p("The model used is a layered n-gram model with greater discounts being given to the probabilities of the lower n-grams."),
                                          p("The raw text for this model comes from Swiftkey via Coursera."),
                                          p("Profane words and non-english words were removed from the raw text and contractions were replaced by their full phrases."),
                                          p("The processed text was then tokenized and grouped to n-grams using the 'quanteda' R package."),
                                          br(),
                                          br(),
                                          p("More on Natural Language Processing can be found here: "),
                                          tags$a(href="https://en.wikipedia.org/wiki/Natural_language_processing", "Natural Language Processing"),
                                          br(),
                                          br(),
                                          p("More on n-grams can be found here: "),
                                          tags$a(href="https://en.wikipedia.org/wiki/N-gram", "N-Grams"),
                                          br(),
                                          br(),
                                          p("Files used to develop this app can be found here: "),
                                          tags$a(href="https://github.com/brianjstroh/Natural_Language_Processing_Demo", "GitHub Repo")),
                                    
                                    tabPanel("Credits",
                                          p("Swiftkey's raw text can be found here: "),
                                          tags$a(href="https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip", "Text Zip File (very large)"),
                                          br(),
                                          br(),
                                          p("Quanteda's documentation can be found here: "),
                                          tags$a(href="https://doi.org/10.21105/joss.00774", "Quantitative Analysis of Textual Data"),
                                          br(),
                                          br(),
                                          p("Credits for the loading screen go to: "),
                                          tags$a(href="https://deanattali.com/blog/advanced-shiny-tips/","Dean Attali"),
                                          br(),
                                          br(),
                                          p("More of Brian's projects can be found here: "),
                                          tags$a(href="https://github.com/brianjstroh", "Brian Stroh's Projects"))
                                          
                              )
                        )
                  ),
                  p(em("Please close this page when you are finished."))
            )
      )
))
