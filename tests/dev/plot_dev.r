# Check dotplot
library(magrittr)
dotplot(data = SKDEresultater::testdata,
        all_data = SKDEresultater::testdata
)

tmp <- data::dagkir
tmp$combined <- tmp$level1_name

spread_data <- tidyr::spread(tmp[, c("area", "area_name", "combined", "value")],
                             key = .data$combined,
                             value = .data$value
)
spread_data <- dplyr::filter(spread_data, .data$area != 8888)
row.names(spread_data) <- spread_data$area_name
spread_data$area_name <- NULL
spread_data$area <- NULL

hovertext <- spread_data

for (i in names(hovertext)) {
  hovertext[[i]] <- paste0(hovertext[[i]], i, row.names(hovertext))
}

spread_data %>%
heatmaply::heatmaply(colors = SKDEr::skde_colors(),
                     Colv = FALSE, Rowv = FALSE,
                     plot_method = "plotly", scale = "column",
                     ) %>%
  plotly::config(displayModeBar = FALSE)


plotly::plot_ly(y = row.names(spread_data),
                x = names(spread_data),
                z = scale(spread_data),
                type = "heatmap",
                colors = SKDEr::skde_colors(num = 7),
                showscale = FALSE
                ) %>%
  plotly::config(displayModeBar = FALSE)
