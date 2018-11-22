Macaws SDM
================
Renata Diaz
11/20/2018

Maxent models
-------------

#### Response plots:

    ## Loading required namespace: rJava

![](report_files/figure-markdown_github/load%20maxent%20models-1.png)![](report_files/figure-markdown_github/load%20maxent%20models-2.png)![](report_files/figure-markdown_github/load%20maxent%20models-3.png)![](report_files/figure-markdown_github/load%20maxent%20models-4.png)![](report_files/figure-markdown_github/load%20maxent%20models-5.png)

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
    ## 
    ## $beta1
    ## [1] 0.987

The model with high beta (beta = 1) has the highest correlation coefficient, although it's worth noting that all of the models perform well and they generate qualitatively similar response plots.

Further analyses done using the model with beta = 1.

Predictions
-----------

### Raw predictions

#### Present

![](report_files/figure-markdown_github/load%20present%20raw-1.png)

#### RCP 26 (less extreme climate change scenario)

![](report_files/figure-markdown_github/load%20RCP%2026s%20raw-1.png)![](report_files/figure-markdown_github/load%20RCP%2026s%20raw-2.png)

#### RCP 85 (more extreme climate change scenario)

![](report_files/figure-markdown_github/load%20RCP%2085s%20raw-1.png)![](report_files/figure-markdown_github/load%20RCP%2085s%20raw-2.png)

### Thresholded predictions

Thresholded based on the 50% and 80% quantiles of the model prediction generated from present-day data. These thresholds are approximately 0.05 and 0.25, respectively. The quantiles can be changed using the thresholding section of run.R.

1 = low, 2 = med, 3 = high.

#### Present

![](report_files/figure-markdown_github/load%20present%20thresh-1.png)

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
    ## 1    22449490 11860406 6496946 4092138  26 50 0.5283152 0.2894028
    ## 2    22449490 10000654 8064136 4384700  26 70 0.4454735 0.3592124
    ## 3    22449490 10242180 8278268 3929042  85 50 0.4562322 0.3687508
    ## 4    22449490 14476662 4858168 3114660  85 70 0.6448548 0.2164044
    ## 5    22449490 11224745 6734847 4489898  NA 18 0.5000000 0.3000000
    ##    prophigh
    ## 1 0.1822820
    ## 2 0.1953140
    ## 3 0.1750170
    ## 4 0.1387408
    ## 5 0.2000000
