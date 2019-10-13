# nolint start
app <- ShinyDriver$new("../")
app$snapshotInit("test_slider")

app$snapshot()
app$setInputs(valgtDato = c("2018-03-10", "2019-10-10"))
app$snapshot()
# nolint end
