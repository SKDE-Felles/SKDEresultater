# Make testdata

num <- 80
bo <- sample("Helgeland", size = num, replace = TRUE)
dato <- sample(seq(as.Date("2017/01/01"), as.Date("2019/10/10"), by = "day"), num, replace = TRUE)
verdi <- rpois(num, lambda = 32)
helgeland <- data.frame(bohf = bo, dato = dato, tid_min = verdi)

num <- 80
bo <- sample("Finnmark", size = num, replace = TRUE)
dato <- sample(seq(as.Date("2017/01/01"), as.Date("2019/10/10"), by = "day"), num, replace = TRUE)
verdi <- rnorm(num, mean = 30, sd = 20) * seq(1, num)
verdi <- rpois(num, lambda = 25)
finnmark <- data.frame(bohf = bo, dato = dato, tid_min = verdi)

num <- 200
bo <- sample("UNN", size = num, replace = TRUE)
dato <- sample(seq(as.Date("2017/01/01"), as.Date("2019/10/10"), by = "day"), num, replace = TRUE)
verdi <- rpois(num, lambda = 40)
unn <- data.frame(bohf = bo, dato = dato, tid_min = verdi)

num <- 140
bo <- sample("Nordland", size = num, replace = TRUE)
dato <- sample(seq(as.Date("2017/01/01"), as.Date("2019/10/10"), by = "day"), num, replace = TRUE)
verdi <- rpois(num, lambda = 35)
nordland <- data.frame(bohf = bo, dato = dato, tid_min = verdi)

testdata <- rbind(finnmark, unn, nordland, helgeland)

for (i in seq_len(length(testdata$tid_min))) {
  if ((testdata$bohf[i] == "UNN") & (testdata$dato[i] > "2019-06-01") & (testdata$tid_min[i] > 5)) {
    testdata$tid_min[i] <- testdata$tid_min[i] - 3
  }
  if ((testdata$bohf[i] == "UNN") & (testdata$dato[i] > "2019-05-01") & (testdata$tid_min[i] > 5)) {
    testdata$tid_min[i] <- testdata$tid_min[i] - 3
  }
  if ((testdata$bohf[i] == "UNN") & (testdata$dato[i] > "2019-04-01") & (testdata$tid_min[i] > 5)) {
    testdata$tid_min[i] <- testdata$tid_min[i] - 3
  }
}

ggplot2::ggplot(data = testdata,
                ggplot2::aes(x = dato, y = tid_min)) +
  ggplot2::geom_point(ggplot2::aes(color = bohf)) +
  ggplot2::geom_hline(yintercept = median(testdata$tid_min), linetype = "dashed", color = "red")

usethis::use_data(testdata, overwrite = TRUE)
