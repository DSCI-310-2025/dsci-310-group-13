# This file is responsible for loading and saving the data for this project, no libraries necessary

### USAGE NOTES ###

### Run the following line for the Makefile:

# Rscript 01_load.R --url="https://archive.ics.uci.edu/ml/machine-learning-databases/00257/Data_User_Modeling_Dataset_Hamdi%20Tolga%20KAHRAMAN.xls" --output_path="../data/data.xls"

# Note that the url path should be: "https://archive.ics.uci.edu/ml/machine-learning-databases/00257/Data_User_Modeling_Dataset_Hamdi%20Tolga%20KAHRAMAN.xls"
# Note that the output path should be: "../data/data.xls"

"This script loads, and saves the data

Usage: 01_load.R --url=<url> --output_path=<output_path>
" -> doc

opt <- docopt::docopt(doc)

# Assign url
url <- opt$url 

# Assign output path
output_path <- opt$output_path

download.file(url, output_path, mode = 'wb')

print("Finished script 1: Loading the data")