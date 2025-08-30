#!/bin/bash

logfile="synthesis.log"

if [ ! -f "$logfile" ]; then
    echo "Error: $logfile not found!"
    exit 1
fi

# Count setup violations
setup_count=$(grep -i "setup violation" "$logfile" | wc -l)

# Count hold violations
hold_count=$(grep -i "hold violation" "$logfile" | wc -l)

echo "----------------------------------------"
echo "Violation Summary from $logfile"
echo "----------------------------------------"
echo "Total Setup Violations : $setup_count"
echo "Total Hold Violations  : $hold_count"
echo "----------------------------------------"
