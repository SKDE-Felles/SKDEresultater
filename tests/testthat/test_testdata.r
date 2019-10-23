context("Test data set")

test_that("Test if the testdata set has not been changed", {
  expect_equal_to_reference(testdata, "data/ref_testdata.rds")
})
