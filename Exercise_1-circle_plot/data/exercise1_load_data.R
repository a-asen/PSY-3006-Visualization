#load data
path <- "Exercise_1-circle_plot/data/"

for(x in list.files(path)){
  if(endsWith(tolower(x),".rdata")){
    load(paste0(path,"/",x))
  }
}
