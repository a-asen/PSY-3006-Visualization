nback=25
which.apen = 2 # 
Rcpp::sourceCpp("ex2/src/apen.cpp")
## process into probe-dataset
data %>% group_by(subj, sleepdep, block) %>% do({
  d <- .
  
  ## get taps (keys)
  dd=filter(d, stimulus=="tap")
  taps=as.integer(factor(dd$response, levels=c("lctrl","rctrl"), labels=c("left","right")))-1
  taps=tail(taps, nback)
  
  ## unravel tap-timings
  iti=dd$time %>% diff %>% tail(nback)
  
  ## return summary of it
  data.frame(
    probe1=as.integer(d$response[d$stimulus=="probe1"])+1,
    probe2=as.integer(d$response[d$stimulus=="probe2"])+1,
    probe3=as.integer(d$response[d$stimulus=="probe3"])+1,
    apen=apen_int(taps,which.apen)[which.apen+1],
    bv=sd(iti)
  )
}) %>% ungroup %>% 
  mutate(across(starts_with("probe"), ~ ordered(.x, levels=1:4)),
         logapen=-log(log(2)-apen),
         logbv=log(bv),
         zlogapen=(logapen-mean(logapen))/sd(logapen),
         zlogbv=(logbv-mean(logbv))/sd(logbv))-> data.probe

save(data.probe, file="ex2/data/data.probe.rdata")
