#!/bin/bash

# Input and output files
input_file="synthesis.log"
output_file="UniqModules.txt"



if [ ! -f "$input_file" ]; then
        echo "logfile $input_file not found"
        exit 1
fi


grep -E "^Info.*Linking" "$input_file" |awk '{print $4}' |sort -u  > "$output_file"

echo "Done"




#####
#grep "Linking design" synthesis.log | awk '{print $4}' | sort -u
