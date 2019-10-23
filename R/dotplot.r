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
  library(ggplot2)

  ggplot(data = data_to_plot, aes(x = dato, y = tid_min)) +
    geom_point(aes(color = bohf)) +
    geom_hline(aes(yintercept = ref_line)) +
    geom_hline(yintercept = median(all_data$tid_min),
               linetype = "dashed",
               color = "red") +
    ylim(0, max(all_data$tid_min) + 1) +
    xlim(xmin, xmax) +
    labs(x = "Dato", y = "Antall minutter")
}
