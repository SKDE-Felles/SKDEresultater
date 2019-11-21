# Check dotplot
library(magrittr)
dotplot(data = SKDEresultater::testdata,
        all_data = SKDEresultater::testdata
)

tmp <- data::dagkir
tmp$combined <- tmp$level1_name


text_tmp <- tmp
text_tmp$text <- paste0("</br>Boomr\u00e5de: ", tmp$area_name,
                        "</br>Utvalg: ", tmp$combined,
                        "</br>Verdi (", tolower(tmp$type), "): ", tmp$value)

txt_spread <- tidyr::spread(text_tmp[, c("area", "combined", "text")],
                            key = .data$combined,
                            value = .data$text
)
txt_spread <- dplyr::filter(txt_spread, .data$area != 8888)
txt_spread$area <- NULL



spread_data <- tidyr::spread(tmp[, c("area", "area_name", "combined", "value")],
                             key = .data$combined,
                             value = .data$value
)
spread_data <- dplyr::filter(spread_data, .data$area != 8888)
row.names(spread_data) <- spread_data$area_name
spread_data$area_name <- NULL
spread_data$area <- NULL


spread_data %>%
heatmaply::heatmaply(colors = SKDEr::skde_colors(num = 7),
                     Colv = FALSE, Rowv = FALSE,
                     plot_method = "plotly", scale = "column",
                     custom_hovertext = txt_spread,
                     showscale = FALSE
                     ) %>%
  plotly::config(displayModeBar = FALSE)


plotly::plot_ly(y = row.names(spread_data),
                x = names(spread_data),
                z = scale(spread_data),
                type = "heatmap",
                colors = SKDEr::skde_colors(num = 7),
                hovertextsrc = hovertext,
                showscale = FALSE
) %>%
  plotly::config(displayModeBar = FALSE)







spread_data2 <- tidyr::spread(tmp[, c("area", "area_name", "combined", "value")],
                             key = .data$combined,
                             value = .data$value
)
spread_data2 <- dplyr::filter(spread_data2, .data$area != 8888)
spread_data2[,3] <- scale(spread_data2)
row.names(spread_data2) <- spread_data2$area_name
spread_data2$area_name <- NULL
spread_data2$area <- NULL


plotly::plot_ly(y = row.names(spread_data2),
                x = names(spread_data2),
                z = scale(spread_data2),
                type = "heatmap",
                colors = SKDEr::skde_colors(num = 7),
                showscale = FALSE
                ) %>%
  plotly::config(displayModeBar = FALSE)



