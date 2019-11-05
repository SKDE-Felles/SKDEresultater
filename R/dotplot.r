#' Make a plot
#'
#' @param data_to_plot Data to plot
#' @param ref_line Reference line
#' @param all_data All the data (used to make median line)
#'
#' @return A plot
#' @export
#'
dotplot <- function(data_to_plot = NULL, all_data = NULL, ref_line = 30) {
  boomr <- unique(all_data$bohf)
  farger <- SKDEr::skde_colors(num = length(boomr))[seq_len(length(boomr))]
  names(farger) <- boomr
  ymax <- plyr::round_any(max(all_data$tid_min) + 1, 10, f = ceiling)
  xmin <- min(all_data$dato)
  xmax <- max(all_data$dato)
  xmedian <- median(all_data$tid_min)
  xaxis <- list(title = "",
                showline = FALSE,
                showgrid = FALSE,
                showticklabels = TRUE,
                autotick = TRUE,
                type = "date",
                range = c(xmax - 180, xmax),
                fixedrange = FALSE,
                rangeselector = list(
                  buttons = list(
                    list(
                      count = 3,
                      label = "3 mnd",
                      step = "month",
                      stepmode = "todate"),
                    list(
                      count = 6,
                      label = "6 mnd",
                      step = "month",
                      stepmode = "todate"),
                    list(
                      count = 12,
                      label = "1 år",
                      step = "month",
                      stepmode = "todate")
                    )))
  yaxis <- list(title = "Antall minutter",
                showgrid = TRUE,
                zeroline = FALSE,
                showline = FALSE,
                showticklabels = TRUE,
                autotick = TRUE,
                range = c(0, ymax),
                fixedrange = FALSE)
  data_to_plot %>%
    dplyr::filter(dplyr::between(dato, xmin, xmax)) %>%
    plotly::plot_ly(x = ~dato,
                    y = ~tid_min) %>%
    plotly::add_markers(color = ~bohf,
                        colors = farger,
                        hoverinfo = "text",
                        text = ~paste0("</br>Boområde: ", bohf,
                                       "</br>Dato: ", dato,
                                       "</br>Tid til beh.: ", tid_min, " min"
                        )) %>%
    plotly::add_segments(x = xmin,
                         xend = xmax,
                         y = ref_line,
                         yend = ref_line,
                         hoverinfo = "text",
                         text = ~paste0("</br> Mål = ", ref_line, " min"),
                         name = "Mål",
                         color = I("red"),
                         showlegend = TRUE) %>%
    plotly::add_segments(x = xmin,
                         xend = xmax,
                         y = xmedian,
                         yend = xmedian,
                         hoverinfo = "text",
                         text = ~paste0("</br> Median HN = ", xmedian, " min"),
                         linetype = I("dash"),
                         color = I("black"),
                         name = "Median HN",
                         showlegend = TRUE) %>%
    plotly::layout(xaxis = xaxis,
                   yaxis = yaxis) %>%
    plotly::config(displayModeBar = FALSE) %>%
    plotly::rangeslider(range = c(xmin, xmax), type = "date")
}
