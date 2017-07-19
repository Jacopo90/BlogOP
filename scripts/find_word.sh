#!/bin/sh
## author : Jacopo Pappalettera
## edited : 19/07/2017
## Finds a specified avery occurrence of the specified word in the source folders

word=$1
path=$2
echo "##### FINDING '$word' #####"
results=$(grep -irl $word $path/*)

for filename in $results
do
	echo " * "$filename 
done

exit 0
