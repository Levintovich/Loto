#!/bin/bash

# *********************************************************************************
# Randomization process: Generating 6 different numbers [0=<A1<A2<A3<A4<A5<A6<=37]
# These numbers should be analized.
# *********************************************************************************


# Parameters for project.
: ${WORKSPACE:=`pwd`/../}
: ${ANALIZE_SPACE:=${WORKSPACE}/analize}
: ${SCRIPTS:=${WORKSPACE}/scripts}
: ${RESULTS:=${WORKSPACE}/results}


#Generating random permutation from 1 to 37

random_num=`shuf -i 1-37 -n 6 | sort -n`
echo $random_num

# Generating extra number
extra=$(( ( RANDOM % 7 )  + 1 ))
echo extra=$extra


#Checking if this random number exists in the file ${RESULTS}/results.txt
if grep -Fxq "$random_num" ${RESULTS}/results.txt 
then
	echo This number exists
else 
	echo This new number
fi