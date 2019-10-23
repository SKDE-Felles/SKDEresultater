#' Create an appDir for shiny::runApp and rsconnect::deployApp
#'
#' Create a directory in tempdir() where the installed version of
#' SKDEresultater package is copied and the data is saved.
#' This directory, with its content, will be deployd to or ran by shiny.
#'
#' @param app_data The data to be saved in the directory, to be used by the app
#' @param webpage_title The title of the app
#' @param git_hash Current git sha1 hash
#' @param github_repo Current github repository
#'
#' @return The created directory
#'
create_appdir <- function(app_data = NULL,
                          webpage_title = NULL,
                          git_hash = NULL,
                          github_repo = NULL) {
  # Name the directory
  tmpshinydir <- paste0(tempdir(), "/", "shiny")
  # Delete old content in directory
  unlink(tmpshinydir, recursive = TRUE, force = TRUE)
  # Create main directory
  dir.create(tmpshinydir)
  # Copy the installed version of the portal package to the directory
  file.copy(system.file("app", package = "SKDEresultater"), tmpshinydir, recursive = TRUE)
  # Create data folder
  dir.create(paste0(tmpshinydir, "/", "app/data"))
  # Save the data to a .RData file
  save(app_data,
       webpage_title,
       git_hash,
       github_repo,
       file = paste0(tmpshinydir, "/", "app/data/data.RData"))
  # Return the name of the main directory
  return(paste0(tmpshinydir, "/", "app"))
}
