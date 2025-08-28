#!/bin/bash

logfile="synthesis.log"

echo -e "ErrorType\t\tCount"

grep -oE "Error: (Setup violation|Hold violation)" "$logfile" \
  | sed 's/Error: //' \
  | sort \
  | uniq -c \
  | awk '{printf "%-20s %d\n", $2" "$3, $1}'
