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
dotplotly <- function(data_to_plot = NULL, all_data = NULL, ref_line = 30, xmin = 0, xmax = 1) {
  library(plotly)
  library(magrittr)
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
               fixedrange = TRUE)
  yaxis <- list(title = "Antall minutter",
                showgrid = FALSE,
                zeroline = FALSE,
                showline = FALSE,
                showticklabels = TRUE,
                autotick = TRUE,
                range = c(0, ymax),
                fixedrange = TRUE)
  refl <- list(x = xmax,
               y = ref_line,
               xanchor = "left",
               yanchor = "middle",
               text = ~paste0("ref_line:", ref_line),
               font = list(family = "Arial",
                           size = 16,
                           color = I("black")),
               showarrow = FALSE)
  xmed <- list(x = xmax,
               y = xmedian,
               xanchor = "left",
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
                         text = "ref-line",
                         name = "ref_line",
                         color = I("black"),
                         showlegend = FALSE) %>%
    plotly::add_segments(x = xmin,
                         xend = xmax,
                         y = xmedian,
                         yend = xmedian,
                         text = "median",
                         linetype = I("dash"),
                         color = I("red"),
                         name = "median",
                         showlegend = FALSE) %>%
    plotly::layout(xaxis = xaxis,
                   yaxis = yaxis,
                   annotations = refl) %>%
    plotly::layout(annotations = xmed)
}
