fnames=list.files("ex2/data/Behavioral/", pattern="*.csv", full.names = T) 
fnames=fnames[str_detect(fnames, "day")]

map_df(fnames, function(fname){
  day=str_split(str_split(fname, "/")[[1]][4], "_")[[1]][2]
  dd <- read_csv(fname, comment = "#", col_types = cols(
    subj = col_character(),
    trial = col_double(),
    time = col_double(),
    stimulus = col_character(),
    response = col_character()
  )) %>%
    mutate(day=day) -> dd
  dd
}) -> data


# add block variable
data %>% group_by(subj,day) %>% do({
  d=.
  dd=d[d$stimulus=="probe1",]
  dd$trial[-length(dd$trial)]
  dd$trial1=c(0,dd$trial[-length(dd$trial)])
  d$block=0
  for(i in 1:dim(dd)[1]){
    d$block[d$trial>dd$trial1[i] & d$trial<=dd$trial[i]]<-i
  }
  d
}) -> data

library(haven)
read_spss(file = paste0(getwd(),"/ex2/data/MW_Sleep_data_table-p34.sav")) -> demo


data |> mutate(subj=as.numeric(subj)) |> 
  left_join(demo |> select(Code,Group), by=join_by("subj"=="Code")) |>
  mutate(sleepdep=case_when(Group==0 & day=="day1" ~ "SD",#0 - ESD
                            Group==0 & day=="day2" ~ "control",#0 _ ESD 
                            Group==1 & day=="day1" ~ "control",#1 - LSD
                            Group==1 & day=="day2" ~ "SD",#1 -LSD
                            T ~ "unddef")) -> data

save(data, file="ex2/data/raw_data.rdata")