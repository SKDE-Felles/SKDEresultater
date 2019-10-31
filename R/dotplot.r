#' Make a plot
#'
#' @param data_to_plot Data to plot
#' @param ref_line Reference line
#' @param xmin Lower limit on x-axes
#' @param xmax Upper limit on x-axes
#' @param all_data All the data (used to make median line)
#'
#' @return A plot
#' @export
#'
dotplot <- function(data_to_plot = NULL, all_data = NULL, ref_line = 30, xmin = 0, xmax = 1) {
  boomr <- unique(all_data$bohf)
  farger <- SKDEr::skde_colors(num = 5)[seq_len(length(boomr))]
  names(farger) <- boomr
  ymax <- plyr::round_any(max(all_data$tid_min) + 1, 10, f = ceiling)
  xmedian <- median(all_data[["tid_min"]])
  xaxis <- list(title = "Dato",
                showline = FALSE,
                showgrid = FALSE,
                showticklabels = TRUE,
                autotick = TRUE,
                type = "date",
                range = c(xmin, xmax),
                fixedrange = FALSE,
                rangeselector = list(
                  buttons = list(
                    list(
                      count = 3,
                      label = "3 mo",
                      step = "month",
                      stepmode = "todate"),
                    list(
                      count = 6,
                      label = "6 mo",
                      step = "month",
                      stepmode = "todate"),
                    list(
                      count = 12,
                      label = "1 yr",
                      step = "month",
                      stepmode = "todate"),
                    list(
                      count = 1,
                      label = "YTD",
                      step = "year",
                      stepmode = "todate"),
                    list(step = "all",
                         stepmode = "todate"))),
                rangeslider = list(type = "date"))
  yaxis <- list(title = "Antall minutter",
                showgrid = FALSE,
                zeroline = FALSE,
                showline = FALSE,
                showticklabels = TRUE,
                autotick = TRUE,
                range = c(0, ymax),
                fixedrange = FALSE)
  refl <- list(x = xmin,
               y = ref_line,
               xanchor = "right",
               yanchor = "middle",
               text = ~paste0("ref_line:", ref_line),
               font = list(family = "Arial",
                           size = 16,
                           color = I("black")),
               showarrow = FALSE)
  xmed <- list(x = xmax,
               y = xmedian,
               xanchor = "right",
               yanchor = "middle",
               text = ~paste0("median:", xmedian),
               font = list(family = "Arial",
                           size = 16,
                           color = I("red")),
               showarrow = FALSE)
  data_to_plot %>%
    dplyr::filter(dplyr::between(dato, xmin, xmax)) %>%
    plotly::plot_ly(x = ~dato,
                    y = ~tid_min) %>%
    plotly::add_markers(color = ~bohf,
                        colors = farger,
                        hoverinfo = "text",
                        text = ~paste0("</br>Boområde: ", bohf,
                                       "</br>dato: ", dato,
                                       "</br> min: ", tid_min
                        )) %>%
    plotly::add_segments(x = xmin,
                         xend = xmax,
                         y = ref_line,
                         yend = ref_line,
                         hoverinfo = "text",
                         text = ~paste0("</br> ref-line =", ref_line),
                         name = "ref_line",
                         color = I("black"),
                         showlegend = TRUE) %>%
    plotly::add_segments(x = xmin,
                         xend = xmax,
                         y = xmedian,
                         yend = xmedian,
                         hoverinfo = "text",
                         text = ~paste0("</br> median =", xmedian),
                         linetype = I("dash"),
                         color = I("red"),
                         name = "median",
                         showlegend = TRUE) %>%
    plotly::layout(xaxis = xaxis,
                   yaxis = yaxis)
}
