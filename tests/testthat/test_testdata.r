context("Test testdata")

test_that("Check that testdata exist", {
  expect_equal(length(testdata), 3)
  expect_equal(length(testdata$bohf), 500)
  expect_equal(length(testdata$dato), 500)
  expect_equal(length(testdata$tid_min), 500)
  expect_true(is.factor(testdata$bohf))
  expect_false(is.numeric(testdata$dato))
  expect_true(is.numeric(testdata$tid_min))
  expect_identical(median(testdata$tid_min), 34)
  expect_identical(mean(testdata$tid_min), 34.308)
})
