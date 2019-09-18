# This script will re-create a version of the RF-MAP model on your system. It is associated with the following manuscript:
# Lukens, W.E., Stinchcomb, G.E., Nordt, L.C., Driese, S.G., Kahle, D.J., and Tubbs, J.D., 
# Recursive partitioning improves paleosol estimates for rainfall, 
# submitted to the American Journal of Science, October 2018

# The following code will build the RF-MAP model using the BU-SI uppermost B horizon data set


#### I. Setup ####
# The 'here' package should take care of file pathing.
if (!requireNamespace("here")) install.packages("here")
library("here")

# Read in your data files
busi <- read.csv(
  file = here("busi.csv"), 
  header = TRUE, na.strings = c("", " ", "NA")
) 

busi1600 <- read.csv(
  file = here("busi1600.csv"), 
  header = TRUE, na.strings = c("", " ", "NA")
) 


#### Build the RFMAP model ####

# Install the randomForest package, if needed
if (!requireNamespace("randomForest")) install.packages("randomForest")
library("randomForest")

# Generate the RFMAP model
set.seed(42L)
(rfmap1.0 <- randomForest(MAP ~ ., data = busi, importance = TRUE))
(rfmap2.0 <- randomForest(MAP ~ ., data = busi1600, importance = TRUE))


#### Apply the RFMAP model on new data ####
# First load in your new data. The .csv file is named "input.csv"
# You can load in any csv file, but make sure you update the file name in the next line:
input <- read.csv(
  file = here("input.csv"), 
  header = TRUE, na.strings = c("", " ", "NA")
)

# Predict MAP values
output <- input
output$rfmap <- ifelse(output$version == "2", predict(rfmap2.0, newdata = input),
                       predict(rfmap1.0, newdata = input))
output$rfmap <- round(output$rfmap, 0)
output$error <- ifelse(output$version == "2", "209", "395")


# Save results as an output file; the RFMAP column will contain your MAP values
write.csv(output, here("output.csv"))

# The output.csv file is now located in your directory folder.
# Please use a prediction error of 395 mm associated with all output values for RF-MAP1.0.
# Please use a prediction error of 209 mm associated with all output values for RF-MAP2.0.