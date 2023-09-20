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
  url <- paste0("https://api.sunrise-sunset.org/json?lat=69.6489&lng=18.95508&date=", date, "&formatted=0")
  
  # Call API
  call <- try(fromJSON(url, flatten = T))
  
  if(call$status=="OK"){
    print(paste("Call status:", call$status))
    
    # transform ouput (efficiently)
    data.frame(call$results) |>
      mutate(across(c(1:3,5:10), ymd_hms),
             date = date,
             is_dst = dst(date),
             week_day = wday(date),
             year_day = yday(date),
             daylight_seconds = day_length,
             daylight_minutes = day_length/60,
             daylight_hours = day_length/60/60) |>
      select(date, year_day, week_day, 1:2, daylight_seconds, 
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
 # backup save
save(daylight_df, file = "Exercise_1-circle_plot/data/daylight_length_Tromso_2022.rdata")

daylight_df$cumulative_days <- seq(1,365,1)
# Fix summertime to "24 hours"
  #' The API returns weird numbers for when the sun is up "all the time" (00:00:01) 
  #' instead of 24:00:00. This code fixes this issue.
for(x in 1:nrow(daylight_df)){
  if(as.character(daylight_df$sunrise_time[x])=="00:00:01"){ # based on this condition
    daylight_df$daylight_length[x]   <- "24:00:00"
    daylight_df$daylight_length_h[x] <- 24
    daylight_df$daylight_length_m[x] <- 24*60
    daylight_df$daylight_length_s[x] <- 24*60*60
    daylight_df$sunrise_time[x]      <- "24:00:00"
    daylight_df$sunset_time[x]       <- "24:00:00"
  }
}


# Add month name (short and long)
daylight_df |> mutate(date_m_name = case_when(
  date_m==1~"Jan",
  date_m==2~"Feb",
  date_m==3~"Mar",
  date_m==4~"Apr",
  date_m==5~"May",
  date_m==6~"Jun",
  date_m==7~"Jul",
  date_m==8~"Aug",
  date_m==9~"Sep",
  date_m==10~"Oct",
  date_m==11~"Nov",
  date_m==12~"Dec",
), date_m_nameL = case_when(
  date_m==1~"January",
  date_m==2~"February",
  date_m==3~"March",
  date_m==4~"April",
  date_m==5~"May",
  date_m==6~"June",
  date_m==7~"July",
  date_m==8~"August",
  date_m==9~"September",
  date_m==10~"October",
  date_m==11~"November",
  date_m==12~"December",
)) |> select(date_f:date_m, date_m_name, date_m_nameL, date_d, everything()) -> daylight_df

# SAVE
save(daylight_df, file = "ex1/data/daylight/daylight_length_Tromso_2022_finished.rdata")
