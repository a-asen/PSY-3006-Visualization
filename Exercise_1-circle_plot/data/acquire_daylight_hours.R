# daylight length
library(tidyverse)
library(jsonlite)

#' See for API details
#' https://sunrise-sunset.org/api

# Get daylight
df <- data.frame()

date <- "2022-01-01"
for(x in 1:365){ # 365
  print(date)
  url <- paste0("https://api.sunrise-sunset.org/json?lat=69.6489&lng=18.95508&date=", date, "&formatted=0")
  
  # Date transformaton
  date_f <- as.POSIXlt(date) # full date
  date_y <- as.numeric(strsplit(date, "-")[[1]][1]) # year
  date_m <- as.numeric(strsplit(date, "-")[[1]][2]) # month
  date_d <- as.numeric(strsplit(date, "-")[[1]][3]) # day
  
  # Call API
  call <- try(fromJSON(url, flatten = T))
  
  # Get sunrise
  sunrise_time <- strsplit(strsplit(call[["results"]][["sunrise"]],
                                    split = "T")[[1]][[2]], "[+]")[[1]][1]
  # Get sunset
  sunset_time <- strsplit(strsplit(call[["results"]][["sunset"]],
                                   split = "T")[[1]][[2]], "[+]")[[1]][1]
  # Get length (in second)
  daylight_length_s <- call[["results"]][["day_length"]]
  daylight_length_m <- daylight_length_s/60 # minutes
  daylight_length_h <- daylight_length_m/60 # hours
  
  # Transform seconds to H:M:S
  # Get out daylight length (how many max hours of light there is in a day)
  daylight_length <- paste0(floor(daylight_length_s/3600),":",floor((daylight_length_s%%3600)/60),":", daylight_length_s%%60)
  
  # Check if "daylight saving" is true
  is_dst <- lubridate::dst(date)
  
  # Tibble
  data <- tibble(date_f, date_y, date_m, date_d, sunrise_time, sunset_time, daylight_length, 
                 daylight_length_h, daylight_length_m, daylight_length_s, is_dst)
  
  # to df
  df <- rbind(df, data)
  
  # Increment day  # Increment with slightly more than one day (86400) b/c DST 
  date <- as.character(strftime(as.POSIXlt(date_f + 94000), format = "%Y-%m-%d"))
  
  # slight sleep
  Sys.sleep(0.05)
  print("...")
}

# Fix summertime to "24 hours"
for(x in 1:nrow(df)){
  if(as.character(df$sunrise_time[x])=="00:00:01"){
    df$daylight_length[x] <- "24:00:00"
    df$daylight_length_h[x] <- 24
    df$daylight_length_m[x] <- 24*60
    df$daylight_length_s[x] <- 24*60*60
  }
}

df |> mutate(date_m_name = case_when(
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
)) |> select(date_f:date_m, date_m_name, date_m_nameL, date_d, everything()) -> df

# SAVE
saveRDS(df, file = "7 - Flow/data/2022-2023_daylight_length.rds")
