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
      mydata <- SKDEresultater::testdata
      data_to_plot <- dplyr::filter(mydata, mydata$bohf %in% input$valgtBo)
      if (!isTRUE(getOption("shiny.testmode"))) {
        return(SKDEresultater::dotplot(data_to_plot = data_to_plot,
                                       all_data = mydata,
                                       ref_line = 30
                                       )
        )
      }
    })

    output$pick_bo <- shiny::renderUI({
      mulige_valg <- as.character(unique(SKDEresultater::testdata$bohf))
      shinyWidgets::checkboxGroupButtons(
        inputId = "valgtBo",
        choices = mulige_valg,
        justified = TRUE,
        checkIcon = list(yes = icon("ok", lib = "glyphicon"), no = icon("remove", lib = "glyphicon"))
      )
    })

  }
)
