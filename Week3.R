library(dplyr)
library(nycflights13)
library(knitr)

# Exercises 5.5.2 (1-5)
# 1. Currently dep_time and sched_dep_time are convenient to look at, 
#    but hard to compute with because they’re not really continuous numbers. 
#    Convert them to a more convenient representation of number of minutes since midnight.
flights_time <- select(flights, dep_time, sched_dep_time)
flights_since_mid <- mutate(flights_time, 
       dep_hours = dep_time %/% 100,   # drops the right two digits (e.g. 513 becomes 5)
       dep_mins = dep_time %% 100,   # keeps only the right two digits (e.g. 513 becomes 13)
       dep_since_mid = (dep_hours * 60) + dep_mins,
       sched_dep_hours = sched_dep_time %/% 100,
       sched_dep_mins = sched_dep_time %% 100,
       sched_dep_since_mid = (sched_dep_hours * 60) + sched_dep_mins)
       

# 2. Compare air_time with arr_time - dep_time. 
#   What do you expect to see? What do you see? What do you need to do to fix it?
flights_time2 <- select(flights, air_time, arr_time, dep_time)
flights_time3 <- mutate(flights_time2, 
                        air_time2 = arr_time - dep_time,
                        air_time_diff = air_time - air_time2)
# The difference between arr_time and dep_time is not the number of minutes of the flight.
# This is because they both are two digits for hour and then two digits for minutes.
# Say dep_time is 1:30pm (130) and arr_time is 2:30pm (230).
# The difference between 130 and 230 is 100, which means 1 hour, not 100 minutes.
# One way to fix is to change these to minutes since midnight like done for question #1.
# 
# The second problem is arr_time and dep_time could be different time zones.
# To fix this one would need to find the time zones of origin and dest and adjust accordingly.
# This information is in the airports table, column tz, which is the offset from GMT
#
# This could be done with an SQL join statement, which is merge in R
# Need to match flights.origin with airports.faa and get the airports.tz value
# Also match flights.dest with airports.faa and get the airports.tz value
# Then adjust the hours portion of departure and arrival time by the tz value for each
#
# This solution doesn't adjust for time zones so more work would need to be done
flights_time4 <- select(flights, air_time, arr_time, dest, dep_time, origin)
flights_time5 <- mutate(flights_time4,
                        arr_hours = arr_time %/% 100,    # this would need to be adjusted to GMT
                        arr_mins = arr_time %% 100,
                        arr_since_mid = (arr_hours * 60) + arr_mins,
                        
                        dep_hours = dep_time %/% 100,    # this would need to be adjusted to GMT
                        dep_mins = dep_time %% 100,
                        dep_since_mid = (dep_hours * 60) + dep_mins,
                        
                        air_time2 = arr_since_mid - dep_since_mid,
                        
                        air_time_diff = air_time2 - air_time) # doesn't work because of time zones

# 3. Compare dep_time, sched_dep_time, and dep_delay. 
#    How would you expect those three numbers to be related?
#
# I would expect that dep_delay = dep_time - sched_dep_time
# But this won't really work until dep_time and sched_dep_time are split out into hours and minutes
# and converted to number of minutes since midnight.  The the subtraction will work


# 4. Find the 10 most delayed flights using a ranking function. 
#    How do you want to handle ties? Carefully read the documentation for min_rank().


# 5. What does 1:3 + 1:10 return? Why?
  
  


# 5.6.7 #2-6
# 5.7.1 #1-8
# 19.3.1 #1-4
# 19.4.4 #1-6

