#!/bin/bash

# Input and output files
input_file="synthesis.log"
output_file="errors.txt"

# Check if input file exists
if [ ! -f "$input_file" ]; then
    echo "Input file $input_file not found!"
    exit 1
fi

# Extract lines containing "ERROR"
grep "Error" "$input_file" > "$output_file"

# Success message
echo "All error messages have been saved to $output_file"
