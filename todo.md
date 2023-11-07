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
-   [x] Fake data:
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
- [ ] Add Feedback


## Exercise 2: circle plot - sleep
- [x] Data: mind wandering sleep 
	- [x] circle barplot. 
	- [x] split by noon-midnight & 6am-6pm 
	- [x] Overlay NS & PSD sleep. 
	- [x] Compare against normal plot
- [ ] Add Feedback

## Exercise 3
- [x] Data: mind wandering
- [x] Visualization:
  - [x] Data distribution
  - [x] Joint distribution
    - [x] Joint distribution with individual distribution
- [ ] Why multivariate visualization?
- [ ] Add Feedback

## Exercsise 4
- [x] Data: Mind wandering
- [x] Visualization 
  - [x] Distribution w/hist/other
  - [x] Ridge
  - [x] Ridges testing
  - [x] Different variable (BV)
  - [x] Different dataset (iris)
- [ ] Add Feedback




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

