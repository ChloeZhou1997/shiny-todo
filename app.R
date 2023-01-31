library(shiny)

ui <- fluidPage(
 titlePanel("Hi there!"),
 
 sidebarLayout(
   sidebarPanel(
     h3("Daily Todo"),
     checkboxInput("checkbox","Submit One Job Application"),
     textInput("text", label = "Other things done"),
     textInput("text", label = "Key things learnt"),
     dateInput("date", label = "Date competed"),
     actionButton("submit", label = "Submit")),
   
   mainPanel(
     h1("What I have done",align = "center"),
     h2(textOutput("selected_var"), align = "center"),
     br(),
     p("I am trying to build an interactive ", span("todo list", style = "color:blue"), "Using Shiny."),
     p("Please do", strong("consider", style = "color:red"),"my application if applicants who knows Shiny are strongly prefered!", style = "background:yellow"),
     h1("What have I done", align = "center"),
     h2(textOutput("selected_var"),align = "center"),
     tags$ul(
       tags$li("Always pair an output with a", code("render*"))
     ))
   )
)

server <- function(input, output){
  output$selected_var <- renderText(
    {"today"}
  )
}

shinyApp(ui = ui, server = server)