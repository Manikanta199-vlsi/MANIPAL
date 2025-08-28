#!/bin/bash

# File: find_worst_wns.sh
# Description: Find the module with the worst WNS from timing report

timing_file="timingRpt.txt"

if [[ ! -f "$timing_file" ]]; then
    echo "Error: File '$timing_file' not found!"
    exit 1
fi

awk '
/^Design:/ { module=$2 }

/Worst Negative Slack/ {
    match($0, /-?[0-9]+\.[0-9]+/)
    wns=substr($0, RSTART, RLENGTH) + 0  # force numeric conversion
    if (min == "" || wns < min) { min=wns; worstmod=module }
}

END {
    if (min != "") {
        printf "%-15s %10s\n", "ModuleName", "WorstWNS"
        printf "%-15s %10s\n", worstmod, min
    } else {
        print "No WNS found in the file."
    }
}' "$timing_file"
