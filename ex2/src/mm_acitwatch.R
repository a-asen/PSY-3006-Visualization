fnames=list.files("ex2/data/Actigraphy", pattern="*.csv", full.names = T) 
subjs = unique(map_chr(fnames, \(fname) 
                       (str_split(fname, "/")[[1]][4] |> 
                           str_split("_"))[[1]][1]))

t2 <- t[1:64,]
t2$`Start Time`

as_hour_time <- function(stime){
  map_dbl(str_split(stime,":"), \(x){
    h <- as.integer(x[1])
    if(str_detect(x[3], "PM")){ # all PM times get +12
      h <- h+12
    }
    if(str_detect(x[3], "AM")){ # for AM, only the 12 gets set to 0
      if(h==12)
        h=0
    }
    h <- ifelse(h<8, h+24, h)
    m <- as.integer(x[2])
    if(str_detect(x[3], "M")){
      s <- as.integer(str_split(x[3], " ")[[1]][1])
    } else {
      s <- as.integer(x[3])
    }
    h + m/60 + s/60/60
  })
}


# wake is different. Real. different
as_hour_time_wake <- function(stime){ 
  map_dbl(str_split(stime,":"), \(x){
    h <- as.integer(x[1])
    if(str_detect(x[3], "PM")){ # all PM times get +12
      h <- h+12
    }
    
    m <- as.integer(x[2])
    if(str_detect(x[3], "M")){
      s <- as.integer(str_split(x[3], " ")[[1]][1])
    } else {
      s <- as.integer(x[3])
    }
    h + m/60 + s/60/60
  })
}

##' combine files per subj because some files have duplicate days
map_df(subjs, \(subj){
  fnames=list.files("ex2/data/Actigraphy", pattern=sprintf("%s_.*.csv",subj), full.names = T) 
  
  map_df(fnames, \(fname){
    print(fname)
    d <- suppressMessages(
      read_csv(fname, locale = readr::locale(encoding = "UTF-16"), 
               skip=64,col_types = cols(.default = "c")))

    ix <- which(d[,1]=="--------------------- Marker/Score List --------------------")
    
    ## sometimes the "Marker/Score list" thing is missing
    if(length(ix)==0)
      ix=dim(d)[1]
    d <- d[1:(ix-1),]
    d |> filter(!is.na(`Interval Type`)) |>
      filter(!str_detect(`Interval Type`, ".*Summary.*")) |>
      filter(`Interval Type` %in% c("DAILY", "SLEEP")) |>
      select(1:15) |> 
      mutate(subj=subj)
  }) -> dd
  
  dd <- distinct(dd) |> filter(`Interval Type`=="SLEEP")
  
  #' there are two different date formats:
  #'  yyyy-mm-dd
  #'  mm/dd/yyyy
  #'  
  print(dd)
  dd |> rename(date=`End Date`) |>
    mutate(date=if_else(str_detect(date, "/"), mdy(date), ymd(date)),
           sleep_onset_ag_h = as_hour_time(`Start Time`), 
           sleep_wake_ag_h = as_hour_time_wake(`End Time`),  
           #' add wake time, to investigate self-report vs. actigraph wake time
           #' It appears as though participant 17 has flipped AM/PM 
           #' It appears that 19 does not use AM/PM
           sleep_duration_ag_h = as.numeric(`Sleep Time`)/60,
           
           sleep_wake_time_ag_h = as.numeric(`Wake Time`)/60,
           full_sleep_duration_ag_h = as.numeric(Duration)/60,
           sleep_efficiency = as.numeric(Efficiency),
    ) |>
    select(subj,date,starts_with("sleep", ignore.case=F)) 
}) -> actigraphy




