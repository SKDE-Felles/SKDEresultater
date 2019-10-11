# Make testdata

bohf <- c("Finnmark", "UNN", "Nordland", "Helgeland")

omr <- sample(bohf, size = 1000, replace = TRUE)

datoer <- sample(seq(as.Date('2017/01/01'), as.Date('2019/10/10'), by="day"), 1000, replace = TRUE)

verdier <- sample(seq(1,240), 1000, replace = TRUE)

testdata <- data.frame(bohf = omr, dato = datoer, tid_min = verdier)

usethis::use_data(testdata, overwrite = TRUE)
