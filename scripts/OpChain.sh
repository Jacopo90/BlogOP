#!/bin/sh
source path.sh

selected_tag=$1
tags_path=$tags_path
source_path=$texts_path
structure_path=$structure_path


all_keys=$(jq 'keys|.[]' $tags_path)
for key in $all_keys
do
    clean_key=$(echo $key | tr -d '"')
    sh findTaggedWords.sh $clean_key
    sh find.sh $key
done
exit 0;

