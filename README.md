<!-- README.md is generated from README.Rmd. Please edit that file -->
rf-map
======

Downloading the RF-MAP files
----------------------------

There are two ways to download the RF-MAP files:

1.  From the Linux command line, type
    `git clone https://github.com/dkahle/rf-map.git`; the directory will
    appear in the directory given by typing `pwd` at the command line.
2.  From within RStudio, go to File &gt; New Project… &gt; Version
    Control &gt; Git, then type in
    `https://github.com/dkahle/rf-map.git` as the repository, and Create
    Project.

The GitHub repository has three main files:

-   `busi.csv`, which contains data used for generating the RF-MAP
    model,
-   `input.csv`, which is a template file for entering new data, and
-   `rf-map.R`, the R file that generates the RF-MAP model.

Reproducibility
---------------

Please note - although you are re-creating the RF-MAP model from the
same training data that is published in the manuscript, the model will
inherently be unique every time it is generated if you don’t fix the
random number generator seed with `set.seed()`. The paper was generated
using `set.seed(42)`.

Installation and operating instructions
---------------------------------------

1.  Populate the `input.csv` file with uppermost B horizon data for
    which you would like to predict mean annual precipitation (MAP)
    values. Column headings must have the same names (case-sensitive);
    however, they can be in any order. Alternatively, you can use any
    `.csv` file that contains your data, as long as the column headings
    for the input variables have the same formatting as those in
    `input.csv` file.
