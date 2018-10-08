# This script will re-create a version of the RF-MAP model on your system. It is associated with the following manuscript:
# Lukens, W.E., Stinchcomb, G.E., Nordt, L.C., Driese, S.G., Kahle, D.J., and Tubbs, J.D., 
# Recursive partitioning improves paleosol estimates for rainfall, 
# submitted to the American Journal of Science, October 2018

# The following code will build the RF-MAP model using the BU-SI uppermost B horizon data set



#### I. Setup ####
# Set your working directory: change the file path to the folder that contains your data files (.csv format)
# Note: if you are using a PC, make sure you change backslashes to forward slashes
if (!requireNamespace("here")) install.packages("here")
library("here")



# Read in your data file
busi <- read.csv(
  file = here("busi.csv"), 
  header = TRUE, na.strings = c("", " ", "NA")
) 



#### Build the RFMAP model ####

# Install the randomForest package, if needed
if (!requireNamespace("randomForest")) install.packages("randomForest")
library("randomForest")

# Generate the RFMAP model
set.seed(42L)
(rfmap <- randomForest(MAP ~ ., data = busi, importance = TRUE))



#### Apply the RFMAP model on new data ####
# First load in your new data. The .csv file is named "input.csv"
# You can load in any csv file, but make sure you update the file name in the next line:
input <- read.csv(here("input.csv"), header = TRUE, na.strings = c("", " ", "NA"))

# Predict MAP values
output <- input
output$rfmap <- predict(rfmap, newdata = input) # prediction error = 440 mm

# Save results as an output file; the RFMAP column will contain your MAP values
write.csv(output, here("output.csv"))
# The output.csv file is now located in your directory folder.
# Please use a prediction error of 440 mm associated with all output values.

# Please note: each version of the RF-MAP model that is re-created will be slightly different from all other versions.
# This means that the exact predicted values will likely differ from other versions, but will be quite close and
# within error of one another. Please consult the authors with any questions or bugs.

