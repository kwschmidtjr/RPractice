library(dplyr)
library(nycflights13)
library(knitr)

# Exercises 5.2.4 (1-4)
# 1.Find all flights that
# 1.Had an arrival delay of two or more hours
delay <- filter(flights, arr_delay >= 120)
print(delay)
# Answer: A tibble: 10,200 x 19


# 2.Flew to Houston ( IAH  or  HOU )
houston <- filter(flights, dest == "IAH" | dest == "HOU")
print(houston)
# Answer: A tibble: 9,313 x 19


# 3.Were operated by United, American, or Delta
print(airlines)
operators <- filter(flights, carrier == "UA" | carrier == "AA" | carrier == "DL")
pring(operators)
# Answer: A tibble: 139,504 x 19


# 4.Departed in summer (July, August, and September)
departed <- filter(flights, month == 7 | month == 8 | month == 9)
print(departed)
# Answer: A tibble: 86,326 x 19


# 5.Arrived more than two hours late, but didn’t leave late
late <- filter(flights, arr_delay > 120 & dep_delay <= 0)
print(late)
select(late, arr_delay, dep_delay)
# Answer: A tibble: 29 x 19


# 6.Were delayed by at least an hour, but made up over 30 minutes in flight
made_up <- filter(flights, dep_delay >= 60 & (dep_delay - arr_delay) > 30)
print(made_up)
select(made_up, arr_delay, dep_delay)


# 7.Departed between midnight and 6am (inclusive)
departed2 <- filter(flights, (dep_time >= 0) & (dep_time <= 600))
print(departed2)
select(departed2, dep_time)
# Answer: A tibble: 9,344 x 19


# 2.Another useful dplyr filtering helper is  between().
# What does it do? Can you use it to simplify the code needed to answer the previous challenges?
departed2 <- filter(flights, between(dep_time, 0, 600, incbounds=TRUE)
print(departed2)
select(departed2, dep_time)


# 3.How many flights have a missing  dep_time? 
# What other variables are missing? 
# What might these rows represent?
missing <- filter(flights, is.na(dep_time))
print(missing)
# Answer: A tibble: 8,255 x 19. dep_delay and arr_time also missing.  These flights were probably cancelled


# 4.Why is  NA ^ 0  not missing? 
# you can't raise nothing to a power

# Why is  NA | TRUE  not missing? 
# to select something that is either true or NA

# Why is  FALSE & NA  not missing? 
# to 

# Can you figure out the general rule? ( NA * 0  is a tricky counterexample!)
# 

# Exercises 5.3.1 (1-4)
# How could you use arrange() to sort all missing values to the start? (Hint: use is.na()).
arranged = arrange(flights, desc(is.na(dep_delay)))
print(arranged)

# Sort flights to find the most delayed flights. Find the flights that left earliest.
mostDelayed = arrange(flights, desc(dep_delay))
print(mostDelayed)
leftEarliest <- arrange(flights, dep_time)
print(leftEarliest)

# Sort flights to find the fastest flights.
fastest <- arrange(flights, air_time)
print(fastest)

# Which flights travelled the longest? Which travelled the shortest?
longest <- arrange(flights, desc(distance))
print(longest)
shortest <- arrange(flights, distance)
print(shortest)

# Exercises 5.4.1 (2-4)
# 2. What happens if you include the name of a variable multiple times in a select() call?
# It only uses the first time the variable is named
multiple <- select(flights, year, dep_delay, year)
print(multiple)

# 3. What does the one_of() function do?
#    Why might it be helpful in conjunction with this vector?
vars <- c("year", "month", "day", "dep_delay", "arr_delay")
oneOfExample <- select(flights, one_of(vars))


# 4. Does the result of running the following code surprise you? - NO
# How do the select helpers deal with case by default? - Ignores case
# How can you change that default?
#    select(flights, contains("TIME"))
containsExample <- select(flights, contains("TIME"))
containsExample <- select(flights, contains("time", ignore.case = FALSE))
