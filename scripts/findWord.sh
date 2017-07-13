#!/bin/sh

character=$1
path=$2
echo "##### FINDING CHARACTER '$character' #####"
results=$(grep -l $character $path/*)

for filename in $results
do
	echo " * "$filename 
done

exit 0
