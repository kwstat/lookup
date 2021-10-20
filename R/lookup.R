# lookup.R

#' @title
#' Lookup items in key-value pairs of vectors
#'
#' @description
#' This is a simple wrapper to the \code{match} function.
#'
#' @details 
#' Search for elements of \code{x} in \code{key} and return the corresponding
#' element of \code{value}.
#' If no match is found, return \code{nomatch}.
#'
#' @param x Vector of items to lookup in key-value pairs.
#' @param key Vector of keys that are searched.
#' @param value Vector of values to be returned.
#' @param nomatch The value to be returned in the case when no match is
#' found. Note that it is coerced to integer.
#' @return A vector the same length as \code{x}, but containing the values
#' of \code{value}.  If \code{x[i]} is equal to \code{key[j]}, then the
#' value returned in the ith position of the vector is \code{value[j]}.
#' If no match is found, \code{NA} is returned.
#' 
#' @author Kevin Wright
#' @export
#' 
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
#' 
lookup <- function(x,key,value, nomatch=NA){
  # Search for x in key and return the corresponding element (same row)
  # from value
  value[match(if (is.factor(x)) as.character(x) else x,
                  if (is.factor(key)) as.character(key) else key,
                   nomatch)]
}


#' @title
#' Lookup items in key-value dataframe similar to Excel's vlookup function
#'
#' @description
#' This is a simple wrapper to the \code{match} function.
#'
#' @details
#' Search for elements of \code{x} in dataframe \code{data},
#' column \code{key}, and return the corresponding element of column
#' \code{value}.
#' If no match is found, return \code{nomatch}.
#' 
#' @param x Vector of items to lookup in key-value pairs.
#' @param data Dataframe containing key-value columns.
#' @param key Vector of keys that are searched.
#' @param value Vector of values to be returned.
#' @param nomatch The value to be returned in the case when no match is
#' found. Note that it is coerced to integer.
#' 
#' @return A vector the same length as \code{x}, but containing the values
#' of \code{value}.  If \code{x[i]} is equal to \code{key[j]}, then the
#' value returned in the ith position of the vector is \code{value[j]}.
#' If no match is found, \code{NA} is returned.
#' 
#' @author Kevin Wright
#' @export
#'
#' @examples
#' # Example 1.  A and B have different factor levels
#' A <- factor(c("A","E","F"))
#' dat <- data.frame(trt = factor(c("E","F","G")),
#'                   val = c(4,2,0))
#' vlookup(A,dat, "trt", "val")
#' 
vlookup <- function(x, data, key, value, nomatch=NA){
  data[[value]][match(x, data[[key]], nomatch)]
}
