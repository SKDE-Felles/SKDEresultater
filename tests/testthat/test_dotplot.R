context("Test dotplot")

dotplot_test <- SKDEresultater::dotplot(
  SKDEresultater::testdata,
  SKDEresultater::testdata
)

test_that("test that input data and plot data are the same", {
  expect_equal(dotplot_test$x$visdat[[1]](), SKDEresultater::testdata)
})

test_that("test that the plot layout is as intended", {
  expect_equal(dotplot_test$x$layout$xaxis$rangeslider$visible, TRUE)
  expect_equal(dotplot_test$x$layout$xaxis$rangeslider$type, "date")
  expect_equal(dotplot_test$x$layout$xaxis$rangeslider$range,
               range(SKDEresultater::testdata$dato))
  expect_equal(dotplot_test$x$config$showSendToCloud, FALSE)
  expect_equal(dotplot_test$x$config$displayModeBar, FALSE)
})
