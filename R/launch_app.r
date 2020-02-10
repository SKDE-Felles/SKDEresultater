#' Launch the application, either locally or to shinyapps.io
#'
#' @param dataset The data set to be loaded into the application
#' @param title The title of the application
#' @param publish_app If TRUE: deploy app to shinyapps.io (default = FALSE)
#' @param name The appName of the deployed shiny application (default = "experimental")
#' @param shiny_account Which shiny account on shinyapps.io (default = "skde")
#'
#' @export
launch_app <- function(dataset = NULL,
                       title = NULL,
                       publish_app = FALSE,
                       name = "experimental",
                       shiny_account = "skde"
                       ) {

  # Create a directory with all necessary data.
  shinydir <- SKDEr::create_appdir(app_data = dataset,
                                   webpage_title = title,
                                   package = "SKDEresultater")

  # Run the app
  if (publish_app) {
    rsconnect::deployApp(appDir = shinydir, appName = name, account = shiny_account)
  } else {
    shiny::runApp(appDir = shinydir)
  }
}
