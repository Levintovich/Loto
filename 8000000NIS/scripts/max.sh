#!/bin/bash

max=1

for a in $(cat $1)
do
if [[ $a -gt "$max" ]]; then
	max=$a	
fi
done
echo "Maximal number is $max"

