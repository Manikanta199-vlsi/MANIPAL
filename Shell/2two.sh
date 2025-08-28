#!/bin/bash

# Input and output files
input_file="synthesis.log"
output_file="multi.txt"

if [ ! -f "$input_file" ]; then
	echo "logfile $input_file not found"
	exit 1
fi

# finding the lines that countain multiple drivers

grep -E "^Warning.*multiple" "$input_file" | awk '{print $3}' > "$output_file"

echo " output file with warning messages of multi drivers is ready"


