#!/bin/bash

# *********************************************************************************
# Choosing exrta number
# $1 - number with extra number
# *********************************************************************************


# Parameters for project.
# Parameters for project.
cd ../
: ${WORKSPACE:=`pwd`}
: ${ANALIZE_SPACE:=${WORKSPACE}/analize}
: ${SCRIPTS:=${WORKSPACE}/scripts}
: ${RESULTS:=${WORKSPACE}/results}
echo WORKSPACE=${WORKSPACE}
echo RESULTS=${RESULTS}
for a in `seq 1 7`
do
	num=cat ${RESULTS}/outputfile.csv | grep "37| $1" | wc -l
	echo "Extra number with $1 should be $num"
done

echo "You are winner of 8000000 NIS! Try it :) "


