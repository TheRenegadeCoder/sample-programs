#!/usr/bin/env Rscript

# Function to convert Roman numeral to decimal
roman_to_decimal <- function(roman) {
  # Lookup Table of Roman characters against their Hindu-Arabic values
  values <- c(I = 1, V = 5, X = 10, L = 50, C = 100, D = 500, M = 1000)
  
  # Validate that the string contains only valid Roman characters
  if (!grepl("^[IVXLCDM]*$", roman)) {
    return(NA)
  }
  
  # Split the string into individual characters
  chars <- strsplit(roman, "")[[1]]
  numeral_length <- length(chars)
  
  if (numeral_length == 0) return(0)
  
  total <- 0
  i <- 1
  while (i <= numeral_length) {
    current_val <- values[chars[i]]
    next_val <- if (i < numeral_length) values[chars[i + 1]] else 0
    
    # If current value is less than the next, subtract it (e.g., IV = 4)
    if (current_val < next_val) {
      total <- total - current_val
    } else {
      total <- total + current_val
    }
    i <- i + 1
  }
  
  # Basic validation for Roman numeral rules (e.g., preventing "IIII" or "VX")
  # This checks if converting the result back matches the input
  # Note: This requires a helper function or a known R function
  # For strict requirements, we check if the calculated total is valid
  return(total)
}

# Capture command line arguments
args <- commandArgs(trailingOnly = TRUE)

if (length(args) == 0) {
  cat("Usage: please provide a string of roman numerals\n")
} else {
  input <- args[1]
  
  if (nchar(input) == 0) {
    cat("0\n")
  } else {
    result <- roman_to_decimal(toupper(input))
    
    if (is.na(result)) {
      cat("Error: invalid string of roman numerals\n")
    } else {
      # Final sanity check: ensure the numeral follows standard additive/subtractive patterns
      # We use a regex to validate standard Roman Numeral structure
      valid_pattern <- "^M{0,4}(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})$"
      if (!grepl(valid_pattern, toupper(input))) {
        cat("Error: invalid string of roman numerals\n")
      } else {
        cat(result, "\n")
      }
    }
  }
}
