#!/bin/sh
## author : Jacopo Pappalettera
## edited : 21/07/2017
## update all stats recursively from $texts_path

source $(dirname $0)/path.sh

source_path=$texts_path
all_files=$(find $source_path -type f)

#updating stats file 
all_directories=()
i=0
for file_path in $all_files; do
	BASEDIR=$(dirname $file_path)
	all_directories[$i]=$BASEDIR
    (( i ++ ))
done 
dir_set=$(echo ${all_directories[@]} | tr ' ' '\n' | sort -u)
for dir in $dir_set; do
	sh update_stats.sh $dir
done 
echo "all stats updated"
exit 0 