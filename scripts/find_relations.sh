#!/bin/sh
## author : Jacopo Pappalettera
## edited : 20/07/2017
## 

source path.sh

stat_file_name=$default_stat_file_name
if [[ "$1" = "--default" ]]; then
    source_path=$texts_path
else
    source_path=$1
fi

arg_set=()
j=0
shift
while test ${#} -gt 0
do
  arg_set[$j]=$1
  shift
  (( j ++ ))
done

if [ -z "$arg_set" ]; then
	echo "ERROR: no search keys"
    exit 1
fi

all_files=$(find $source_path -type f)

## founding relations in all files
for file_path in $all_files; do
	# check if file name is equal to the default stats file name
	file_name=$(basename $file_path)
	if [[ "$file_name" = "$stat_file_name" ]]; then

		found_relation=false
		for search_key in ${arg_set[@]}; do
			found=false
			## prints all values of the json file
			list=$(jq '.[]' $file_path  | sort -u)

			## cycling all values in the stats file json
			for name in $list; do
  				clean_name=$(echo $name | tr -d '"' | tr -d ',')
  				if [[ ${#clean_name} > 1 && "$clean_name" = "$search_key" ]]; then
  					found=true
  					break
					else
					found=false
				fi
			done

			if [[ $found = true ]]; then
					found_relation=true
				else
					found_relation=false
					break
			fi
		done

		if [[ $found_relation = true ]]; then
			echo $file_path
		fi
	fi
done
exit 0