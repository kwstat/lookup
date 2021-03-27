
Homepage: https://kwstat.github.io/lookup

Repository: https://github.com/kwstat/lookup

## Key features

The `merge()` function works great to combine dataframes. Until it returns more rows than expected. Or more columns than expected. Or more rows and columns than expected. The `match()` function can be used, but it is convoluted.

This package provides two simple functions:

* `vlookup()` is similar to Excel's VLOOKUP
* `lookup()` is a more sequential-thinking version of `match()`

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
dat = as.data.frame(state.x77)
dat$statename = rownames(dat)

lookup(state.name, dat$statename, dat$Frost)

vlookup(state.name, dat, "statename", "Frost")
#  [1]  20 152  15  65  20 166 139 103  11  60   0 126 127 122 140 114  95  12 161
# [20] 101 103 125 160  50 108 155 139 188 174 115 120  82  80 186 124  82  44 126
# [39] 127  65 172  70  35 137 168  85  32 100 149 173

```

