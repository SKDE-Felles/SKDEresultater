library(shiny)

shinyUI(function(request) {
  ui <- fluidPage(theme = shinythemes::shinytheme("cerulean"),
                  titlePanel(tags$head(
                    tags$link(rel = "icon", type = "image/png", href = "hn.png"),
                    tags$title("SKDE"),
                    tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
                  )),
                  fluidRow(
                    column(3,
                           uiOutput("pick_bo"),
                           uiOutput("pick_dates"),
                           uiOutput("git_version")
                    ),
                    column(9,
                           plotOutput("plot")
                    )
                  )
)})
