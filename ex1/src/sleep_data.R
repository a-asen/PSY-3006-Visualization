# sleep_length
  #' sleep length increase as darkness increase and return back to "normal" when 
  #' light conditions return to normal
# Load Data         ====
library(tidyverse)
source("ex1/data/exercise1_load_data.r")
daylight_df -> sleep_data

# Parameters        ====
typical_sleep <- 8.5 # Typical sleep
sleepWakeVariation <- .75 # variation in sleep/wake times 

# Sleep amount         =====
#' Based on some the seasonal variation
-log10(1+sleep_data$daylight_length_h*2) -> sleep_trend
plot(sleep_trend) # quick check

# Sleep variation       ====
round(rnorm(365, 0, sleepWakeVariation),2) -> rndVar
  #' Add random variation to sleep amount

# Add to data frame
sleep_data$sleep_amount <- typical_sleep+sleep_trend+rndVar2

# Variation to wake/sleep time
round(rnorm(365, 0, sleepWakeVariation/4+.5),2) -> rndVar2

## Add wake_time & sleep time to data frame     ====
typical_sleep+sleep_trend/2-rndVar2/2  -> sleep_data$wake_time
24+sleep_trend/2-rndVar2/2 -> sleep_data$sleep_time
  #' we need sleep_trend as it contains the trend
  #' We can simply split it over sleep/wake times

# Plot          ====
sleep_data |> 
  pivot_longer(c(wake_time,sleep_time))|>
  ggplot(aes(x=count,y=value,color=name))+
  geom_point()+
  geom_smooth()+
  geom_hline(yintercept=24)

save(sleep_data, file="ex1/data/sleep_data.Rdata")

