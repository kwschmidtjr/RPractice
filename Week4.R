library(tidyverse)

# typeof(vector)
# length(vector)
# is.finite(), is.infinite(), is.nan()


# ------------------ Exercises: 20.3.5 #1-4 ---------------------
# 1. Describe the difference between is.finite(x) and !is.infinite(x).
library(tidyverse)
x <- c(-5:5)
is.finite(x)
!is.finite(x)
# is.finite(x) returns a new vector of length x that tells whether each item
# is a finite number.  !is.finite(x) simply reverses the TRUE/FALSE answers
# of is.finite(x)


# 2. Read the source code for dplyr::near()
#    (Hint: to see the source code, drop the ()). How does it work?
# It takes the difference between x and y and compares that to the smallest
# floating point number that the computer currently running R can support.
# If that difference between x and y is less than this, they are considered "near"


# 3. A logical vector can take 3 possible values. 
# How many possible values can an integer vector take? 
# In theory this is infinite, but is actually +/- 2^31 (+/- 2 billion),
# which is the limit to the value that can be stored in an 4 byte integer

# How many possible values can a double take?
# A double is 8 bytes, which provides +/- 2^63 values



# 4. Brainstorm at least four functions that allow you to convert a double
#    to an integer. How do they differ? Be precise.
# round(x) rounds up or down to nearest integer based on > .5 or <= .5
# ceiling(x) rounds up to the next integer always
# floor(x) rounds down to the lower integer always
# as.integer(x) drops the items to the right of the decimal, regareless if > or < .5
print("round")
round(10.51) 
round(10.5)
round(-10.5)

print("ceiling")
ceiling(10.51)
ceiling(10.5)
ceiling(-10.5)

print("floor")
floor(10.51)
floor(10.5)
floor(-10.5)

print("as.integer")
as.integer(10.51)
as.integer(10.5)
as.integer(-10.5)
as.integer(-10.99999)
as.integer(-10.00001)


# ------------------ Exercises: 20.4.6 #1-6 ---------------------
# Notes
# Implicit coercion: using a logical vector in a numeric context.
# In this case TRUE is converted to 1 and FALSE converted to 0 


# 1. What does mean(is.na(x)) tell you about a vector x? What about sum(!is.finite(x))?
# is.na(x) tells you which items in the vector are NA and which aren't
x <- c(1, NA, 2, 3, 4)
is.na(x)

# sum(!is.finite(x)) tells you the number of items in your vector that are not finite
x <- c(1, NA, 2, 3, 4, Inf, -Inf)
is.finite(x)
sum(is.finite(x)) # returns 4
sum(!is.finite(x)) # returns 3


# 2. Carefully read the documentation of is.vector(). What does it actually test for?
#    Why does is.atomic() not agree with the definition of atomic vectors above?
# is.vector(x) returns TRUE only if the object is a vector with no attributes other 
# than names. 
# is.atomic(x) determines if somethign is a vector

x <- c(1, NA, 2, 3, 4, Inf, -Inf)
is.vector(x)
is.vector(x, "integer")
y <- c(1:10)
is.vector(y, "integer")
z <- c(TRUE, FALSE, TRUE, TRUE)
is.vector(z, "logical")

a <- list(1:3, "a", c(TRUE, FALSE, TRUE), c(2.3, 5.9))
is.vector(a)  # returns true
is.atomic(a)  # returns false


# 3. Compare and contrast setNames() with purrr::set_names().
# If you don't pass in names to set_names(), it will simply use the names of
# the items as the names.  setNames() won't do this
# JA: there may be more than this - worth looking up somebody else's answer
setNames(1:3, c("a", "b", "c") )
setNames(1:3, letters[1:3])
#setNames(1:3) # returns error

library(purrr)
set_names(1:4, c("a", "b", "c", "d"))
set_names(1:4, letters[1:4])
set_names(1:4)
set_names(letters[1:4])


# 4. Create functions that take a vector as input and returns:
# 4.1. The last value. Should you use [ or [[?
# Use [[ because it drops names and returns only the value
last_value <- function(my_vector) {
  x = length(my_vector)
  my_vector[[x]]
  #my_vector[x]  # seems to return the same thing, though...
}
last_value( c(1:10))


# 4.2. The elements at even numbered positions.
x <- c(1:10)
even_vector <- function(my_vector) {
  my_vector[seq(1, length(my_vector),2)]
}
even_vector(x)

# 4.3 Every element except the last value.
x <- c(1:10)
omit_last <- function(my_vector) {
  my_vector[-length(my_vector)]
}
omit_last(x)


# 4.4 Only even numbers (and no missing values).
x <- c(-5:5, 7, 7, 8, 8)
even_vector <- function(my_vector) {
  my_vector[which(my_vector %% 2 == 0)]
}
even_vector(x)


# 5. Why is x[-which(x > 0)] not the same as x[x <= 0]?
# NaN is treated differently - that's the only difference I could find
x <- c(-5, -1, 0, 3, 8, NA, Inf, -Inf, NaN, 0/0)
x[-which(x > 0)]
x[x <= 0]


# 6. What happens when you subset with a positive integer that’s bigger than the
#    length of the vector? 
# It returns a vector with one item, NA
x <- c("one", "two", "three", "four", "five")
x[6]   # returns [1] NA

# What happens when you subset with a name that doesn’t exist?
# It returns NA
x <- setNames(1:3, c("a", "b", "c") )
x["a"]
x["f"] # returns <NA>


# ------------------ Exercises: 20.5.4 #1-2 ---------------------
# 1. Draw the following lists as nested sets:
#    1.1. list(a, b, list(c, d), list(e, f))
# ----------
# | a      |
# | b      |
# | [c, d] |
# | [d, e] |
# ----------

#    1.2. list(list(list(list(list(list(a))))))
# [[[[[[a]]]]]]


# 2. What happens if you subset a tibble as if you’re subsetting a list?
#    What are the key differences between a list and a tibble?
# Subetting a tibble is the same as a list because a tibble is like a list
# A tibble is like a list where all elements are of the same length 


# ------------------ Exercises: 21.2.1 #1-4 ---------------------

# ------------------ Exercises: 21.3.5 #1-3 ---------------------
# ------------------ Exercises: 21.5.3 #1 ---------------------
