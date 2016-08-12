#!/bin/bash

min=100

for a in $(cat $1)
do
if [[ $a -lt "$min" ]]; then
	min=$a	
fi
done
echo "Minimal number is $min"

