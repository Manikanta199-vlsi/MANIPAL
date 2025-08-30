#!/bin/bash

input_file="timingRpt.txt"

if [ ! -f "$input_file" ]; then
    echo "Error: $input_file not found!"
    exit 1
fi

echo "ClockName    Count   Period(ns)"
echo "--------------------------------"

# Step 1: extract clock names + periods → save them in a file
grep "^Clock:" "$input_file" | awk '{print $2, $4}' > clocks.tmp

# Step 2: loop through unique clock names
for clk in $(awk '{print $1}' clocks.tmp | sort | uniq); do

    count=$(grep -c "^$clk " clocks.tmp)              # number of times it appears

    period=$(grep "^$clk " clocks.tmp | awk '{print $2}' | head -1)  # first period value

    printf "%-11s %-6d %s\n" "$clk" "$count" "$period"

done

rm clocks.tmp
