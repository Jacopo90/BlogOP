#!/bin/sh
source path.sh

source_path=$texts_path
json_file=$structure_path
key_list=$1

list=$(jq .''$key_list'|.[]' $json_file)
for name in $list
do
  clean_name=$(echo $name | tr -d '"')
  sh findWord.sh $clean_name $source_path
done

