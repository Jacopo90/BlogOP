#!/bin/sh

source_path=$3
json_file=$2
key_list=$1

list=$(jq .''$key_list'|.[]' $json_file)
for name in $list
do
  clean_name=$(echo $name | tr -d '"')
  sh findWord.sh $clean_name $source_path
done
