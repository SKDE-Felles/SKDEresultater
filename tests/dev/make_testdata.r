# Make testdata

num <- 160
bo <- sample("Helgeland", size = num, replace = TRUE)
dato <- sample(seq(as.Date("2017/01/01"), as.Date("2019/10/10"), by = "day"), num, replace = TRUE)
verdi <- rpois(num, lambda = 32)
helgeland <- data.frame(bohf = bo, dato = dato, tid_min = verdi)

num <- 160
bo <- sample("Finnmark", size = num, replace = TRUE)
dato <- sample(seq(as.Date("2017/01/01"), as.Date("2019/10/10"), by = "day"), num, replace = TRUE)
verdi <- rnorm(num, mean = 30, sd = 20) * seq(1, num)
verdi <- rpois(num, lambda = 25)
finnmark <- data.frame(bohf = bo, dato = dato, tid_min = verdi)

num <- 400
bo <- sample("UNN", size = num, replace = TRUE)
dato <- sample(seq(as.Date("2017/01/01"), as.Date("2019/10/10"), by = "day"), num, replace = TRUE)
verdi <- rpois(num, lambda = 40)
unn <- data.frame(bohf = bo, dato = dato, tid_min = verdi)

num <- 280
bo <- sample("Nordland", size = num, replace = TRUE)
dato <- sample(seq(as.Date("2017/01/01"), as.Date("2019/10/10"), by = "day"), num, replace = TRUE)
verdi <- rpois(num, lambda = 35)
nordland <- data.frame(bohf = bo, dato = dato, tid_min = verdi)

testdata <- rbind(finnmark, helgeland, unn, nordland)

median(testdata$tid_min)

ggplot2::ggplot(data = testdata,
                ggplot2::aes(x = dato, y = tid_min)) +
  ggplot2::geom_point(ggplot2::aes(color = bohf)) +
  ggplot2::geom_hline(yintercept = median(testdata$tid_min), linetype = "dashed", color = "red")

usethis::use_data(testdata, overwrite = TRUE)
