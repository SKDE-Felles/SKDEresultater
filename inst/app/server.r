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
        return("Versjon 0.1.0")
      }
    })

    output$plot <- plotly::renderPlotly({
      mydata <- SKDEresultater::testdata
      data_to_plot <- dplyr::filter(mydata, mydata$bohf %in% input$valgtBo)
      if (!isTRUE(getOption("shiny.testmode"))) {
        return(SKDEresultater::dotplotly(data_to_plot = data_to_plot,
                                       all_data = mydata,
                                       ref_line = 30,
                                       xmin = min(req(input$valgtDato)),
                                       xmax = max(req(input$valgtDato))
                                       )
        )
      }
    })

    output$pick_dates <- shiny::renderUI({
      shiny::sliderInput("valgtDato",
                         "Datoer:",
                         min = min(SKDEresultater::testdata$dato),
                         max = max(SKDEresultater::testdata$dato),
                         value = c(max(SKDEresultater::testdata$dato) - 365,
                                   max(SKDEresultater::testdata$dato)),
                         timeFormat = "%d.%m.%Y")
    })

    output$pick_bo <- shiny::renderUI({
      mulige_valg <- as.character(unique(SKDEresultater::testdata$bohf))
      shinyWidgets::pickerInput(
        inputId = "valgtBo",
        label = "Velg boområde",
        choices = mulige_valg,
        selected = mulige_valg,
        options = list(
          `actions-box` = TRUE,
          size = 10,
          `selected-text-format` = "count > 0",
          `deselect-all-text` = "Velg ingen",
          `select-all-text` = "Velg alle",
          `none-selected-text` = "Null",
          `count-selected-text` = "{0} områder valgt (av {1})"
        ),
        multiple = TRUE
      )
    })

  }
)
