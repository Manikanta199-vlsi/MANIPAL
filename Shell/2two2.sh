#!/bin/bash

# Input and output files
input_file="synthesis.log"
output_file="multi.txt"

if [ ! -f "$input_file" ]; then
        echo "logfile $input_file not found"
        exit 1
fi

# finding the lines that countain multiple drivers

driver=$(grep -E "^Warning.*multiple" "$input_file" | awk '{print $3}')

count=0
for i in $driver;do
	echo "driver [$count]: $i"
	((count++))
done
echo " Done"

