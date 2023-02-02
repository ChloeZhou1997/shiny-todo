library(shiny)
library(bslib)

ui <- fluidPage(
  theme = bs_theme(version = 4, bootswatch = "sketchy"),
  navbarPage("DEMOS",
         tabPanel("TODO App",
                  sidebarLayout(
                    sidebarPanel(
                      
                      # Date configuration
                      dateInput("date", label = "Date Configuration"),
                      
                      # Things to do 
                      
                      h3("Daily To Do", id="start", style = "color:darkgery", align = "center"),
                      checkboxGroupInput("checkbox", label = "", choices = c()),
                      textInput("todo", label = "Things I want to do"),
                      actionButton("todoBnt", class = "btn btn-primary btn-sm", label = "Submit"),
                    
                      br(),
                      br(),
                      
                      # Things Learnt
                      
                      textInput("learnt", label = "Key things learnt"),
                      actionButton("learntBnt", label = "Submit")),
                    
                    mainPanel(
                      
                      h1(textOutput("timing"), align = "center"),
                      h1("What have I done", id = "havedone", align = "center"),
                      verbatimTextOutput("value"),
                      h1("What have I learnt", id = "havelearnt", align = "center"),
                      tags$div(
                        tags$ul( id = "list",
                        )
                      ),
                      
                      br(),
                      tags$div(class = "alert alert-dismissible alert-success",
                               br(),
                               p("Update on 2023-02-01, 8:20pm:", style = "color: black"),
                               p("Hi, this is the *FINAL* version of a simple interactive ", span("Todo list", style = "color:darkblue"), "Using Shiny-R.", class = "text-success"),
                               p("While I do have experience in using React to build web application, my experience in Shiny-R is limited."),
                               p("To demonstrate I am a quick learner to new language and tools, and build project based on demands"),
                               p("This small project starts on 2023-01-30, and now you can"),
                               tags$div(
                                 tags$ul(
                                   tags$li("Submit things you want to do to generate a checkbox"),
                                   tags$li("Submit things you have learnt to generate a list"),
                                   tags$li("Configurating the data that will appear at the title"),
                                   tags$li("Check the todo list and have the completed task appear on the right")
                                 )
                               ),
                               p("Please still", strong("consider", style = "color:red"),"my application if only applicants who know Shiny are strongly preferred!", class = "text-danger")
                      ))
                  )
                )
         )


)

server <- function(input, output) {
  
  choices <- reactiveVal()
  
  observeEvent(input$todoBnt, {
    
    if(nchar(input$todo)>0){
    
    selected <- choices()[choices() %in% input$checkbox]
    choices(c(choices(), input$todo))
    updateCheckboxGroupInput(inputId = "checkbox", choices = choices(), selected = selected)
    updateTextInput(inputId = "todo", value = "")}
    
      })

    
  observeEvent(input$learntBnt, {
    
    if( nchar(input$learnt) > 0){
      
      insertUI(
        selector = "#list",
        where = "beforeEnd",
        ui = tags$li(input$learnt)
      )
      
      updateTextInput(inputId = "learnt", value = "")
    }
  })

  output$timing <- renderText({ 
    paste0("Today is ", as.character(input$date))
  })

  output$value <- renderText({ 
    paste("> ",input$checkbox, collapse = "\n")
  })
  
}

shinyApp(ui = ui, server = server)