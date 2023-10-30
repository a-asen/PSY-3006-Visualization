# Script from
library(Rcpp)
sourceCpp("../../ex3/src/apen.cpp") # load apen conversion

da_pro <- function(data, nback){
  data |> group_by(subj,session,block,proberound) |> do({
    d <- .
    ## unravel taps (keys)
    taps=d$response[d$stimulus=="tap"]
    taps=factor(taps, levels=c("lctrl","rctrl"), labels=c("left","right"))
    taps=as.integer(taps)-1
    taps=tail(taps, nback)
    
    iti=diff(d$time[d$stimulus=="tap"]) |> tail(nback-1) 
    
    probe1.resp=as.integer(d$response[d$stimulus=="probe1"])+1
    probe2.resp=as.integer(d$response[d$stimulus=="probe2"])+1
    probe3.resp=as.integer(d$response[d$stimulus=="probe3"])+1
    
    ## return summary of it
    data.frame(
      probe1=probe1.resp,
      probe2=probe2.resp,
      probe3=probe3.resp,
      apen=apen_int(taps, 2)[3],
      bv=sd(iti),
      stim=unique(d$stimulation)
    )
  }) |> ungroup() |>  
    mutate(probe1=ordered(probe1, levels=1:4),
           probe2=ordered(probe2, levels=1:4),
           probe3=ordered(probe3, levels=1:4),
           logapen=-log(log(2)-apen),
           logbv=log(bv),
           zlogapen=(logapen-mean(logapen,na.rm=T))/sd(logapen,na.rm=T),
           zlogbv=(logbv-mean(logbv,na.rm=T))/sd(logbv,na.rm=T),
           ) -> data.probe
  return(data.probe)
}
