# This file is responsible for cleaning the data

### USAGE NOTES ###

### Run the following line for the Makefile:

# Rscript 02_read-clean.R --file_path="../data/data.xls" --output_path="../data/clean/data.xls"

"This script reads and cleans the data

Usage: 02_read-clean.R --file_path=<file_path> --output_path=<output_path>
" -> doc

opt <- docopt::docopt(doc)

# Assign url
file_path <- opt$file_path

# Assign output path
output_path <- opt$output_path

# copy file to output path
file.copy(file_path, output_path)


print("Finished script 2: Cleaning the data")