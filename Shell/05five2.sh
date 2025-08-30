#!/bin/bash

logfile="synthesis.log"   # path to your synthesis log file

# Check if file exists
if [ ! -f "$logfile" ]; then
    echo "Error: $logfile not found!"
    exit 1
fi

echo "Extracting unique modules from $logfile ..."
echo "--------------------------------------------"

# Extract module names from 'Linking design' lines
modules=$(grep "Linking design" "$logfile" | awk '{print $4}' | sort -u)

# Print each unique module
count=0
for m in $modules; do
    echo "Module: $m"
    ((count++))
done

echo "--------------------------------------------"
echo "Total unique modules found: $count"
