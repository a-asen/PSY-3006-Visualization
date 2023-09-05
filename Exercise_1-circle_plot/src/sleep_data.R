# sleep_length
#' sleep length increase as darkness increase and return back to "normal" when 
#' light conditions return to normal
  # Load Data
source("Exercise_1-circle_plot/data/exercise1_load_data.r")

# Parameters
sup_ns <- 8.5 # Amount of "normal sleep" 
sup_sd <- .5

## Start
(-log10(daylight_df$daylight_length_h*10))+1 -> d2
d2[d2 %in% c("Inf", "-Inf")] <- 0
plot(d2) # quick check

d3 <- numeric()
for(x in d2){ 
  c(d3, mean(rnorm(1, sup_ns + x, sup_sd))) -> d3
}
plot(d3) # quick check

#a change

#save(d3,file="d.rdata")
tibble(a = daylight_df$count, b = d3) |>
  ggplot(aes(x=a,y=b))+
  geom_point()+
  geom_smooth()

# Sleep amount
daylight_df$sleep_amount <- d3
ggplot(daylight_df, aes(x=count, y=sleep_amount))+
  geom_point()+
  geom_smooth()

# Wakeup time
d4 <- numeric()
for(x in d3){
  c(d4, rnorm(1, x, .1)) -> d4
}

daylight_df -> test

test$wake_time <- round(d4,2) # add to DF

# Sleep time
d4-d3+24 -> ab # wake time - sleep_amount+24 (clock)
ab[ab>24] <- ab[ab>24]-24 # if over 24 subtract 24
test$sleep_time <- round(ab,2) # round


test |> 
  ggplot(aes(x=count, y=sleep_amount))+
  geom_ribbon(aes(ymin=wake_time, ymax=sleep_time, xmin=count, xmax=count))
  geom_point()+
  geom_
  geom_hline(yintercept = 6)+
  geom_hline(yintercept = 9)
  geom_area()




