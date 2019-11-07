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

    output$git_version <- shiny::renderUI({
      if (!is.null(git_hash)) {
        if (is.null(github_repo)) {
          version_num <- substr(git_hash, 1, 8)
        } else {
          version_num <- paste0("<a href='https://github.com/",
                                github_repo,
                                "/tree/",
                                git_hash,
                                "'>",
                                substr(git_hash, 1, 8),
                                "</a>")
        }
        # Hash on web page, if given
        return(shiny::HTML(paste0("Versjon: ", version_num)))
      } else {
        return("Versjon 0.3.1")
      }
    })

    output$plot <- plotly::renderPlotly({
      if (length(input$valgtBo) == 0) {
        return(NULL)
      }
      if (input$valgtKvalitet == "Trombolyse") {
        mydata <- SKDEresultater::testdata
        data_to_plot <- dplyr::filter(mydata, mydata$bohf %in% input$valgtBo)
      } else {
        return(NULL)
      }
      if (!isTRUE(getOption("shiny.testmode"))) {
        return(SKDEresultater::dotplot(data_to_plot = data_to_plot,
                                       all_data = mydata,
                                       ref_line = 30
                                       )
        )
      }
    })

    data_to_plot <- shiny::reactive({
      if (input$valgtKvalitet == "Trombolyse") {
        return(SKDEresultater::testdata)
      } else {
        return(NULL)
      }
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
        choices = c("Oversikt", "Gynekologi", "Fødselshjelp", "Dagkirurgi"),
        justified = TRUE
      )
    })


    bo_picker <- reactive({
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

    output$pick_bo2 <- shiny::renderUI({
      bo_picker()
    })

  }
)
