install.packages("remotes")

remotes::install_github("skde-felles/SKDEresultater", ref = Sys.getenv("TRAVIS_BRANCH"))

rsconnect::setAccountInfo(name   = Sys.getenv("shinyapps_name"),
                          token  = Sys.getenv("shinyapps_token"),
                          secret = Sys.getenv("shinyapps_secret")
                          )

git_hash <- Sys.getenv("TRAVIS_COMMIT")
github_account <- Sys.getenv("TRAVIS_REPO_SLUG")

if (Sys.getenv("TRAVIS_BRANCH") == "master") {
  app_name <- "SKDEresultater"
} else {
  app_name <- "exp_SKDEresultater"
}

SKDEresultater::launch_app(
  dataset = SKDEresultater::testdata,
  publish_app = TRUE,
  name = app_name,
  git_hash = git_hash,
  github_repo = github_account
)
