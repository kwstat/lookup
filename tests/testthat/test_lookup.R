# test_lookup.R

dat = as.data.frame(state.x77)
dat$statename = rownames(dat)
#lookup(state.name, dat$statename, dat$Frost)
#vlookup(state.name, dat, "statename", "Frost")

test_that("lookup", {
  expect_equal(
    lookup(state.name, dat$statename, dat$Frost),
    c(20, 152, 15, 65, 20, 166, 139, 103, 11, 60, 0, 126, 127, 122, 
      140, 114, 95, 12, 161, 101, 103, 125, 160, 50, 108, 155, 139, 
      188, 174, 115, 120, 82, 80, 186, 124, 82, 44, 126, 127, 65, 172, 
      70, 35, 137, 168, 85, 32, 100, 149, 173))

  expect_equal(
    vlookup(state.name, dat, "statename", "Frost"),
    c(20, 152, 15, 65, 20, 166, 139, 103, 11, 60, 0, 126, 127, 122, 
      140, 114, 95, 12, 161, 101, 103, 125, 160, 50, 108, 155, 139, 
      188, 174, 115, 120, 82, 80, 186, 124, 82, 44, 126, 127, 65, 172, 
      70, 35, 137, 168, 85, 32, 100, 149, 173))

})

test_that("missing key", {
  A <- factor(c("A","E","F"))
  B <- factor(c("E","F","G"))
  v <- c(4,2,0)
  dat <- data.frame(trt = B, val=v)

  expect_equal(
    lookup(A,B,v),
    c(NA, 4, 2)
  )
  expect_equal(
    vlookup(A,dat, "trt", "val"),
    c(NA, 4, 2)
  )
})

    
