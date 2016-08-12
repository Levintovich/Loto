#!/bin/bash

#*************************************************************************
# This program downloads loto results in CSV format,
# generates 6 random different numbers [1-37].
# Programth checks with the sophistcated algorithm if this number exists.
#*************************************************************************

# Parameters for project.
: ${WORKSPACE:=`pwd`}
: ${ANALIZE_SPACE:=${WORKSPACE}/analize}
: ${SCRIPTS:=${WORKSPACE}/scripts}
: ${RESULTS:=${WORKSPACE}/results}

#Download loto results from website
curl -o ${WORKSPACE}/loto.csv http://www.pais.co.il/Lotto/Pages/last_Results.aspx?download=1
cp ${WORKSPACE}/loto.csv ${RESULTS}/outputfile.csv # Copy original file to RESULTS space.

# ************************************************************************************
# Replacing using SED
# **************************************************************************************
sed -i ${RESULTS}/outputfile.csv -e '1d' 			# To remove 1-st line
sed -i ${RESULTS}/outputfile.csv -e 's/"//g'		# To remove all " in the file
sed -i ${RESULTS}/outputfile.csv -e 's/.\{5\}$//'	# To remove 5 last characters from the file
sed -i ${RESULTS}/outputfile.csv -e 's/,/| /2'		# To replace 2-nd , to |
sed -i ${RESULTS}/outputfile.csv -e 's/,/| /7'		# To replace 7-th , to |
sed -i ${RESULTS}/outputfile.csv -e 's/,/ /1'		# To replace 1-st , to |
sed -i ${RESULTS}/outputfile.csv -e '|/,/ /g'		# To replace , to space

cat ${RESULTS}/outputfile.csv | awk '{print $3}' > ${RESULTS}/temp  #to detect result
awk '($1 > 2107)' ${RESULTS}/outputfile.csv
sed -i ${RESULTS}/temp -e 's/,/ /g' # To replace comma to space
sed -i ${RESULTS}/temp -e 's/|//g'  # To remove |
awk '($6 < 38 ) ' ${RESULTS}/temp > ${RESULTS}/results.txt # to remove numbers > 37
rm -rf ${RESULTS}/temp

# *********************************************************************
# Sorting numbers by columns a1 a2 a3 a4 a5 a6
# *********************************************************************

awk '{print $1}' ${RESULTS}/results.txt > ${ANALIZE_SPACE}/a1
awk '{print $2}' ${RESULTS}/results.txt > ${ANALIZE_SPACE}/a2	
awk '{print $3}' ${RESULTS}/results.txt > ${ANALIZE_SPACE}/a3	
awk '{print $4}' ${RESULTS}/results.txt > ${ANALIZE_SPACE}/a4	
awk '{print $5}' ${RESULTS}/results.txt > ${ANALIZE_SPACE}/a5	
awk '{print $6}' ${RESULTS}/results.txt > ${ANALIZE_SPACE}/a6

# *********************************************************************
# Sorting numbers by apperance:
# hot numbers - h
# cool numbers - c
# simple numbers - s
# *********************************************************************
cp ${ANALIZE_SPACE}/Numbers.csv ${ANALIZE_SPACE}/Numbers_modify.csv
sed -i ${ANALIZE_SPACE}/Numbers_modify.csv -e 's/,/ /g' # To replace comma to space

cat ${ANALIZE_SPACE}/Numbers_modify.csv | grep h | awk '{print $1}' > ${ANALIZE_SPACE}/hot_num.txt
cat ${ANALIZE_SPACE}/Numbers_modify.csv | grep c | awk '{print $1}' > ${ANALIZE_SPACE}/cool_num.txt
cat ${ANALIZE_SPACE}/Numbers_modify.csv | grep s | awk '{print $1}' > ${ANALIZE_SPACE}/simple_num.txt

# *********************************************************************************
# Randomization process: Generating 6 different numbers [0=<A1<A2<A3<A4<A5<A6<=37]
# These numbers should be analized.
# *********************************************************************************

${SCRIPTS}/randomization.sh


