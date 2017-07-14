#!/bin/sh

selected_tag=$1
tags_path=$2
source_path=$3

all_keys=$(jq 'keys|.[]' $tags_path)

search_tag=""
for key in $all_keys
do
  clean_key=$(echo $key | tr -d '"')
  object=$(jq .''$key'' $tags_path)
  clean_object=$(echo $object | tr -d '"')
  if [ $clean_key = $selected_tag ]
  then
   search_tag="$clean_object" 
  fi
done
results=$(grep -l "$search_tag*" $source_path/*)


