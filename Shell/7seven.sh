#!/bin/bash

input_file="timingRpt.txt"

if [ ! -f "$input_file" ]; then
    echo "Error: $input_file not found!"
    exit 1
fi

echo "ClockName   Count"
echo "-----------------"

# Extract clock names and count occurrences
grep "^Clock:" "$input_file" | awk '{print $2}' | sort | uniq -c | awk '{print $2, $1}' | while read -r name count; do
    printf "%-10s %d\n" "$name" "$count"
done

