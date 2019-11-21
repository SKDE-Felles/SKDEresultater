#' Title
#'
#' @param data Data to be plotted
#'
#' @return A d3heatmap
#' @importFrom rlang .data
#' @export
#'
create_heatmap <- function(data = NULL) {
    if ("level3_name" %in% colnames(data)) {
        tmp <- tidyr::unite(data, .data$level1_name, .data$level2_name, .data$level3_name, col = "combined", sep = ": ")
    } else if ("level2_name" %in% colnames(data)) {
        tmp <- tidyr::unite(data, .data$level1_name, .data$level2_name, col = "combined", sep = ": ")
    } else if ("level1_name" %in% colnames(data)) {
        tmp <- data
        tmp$combined <- data$level1_name
    }

    spread_data <- tidyr::spread(tmp[, c("area", "area_name", "combined", "value")],
                                 key = .data$combined,
                                 value = .data$value
                                 )
    spread_data <- dplyr::filter(spread_data, .data$area != 8888)
    row.names(spread_data) <- spread_data$area_name
    spread_data$area_name <- NULL
    spread_data$area <- NULL
    
    spread_data <- abs(scale(spread_data))

    return(d3heatmap::d3heatmap(spread_data,
                                colors = c("white", SKDEr::skde_colors(num = 7)),
                                dendrogram = "none"
                                )
           )

}
