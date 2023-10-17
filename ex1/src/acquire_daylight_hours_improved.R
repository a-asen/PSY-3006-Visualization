library(tidyverse)
library(jsonlite)

#' API details
#' https://sunrise-sunset.org/api

# Data frame 
daylight_df <- data.frame()

# Start date
date <- ymd("2022-01-01")

# Get the number of days in a year 
yday(date + years(1) - days(1)) -> days_in_year

# For each day, do the following.
for(x in 1:days_in_year){ 
  print(date)
    # fix weird coding: 
    #   e.g., 2022.06.07 summer # 1970-01-01T00:00:01+00:00
    #   e.g., 2022.12.12 winter # 1970-01-01T00:00:00+00:00
  url <- paste0("https://api.sunrise-sunset.org/json?lat=69.6489&lng=18.95508&date=", date, "&formatted=0")
  
  # Call API
  call <- try(fromJSON(url, flatten = T))
  
  if(call$status=="OK"){
    print(paste("Call status:", call$status))
    
    # transform ouput (efficiently)
    data.frame(call$results) |>
      mutate(
        # fix weird coding
        across(everything(), ~ ifelse(.x=="1970-01-01T00:00:01+00:00",
                                         paste(date,"23:59:59"),
                                         ifelse(.x=="1970-01-01T00:00:00+00:00",
                                                paste(date,"00:00:01"),
                                                .x))),
        across(c(1:3,5:10), ymd_hms), # make date
        date = date,    
        is_dst = dst(date),
        week_day = wday(date),
        month_day = mday(date),
        year_day = yday(date),
        daylight_seconds = day_length,
        daylight_minutes = day_length/60,
        daylight_hours = day_length/60/60) |> 
      select(date, year_day, month_day, week_day, 1:2, daylight_seconds, 
             daylight_minutes, daylight_hours, is_dst, 
             everything(), -day_length) |>
      rbind(daylight_df) -> daylight_df
      
    # Increment "date" by one day
    date + day(1) -> date
    print(paste(x, "out of", days_in_year)) # Console update. 
    # Slight delay 
    Sys.sleep(0.05)
  } 
  else {
    print(paste("Call status: ", call$status))
    print("End")
    break
  }
}

daylight_df |> arrange(date) -> daylight_df

# backup save
save(daylight_df, file = "ex2/data/daylight_df_Tromso_2022.rdata")
