# sleep_length
#' sleep length increase as darkness increase and return back to "normal" when 
#' light conditions return to normal
  # Load Data
source("Exercise_1-circle_plot/data/exercise1_load_data.r")
daylight_df -> sleep_data
# Parameters
typical_sleep <- 8.5 # Typical sleep
sleepWakeVariation <- .75 # variation in sleep/wake times 

## Sleep amount       =====
#' Based on some the seasonal variation
-log10(1+sleep_data$daylight_length_h*2) -> sleep_trend
plot(sleep_trend) # quick check
# Add to data frame
sleep_data$sleep_amount <- typical_sleep+sleep_trend

# sleep variation 
round(rnorm(365, 0, sleepWakeVariation),2) -> rndVar
  #' Variation in sleep/wake time 
  #' Around 0 to make some early/later variation (as compared to absolutes)

# Add wake_time & sleep time to data frame
typical_sleep+d2/2-rndVar/2  -> sleep_data$wake_time
24+d2/2-rndVar/2 -> sleep_data$sleep_time
  #' we need sleep_trend as it contains the trend
  #' We can simply split it over sleep/wake times

sleep_data |> 
  pivot_longer(c(wake_time,sleep_time))|>
  ggplot(aes(x=count,y=value,color=name))+
  geom_point()+
  geom_smooth()+
  geom_hline(yintercept=24)




