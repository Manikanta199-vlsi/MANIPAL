#!/bin/bash

logfile="timingRpt.txt"

awk '
/^Design:/ { module=$2 }
/^Clock:/ {
    match($0, /Clock: ([^(]+) \(period ([0-9.]+) ns\)/, arr)
    clk=arr[1]
    period=arr[2]
    if (period < 1.0) {
        printf "%-15s %s ns\n", clk, period
    }
}' "$logfile"
