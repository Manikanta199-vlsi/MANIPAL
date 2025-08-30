#!/bin/bash

report="timingRpt.txt"   # Your timing report file
threshold=-0.5           # WNS threshold

echo "Modules with WNS worse than $threshold ns:"
count=0

while read -r line; do
    # Capture module name (robust to indentation)
    if echo "$line" | grep -q "Design:"; then
        module=$(echo "$line" | awk '{print $NF}')
       # echo "DEBUG: Found new module = $module"
    fi

    # Capture WNS lines
    if [[ $line == *"WNS"* ]]; then
        clean_line=$(echo "$line" | tr -d '\r')
        wns=$(echo "$clean_line" | awk '{print $5}')

      #  echo "DEBUG: Module=$module , WNS=$wns"

        awk "BEGIN {exit !($wns < $threshold)}"
        if [[ $? -eq 0 ]]; then
            echo "  $module → WNS = $wns ns"
            ((count++))
        fi
    fi
done < "$report"

echo "------------------------------------"
echo "Total modules worse than $threshold ns: $count"
