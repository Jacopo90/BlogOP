#!/bin/sh
## author : Jacopo Pappalettera
## edited : 21/07/2017
## Takes every values from a json file with a specified tag name! and pass it to the find.sh script

source $(dirname $0)/path.sh

source_path=$texts_path
key_list=$1
json_file=$2

if [[ ! $key_list ]]; then
	echo "ERROR: no key list provided"
	exit 1
fi

if [[ ! $json_file ]]; then
	echo "ERROR: no json file provided"
	exit 1
fi

list=$(jq .''$key_list'|.[]' $json_file)
for name in $list
do
	clean_name=$(echo $name | tr -d '"' | tr -d ',' )
	if [[ ${#clean_name} > 1 ]]; then
		sh find_word.sh $clean_name $source_path
	fi
done
exit 0
