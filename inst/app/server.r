# Settings before server session starts

if (file.exists("data/data.RData")) {
  # load information sent through "launch_application"
  load("data/data.RData")
}

shiny::shinyServer(
  function(input, output) {

    if (!exists("app_data")) {
      app_data <- NULL
    }

    if (!exists("git_hash")) {
      git_hash <- NULL
    }

    if (!exists("github_repo")) {
      github_repo <- NULL
    }

    if (isTRUE(getOption("shiny.testmode"))) {
      # Load static/dummy data if this is a test run
      app_data <- SKDEresultater::testdata
    }

    output$plot_kvalitet <- shiny::renderUI({
      if (length(input$valgtBo) == 0) {
        return(NULL)
      } else {
        plotly::plotlyOutput("plotly_plot")
      }
    })

    output$plot_variasjon <- shiny::renderUI({
      plotly::plotlyOutput("heatmap", width = "auto", height = "800px")
    })

    output$heatmap <- plotly::renderPlotly({
      SKDEresultater::create_heatmap(data = variasjon_data())
    })

    variasjon_data <- shiny::reactive({
      if (input$valgtVariasjon == "Gynekologi") {
        return(data::gyn)
      } else if (input$valgtVariasjon == "Fødselshjelp") {
        return(data::fodsel)
      } else if (input$valgtVariasjon == "Dagkirurgi") {
        return(data::dagkir2)
      } else if (input$valgtVariasjon == "Kols") {
        return(data::kols)
      } else if (input$valgtVariasjon == "Barn") {
        return(data::barn)
      } else if (input$valgtVariasjon == "Nyfødt") {
        return(data::nyfodt)
      } else if (input$valgtVariasjon == "Eldre") {
        return(data::eldre)
      } else if (input$valgtVariasjon == "Ortopedi") {
        return(data::ortopedi)
      }
      return(NULL)
    })

    output$pick_kvalitet <- shiny::renderUI({
      mulige_valg <- as.character(unique(SKDEresultater::testdata$bohf))
      shinyWidgets::radioGroupButtons(
        inputId = "valgtKvalitet",
        choices = c("Trombolyse", "Hofteprotese"),
        justified = TRUE
      )
    })

    output$pick_variasjon <- shiny::renderUI({
      shinyWidgets::radioGroupButtons(
        inputId = "valgtVariasjon",
        choices = c("Fødselshjelp",
                    "Gynekologi",
                    "Ortopedi",
                    "Dagkirurgi",
                    "Kols",
                    "Eldre",
                    "Nyfødt",
                    "Barn"),
        justified = TRUE
      )
    })

    output$plotly_plot <- plotly::renderPlotly({
      if (input$valgtKvalitet == "Trombolyse") {
        mydata <- SKDEresultater::testdata
        data_to_plot <- dplyr::filter(mydata, mydata$bohf %in% input$valgtBo)
      } else {
        return(NULL)
      }
      return(SKDEresultater::dotplot(data_to_plot = data_to_plot,
                                     all_data = mydata,
                                     ref_line = 30
      )
      )
    })

    bo_picker <- shiny::reactive({
      mulige_valg <- c("Finnmark", "UNN", "Nordland", "Helgeland")
      shinyWidgets::checkboxGroupButtons(
        inputId = "valgtBo",
        choices = mulige_valg,
        justified = TRUE,
        checkIcon = list(yes = icon("ok", lib = "glyphicon"), no = icon("remove", lib = "glyphicon"))
      )
    })

    output$pick_bo <- shiny::renderUI({
      bo_picker()
    })
  }
)
