#!/bin/sh
## author : Jacopo Pappalettera
## edited : 19/07/2017
## Takes every values from a json file and pass it to the find.sh script
## Is this script can be useful???

source path.sh

source_path=$texts_path
json_file=$structure_path
key_list=$1

list=$(jq .''$key_list'|.[]' $json_file)
for name in $list
do
  clean_name=$(echo $name | tr -d '"')
  sh find_word.sh $clean_name $source_path
done

