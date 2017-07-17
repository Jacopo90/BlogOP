#!/bin/sh

word=$1
path=$2
echo "##### FINDING '$word' #####"
results=$(grep -il $word $path/*)

for filename in $results
do
	echo " * "$filename 
done

exit 0
