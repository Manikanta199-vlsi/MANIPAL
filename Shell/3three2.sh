#!/bin/bash

# Input and output files
input_file="timingRpt.txt"
output_file="clockName.txt"

if [ ! -f "$input_file" ]; then
        echo "logfile $input_file not found"
        exit 1
fi


# finding the lines starting vth Clock & printing 2nd ,4th words of LINE

count=1
grep  "^Clock" "$input_file" |awk '{print $2 " " $4}' |while read -r name period;do

	echo "clock[$count] = $name $period"
	((count++))
done



echo " Done"

