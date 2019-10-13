# nolint start
app <- ShinyDriver$new("../")
app$snapshotInit("test_bo")

app$snapshot()
app$setInputs(valgtBo = character(0))
app$snapshot()
app$setInputs(valgtBo = "Helgeland")
app$snapshot()
# nolint end
