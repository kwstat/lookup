# lookup <img src="man/figures/logo.png" align="right" />

[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/lookup)](https://cran.r-project.org/package=lookup)
[![CRAN_Downloads](https://cranlogs.r-pkg.org/badges/lookup)](https://cranlogs.r-pkg.org/badges/lookup)

Homepage: https://kwstat.github.io/lookup

Repository: https://github.com/kwstat/lookup

## Key features

The `merge()` function works great to combine dataframes. Until it returns more rows than expected. Or more columns than expected. Or more rows and columns than expected. The `match()` function can be used, but it is convoluted.

This package provides two simple functions:

* `vlookup()` is similar to Excel's `VLOOKUP`
* `lookup(x,key,value)` is a more sequential-thinking version of `match()`. Look for `x` in `key` and return the same position element from `value`. 

Both functions return a vector that is the same length as the input.

## Installation

```R
# Install the released version from CRAN:
install.packages("lookup")

# Install the development version from GitHub:
install.packages("devtools")
devtools::install_github("kwstat/lookup")
```

## Usage

```R
library(lookup)

dat = as.data.frame(state.x77)
dat$statename = rownames(dat)

lookup(state.name[1:5], dat$statename, dat$Frost)
#  [1]  20 152  15  65  20

vlookup(state.name[1:5], dat, "statename", "Frost")
#  [1]  20 152  15  65  20

```