2.  Open the R file `rf-map.R`
3.  Follow the commented script; [the **here**
    package](https://cran.r-project.org/web/packages/here/index.html)
    should take care of pathing.
4.  The R script will generate an output file named `output.csv` that
    will contain the predicted MAP values in a column named `RFMAP`.

Here’s an example with the BU-SI data (note that it does not do
prediction, it just fits the random forest):

``` r
library("here"); library("randomForest")
#  here() starts at /Users/david_kahle/Dropbox/dev/rf-map/rf-map
#  randomForest 4.6-14
#  Type rfNews() to see new features/changes/bug fixes.

busi <- read.csv(
  file = here("busi.csv"), 
  header = TRUE, na.strings = c("", " ", "NA")
) 

set.seed(42L)
randomForest(MAP ~ ., data = busi, importance = TRUE)
#  
#  Call:
#   randomForest(formula = MAP ~ ., data = busi, importance = TRUE) 
#                 Type of random forest: regression
#                       Number of trees: 500
#  No. of variables tried at each split: 3
#  
#            Mean of squared residuals: 199233.7
#                      % Var explained: 57.39
```

Design
------

The RF-MAP model was designed in RStudio, see the output of
`devtools::session_info()` below. RF-MAP is a random forest model built
using
[**randomForest**](https://cran.r-project.org/web/packages/randomForest/index.html)
(Therneu et al., 2018).

``` r
Session info -----------------------------------------------------------------------------------------------------------------
 setting  value                       
 version  R version 3.4.3 (2017-11-30)
 system   x86_64, mingw32             
 ui       RStudio (1.1.383)           
 language (EN)                        
 collate  English_United States.1252  
 tz       America/Chicago             
 date     2018-10-10                  

Packages ---------------------------------------------------------------------------------------------------------------------
 package      * version date       source        
 assertthat     0.2.0   2017-04-11 CRAN (R 3.4.3)
 base         * 3.4.3   2017-12-06 local         
 bindr          0.1     2016-11-13 CRAN (R 3.4.3)
 bindrcpp       0.2     2017-06-17 CRAN (R 3.4.3)
 broom          0.4.4   2018-03-29 CRAN (R 3.4.4)
 cellranger     1.1.0   2016-07-27 CRAN (R 3.4.3)
 cli            1.0.0   2017-11-05 CRAN (R 3.4.3)
 colorspace     1.3-2   2016-12-14 CRAN (R 3.4.3)
 compiler       3.4.3   2017-12-06 local         
 crayon         1.3.4   2017-09-16 CRAN (R 3.4.3)
 datasets     * 3.4.3   2017-12-06 local         
 devtools     * 1.13.6  2018-06-27 CRAN (R 3.4.4)
 digest         0.6.13  2017-12-14 CRAN (R 3.4.3)
 dplyr        * 0.7.4   2017-09-28 CRAN (R 3.4.3)
 forcats      * 0.3.0   2018-02-19 CRAN (R 3.4.3)
 foreign        0.8-69  2017-06-22 CRAN (R 3.4.3)
 ggplot2      * 2.2.1   2016-12-30 CRAN (R 3.4.3)
 glue           1.2.0   2017-10-29 CRAN (R 3.4.3)
 graphics     * 3.4.3   2017-12-06 local         
 grDevices    * 3.4.3   2017-12-06 local         
 grid           3.4.3   2017-12-06 local         
 gtable         0.2.0   2016-02-26 CRAN (R 3.4.3)
 haven          1.1.1   2018-01-18 CRAN (R 3.4.3)
 hms            0.4.2   2018-03-10 CRAN (R 3.4.3)
 httr           1.3.1   2017-08-20 CRAN (R 3.4.3)
 jsonlite       1.5     2017-06-01 CRAN (R 3.4.3)
 lattice        0.20-35 2017-03-25 CRAN (R 3.4.3)
 lazyeval       0.2.1   2017-10-29 CRAN (R 3.4.3)
 lubridate      1.7.2   2018-02-06 CRAN (R 3.4.3)
 magrittr     * 1.5     2014-11-22 CRAN (R 3.4.3)
 memoise        1.1.0   2017-04-21 CRAN (R 3.4.4)
 methods      * 3.4.3   2017-12-06 local         
 mnormt         1.5-5   2016-10-15 CRAN (R 3.4.1)
 modelr         0.1.1   2017-07-24 CRAN (R 3.4.3)
 munsell        0.4.3   2016-02-13 CRAN (R 3.4.3)
 nlme           3.1-131 2017-02-06 CRAN (R 3.4.3)
 parallel       3.4.3   2017-12-06 local         
 pillar         1.0.1   2017-11-27 CRAN (R 3.4.3)
 pkgconfig      2.0.1   2017-03-21 CRAN (R 3.4.3)
 plyr           1.8.4   2016-06-08 CRAN (R 3.4.3)
 psych          1.7.8   2017-09-09 CRAN (R 3.4.3)
 purrr        * 0.2.4   2017-10-18 CRAN (R 3.4.3)
 R6             2.2.2   2017-06-17 CRAN (R 3.4.3)
 randomForest * 4.6-12  2015-10-07 CRAN (R 3.4.3)
 Rcpp           0.12.14 2017-11-23 CRAN (R 3.4.3)
 readr        * 1.1.1   2017-05-16 CRAN (R 3.4.3)
 readxl         1.0.0   2017-04-18 CRAN (R 3.4.3)
 reshape2     * 1.4.3   2017-12-11 CRAN (R 3.4.3)
 rlang          0.2.0   2018-02-20 CRAN (R 3.4.3)
 rpart        * 4.1-12  2018-01-12 CRAN (R 3.4.3)
 rpart.plot   * 2.1.2   2017-04-20 CRAN (R 3.4.3)
 rstudioapi     0.7     2017-09-07 CRAN (R 3.4.3)
 rvest          0.3.2   2016-06-17 CRAN (R 3.4.3)
 scales         0.5.0   2017-08-24 CRAN (R 3.4.3)
 stats        * 3.4.3   2017-12-06 local         
 stringi        1.1.6   2017-11-17 CRAN (R 3.4.2)
 stringr      * 1.2.0   2017-02-18 CRAN (R 3.4.3)
 tibble       * 1.4.1   2017-12-25 CRAN (R 3.4.3)
 tidyr        * 0.8.0   2018-01-29 CRAN (R 3.4.3)
 tidyverse    * 1.2.1   2017-11-14 CRAN (R 3.4.3)
 tools          3.4.3   2017-12-06 local         
 utils        * 3.4.3   2017-12-06 local         
 withr          2.1.2   2018-03-15 CRAN (R 3.4.3)
 xml2           1.2.0   2018-01-24 CRAN (R 3.4.3)
 yaml           2.1.16  2017-12-12 CRAN (R 3.4.3)
```
