#!/bin/bash

logfile="synthesis.log"

grep -oE "\(TIM-[0-9]+\)|\(DES-[0-9]+\)" "$logfile" | tr -d '()'
