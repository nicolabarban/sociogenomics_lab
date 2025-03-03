# Load necessary library
library(data.table)

# Load the data
file_path <- "height_sim.phen"
data <- fread(file_path)

# Check the structure of the data
str(data)

# Identify the numerical columns and add random noise
numeric_cols <- sapply(data, is.numeric)
data[, (names(data)[numeric_cols]) := lapply(.SD, function(x) x + rnorm(length(x), mean = 0, sd = 1)), .SDcols = numeric_cols]

# Save the modified dataset
output_path <- "height_sim2.phen"
fwrite(data, output_path)

cat("Modified file saved to:", output_path, "\n")