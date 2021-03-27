# lookup.R

#' Lookup items in key-value pairs
#'
#' This is a simple wrapper to the \code{match} function.
#'
#' Search for elements of \code{x} in \code{key} and return the corresponding
#' element of \code{value}.  If no match is found, return \code{nomatch}.
#'
#' @param x Vector of items to lookup in key-value pair.
#' @param key Vector of keys that are searched.
#' @param value Vector of values to be returned.
#' @param nomatch The value to be returned in the case when no match is
#' found. Note that it is coerced to integer.
#' @param incomparables Vector of values that cannot be matched. Any value
#' in \code{x} matching a value in this vector is assigned the nomatch value.
#' For historical reasons, FALSE is equivalent to NULL.
#'
#' @return A vector the same length as \code{x}, but containing the values of
#' \code{value}.  If \code{x[i]} is equal to \code{key[j]}, then the value
#' returned in the ith position of the vector is \code{value[j]}.
#' If no match is found, \code{NA} is returned.
#' @author Kevin Wright
#' @export
#' @examples
#' # Example 1.  A and B have different factor levels
#' A <- factor(c("A","E","F"))
#' B <- factor(c("E","F","G"))
#' v <- c(4,2,0)
#' lookup(A,B,v)
#'
#' # Example 2.  Merge treatment means back into the raw data
#' dat <- data.frame(Trt = rep(LETTERS[1:5],2),
#'                   x=round(rnorm(10),2))
#' # Treatment B is missing all values, treatment D missing one value
#' dat$x[dat$Trt=="B"] <- NA
#' dat$x[4] <- NA
#' # Calculate treatment means
#' TrtMean <- tapply(dat$x, dat$Trt, mean, na.rm=TRUE)
#' TrtMean
#' # Merge the means into the original data
#' dat$TrtMean <- lookup(dat$Trt, names(TrtMean), TrtMean)
lookup <- function(x,key,value, nomatch=NA, incomparables = NULL){
  # Search for x in key and return the corresponding element (same row) from z
  value[match(if (is.factor(x)) as.character(x) else x,
                  if (is.factor(key)) as.character(key) else key,
                   nomatch, incomparables)]
}


#' Lookup items in key-value pairs similar to Excel's vlookup function
#'
#' This is a simple wrapper to the \code{match} function.
#'
#' Search for elements of \code{x} in \code{key} and return the corresponding
#' element of \code{value}.  If no match is found, return \code{nomatch}.
#' @param x
#' @param data
#' @param key
#' @param value
#'
#' @return
#' @export
#'
#' @examples
vlookup <- function(x, data, key, value){
  data[[value]][match(x, data[[key]])]
}


libs(tidyverse)
vlookup(c("Luke Skywalker","Yoda"),
        starwars, "name", "mass")

coefs=lapply(split(iris, iris$Species),
           function(dat) lm(Petal.Length~Sepal.Length, dat)$coef)
coefs=do.call("rbind",coefs)
coefs=as.data.frame(coefs)
coefs$Species=rownames(coefs)
coefs
iris$slope1 = lookup(iris$Species, coefs$Species, coefs[,"Sepal.Length"])
iris$slope2 = vlookup(iris$Species, coefs, "Species", "Sepal.Length")
