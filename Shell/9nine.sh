#!/bin/bash

input="timingRpt.txt"
output="module_summary.txt"

# Write header
printf "%-15s %10s %10s %12s\n" "ModuleName" "WNS" "TNS" "Violations" > "$output"

awk '
/^Design:/            {module=$2}
/Worst Negative Slack/{wns=$5}
/Total Negative Slack/{tns=$6}
/Number of violating/{viol=$5; 
                      printf "%-15s %10s %10s %12s\n", module, wns, tns, viol >> "'$output'"}
' "$input"
