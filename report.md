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

#### RCP 26 (less extreme climate change scenario)

![](report_files/figure-markdown_github/load%20RCP%2026s-1.png)![](report_files/figure-markdown_github/load%20RCP%2026s-2.png)

#### RCP 85 (more extreme climate change scenario)

![](report_files/figure-markdown_github/load%20RCP%2085s-1.png)![](report_files/figure-markdown_github/load%20RCP%2085s-2.png)
