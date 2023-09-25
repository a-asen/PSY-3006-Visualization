## General
-   [/] README
    -   [x] Add information
-   [x] Add to-do file

## Reading
-   [x] Grammer of Graphics:
    -   [x] Applied statistics using R: a Guide for the Social Sciences - Chapter 5
    -   [/] The Grammer of Graphics  [50%]
-   [x] Visual display of quantitative data
    -   [ ] Reflection 
-   [ ] Github markdown (different from normal markdown)
-   [ ] [Quarto (report)](https://quarto.org/docs/guide/)


## Exercise 1: circle plot - seasonal
-   [x] Fake data folder
    -   [x] Daylight hour in Tromsø (API call)
    -   [x] Create fake data
    -   [x] Random variation based on a trend
      -   [x] (rnorm can take a vector to change the underlying curve)
    -   [x] Integrate daylight hour & fake data
    -   [x] Structure the data frame (see picture)
        -   [x] Add picture
-   [x] Report: 
    - [x] Motivation?
    -   [x] Visualization
    - [x] normal plot
    -   [x] circle plot
    - [x] aesthetic changes
    -   [x] other groupings

## Exercise 2: circle plot - sleep
- [ ] Data: mw-sleep. 
	- [ ] transform 
		- [ ] dummy: 24 hours, dot indicate sleep/nosleep, count them (over partic.)
	
	- [ ] Plot Circular plot mw-sleep - sleep deprivation time, vs NS-sleep. 
	- [ ] circle barplot. 
	- [ ] split by noon-midnight & 6am-6pm 
	- [ ] Half & half plot???? (NS vs. PSD?)
	- [ ] Overlay NS & PSD sleep. 
	- [ ] Compare against normal plot



## Exercise 3
3rd VIS?
10. Distributions: Yes, but use different dataset, because 
10.1: Reaction times

- distributions
- [ ] Find/make data
- ex-gaussian
- wiener distribution (drift diffusion model)
- Quantile distribution (reaction time, ratcliff)

- Normal &/ bimodal. 
   - Movie rating

- Histogram/violinplot. 
   
   USE: 
continuous:
1 - reaction time (bodyheight / death age) 
2 - bimodal (reaction time over sleep preference)
   rainplot.

discrete: 
   -  Kruschke lidell visualization. 

    - Bivariet distributions.


Distribution of raw AE data. 
AE plots? 


## Exercise 4

## Exercise 5

## Exam 
- [ ] Change exam: short exam report, link to Github (repo) reports. 
- Plot 1 - circle plots
  - [ ] Change using scale & not transform (data)? 
  - [ ] dont use CI - rather SE or quantile
  - [ ] maybe, sleep/wake time instead? 
  - [ ] instead of "daylight hour", also indicte WHEN the sun rise AND set 
	- in connection to sleep time/wake time  this could be nice
  - [ ] Discuss some contrast with Circilize ???? 
  
  - [ ] Add segments? (e.g., annotate("rect",xmin=1,xmax=13,ymin=6,ymax=10, alpha=.4, fill="#208aaa"))
       - Just use lines to indicate start of season, instead. 

- [ ] Visualizing
  - [ ] Grammer of graphics
    - [ ] Benefits of this framework 

