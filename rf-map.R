# This script is for applying the RFMAP model 
# The following code will build the model using the BU-SI uppermost B horizon data set
# An example is provided that will facilitate applicaiton of the model on new data

#### I. Setup ####
# Set your working directory: change the file path to the folder that contains your data files (.csv format)
# Note: if you are using a PC, make sure you change backslashes to forward slashes
setwd("C:/.../RFMAP")
setwd("/Users/williamlukens/Desktop/RFMAP")

# Read in your data file
BUSI <- read.csv("BUSI.csv", header = TRUE, na.strings=c("", " ", "NA")) 

#### Build the RFMAP model ####
# Install the randomForest package
install.packages("randomForest")
require(randomForest)

# Generate the RFMAP model
RFMAP <- randomForest(MAP ~ ., data = BUSI, importance=TRUE) 
RFMAP #Summary of the model; use a prediction error of 442 mm

#### Apply the RFMAP model on new data ####
# First load in your new data. The .csv file is named "Input.csv"
# You can load in any csv file, but make sure you update the file name in the next line:
Input <- read.csv("Input.csv", header = TRUE, na.strings=c("", " ", "NA"))

# Predict MAP values
Output <- predict(RFMAP, newdata=Input)

# Save results as an output file; the second column will be your MAP values
write.csv(Output, "Output.csv")

# This code is part of the following manuscript:
# Lukens, W.E., Stinchcomb, G.E., Nordt, L.C., Driese, S.G., Kahle, D.J., and Tubbs, J.D., 
# Recursive partitioning improves paleosol estimates for rainfall, 
# submitted to the American Journal of Science, October 2018