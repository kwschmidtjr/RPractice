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
# Exercises 5.4.1 (2-4)
