Macaws SDM
================
Renata Diaz
11/20/2018

Maxent models
-------------

#### Response plots:

    ## Loading required namespace: rJava

![](report_files/figure-markdown_github/load%20maxent%20models-1.png)![](report_files/figure-markdown_github/load%20maxent%20models-2.png)![](report_files/figure-markdown_github/load%20maxent%20models-3.png)![](report_files/figure-markdown_github/load%20maxent%20models-4.png)

#### Boyce's criterion

Correlation coefficient for each model:

    ## $beta0.01
    ## [1] 0.97
    ## 
    ## $beta0.1
    ## [1] 0.972
    ## 
    ## $beta0.5
    ## [1] 0.976
    ## 
    ## $beta0.9
    ## [1] 0.985

The model with high beta (0.9) has the highest correlation coefficient, although it's worth noting that all of the models perform well and they generate qualitatively similar response plots.

Further analyses done using the model with beta = 0.9.

Future predictions
------------------

### Raw predictions

#### RCP 26 (less extreme climate change scenario)

![](report_files/figure-markdown_github/load%20RCP%2026s%20raw-1.png)![](report_files/figure-markdown_github/load%20RCP%2026s%20raw-2.png)

#### RCP 85 (more extreme climate change scenario)

![](report_files/figure-markdown_github/load%20RCP%2085s%20raw-1.png)![](report_files/figure-markdown_github/load%20RCP%2085s%20raw-2.png)

### Thresholded predictions

Thresholded based on the 50% and 80% quantiles of the model prediction generated from present-day data. These thresholds are approximately 0.05 and 0.25, respectively. The quantiles can be changed using the thresholding section of run.R.

1 = low, 2 = med, 3 = high.

#### RCP 26 (less extreme climate change scenario)

![](report_files/figure-markdown_github/load%20RCP%2026s%20thresholded-1.png)![](report_files/figure-markdown_github/load%20RCP%2026s%20thresholded-2.png)

#### RCP 85 (more extreme climate change scenario)

![](report_files/figure-markdown_github/load%20RCP%2085s%20thresholded-1.png)![](report_files/figure-markdown_github/load%20RCP%2085s%20thresholded-2.png)

#### Summary stats based on thresholds

    ## Warning: package 'dplyr' was built under R version 3.5.1

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

    ##   total_cells     lows mediums   highs rcp yr   proplow   propmed
    ## 1    22449490 11924095 6771711 3753684  26 50 0.5311522 0.3016421
    ## 2    22449490 10124091 8287831 4037568  26 70 0.4509720 0.3691768
    ## 3    22449490 10502835 8301630 3645025  85 50 0.4678429 0.3697915
    ## 4    22449490 14696492 5003491 2749507  85 70 0.6546470 0.2228777
    ## 5    22449490 11224745 6734847 4489898  NA 18 0.5000000 0.3000000
    ##    prophigh
    ## 1 0.1672058
    ## 2 0.1798512
    ## 3 0.1623656
    ## 4 0.1224753
    ## 5 0.2000000
