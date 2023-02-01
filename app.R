library(shiny)
library(bslib)

ui <- fluidPage(
  theme = bs_theme(version = 4, bootswatch = "sketchy"),
  titlePanel("A simple todo App"),

  sidebarLayout(
    sidebarPanel(
      
      # Date configuration
      dateInput("date", label = "Date Configuration"),
      
      # Things to do 
      
      h3("Daily To Do", id="start", style = "color:darkgery", align = "center"),
      div(
        class = "form-group mb-3",
        textInput("todo", label = "Things I want to do"),
        actionButton("todoBnt", class = "btn btn-primary btn-sm", label = "Submit")),
      br(),
      textInput("learnt", label = "Key things learnt"),
      actionButton("learntBnt", label = "Submit")),
    
    mainPanel(
      
      h1(textOutput("timing"), align = "center"),
      # h1("What have I done", id = "havedone", align = "center"),
      h1("What have I learnt", id = "havelearnt", align = "center"),
      tags$div(
        tags$ul( id = "list",
          
        )
      ),
      
      br(),
      tags$div(class = "alert alert-dismissible alert-success",
               br(),
               p("Hi, I am building a simple interactive ", span("Todo list", style = "color:darkblue"), "Using Shiny-R.", class = "text-success"),
               p("While I do have experience in using React to build web application,"),
               p("My experience in Shiny-R is limited,"),
               p("To demonstrate I am a quick learner to new language and tools, and build project based on demands"),
               p("This small project starts on 2023-01-30, and now you can"),
               tags$div(
                 tags$ul(
                   tags$ol("Submit things you want to do to generate a checkbox"),
                   tags$ol("Submit things you have learnt to generate a list"),
                   tags$ol("Configurating the data that will appear at the title")
                 )
               ),
               p("Please", strong("consider", style = "color:red"),"my application if only applicants who know Shiny are strongly preferred!", class = "text-danger")
      ))
  )
)

server <- function(input, output) {
  
  observeEvent(input$todoBnt, {
    
    print(input$checkbox)
    
    name <- paste0("checkbox",gsub(" ","",input$todo))

    if( nchar(input$todo) >0 ){insertUI(
      selector = "#start",
      where = "afterEnd",
      ui = checkboxInput(name,input$todo)
    )}
  })

    
  observeEvent(input$learntBnt, {
    print("triggered")
    
    if( nchar(input$learnt) > 0){
      
      insertUI(
        selector = "#list",
        where = "beforeEnd",
        ui = tags$li(input$learnt)
      )
    }
  })

  output$timing <- renderText({ 
    paste0("Today is ", as.character(input$date))
  })
  
  output$value <- renderText({ input$checkbox })
  
}

shinyApp(ui = ui, server = server)