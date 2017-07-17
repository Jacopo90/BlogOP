#!/bin/sh
source path.sh

selected_tag=$1
tags_path=$tags_path
source_path=$texts_path
structure_path=$structure_path

## check if tag is not null
if [ ! "$selected_tag" ];then
    echo "ERROR: no tag provided"
    exit 1
fi

## check if tag path is valid
if [ ! -f "$tags_path" ];then
    echo "ERROR: tags path is not valid"
    exit 1
fi

## getting selected object from json
all_keys=$(jq 'keys|.[]' $tags_path)

## removing all occurrences of every single tag and setting the search_tag
all_text=$(find $source_path -name '*.txt' -exec cat {} \;)

for key in $all_keys
do
    clean_key=$(echo $key | tr -d '"')
    object=$(jq .''$key'' $tags_path)
    clean_object=$(echo $object | tr -d '"')
    sanitized_object=$(echo $clean_object | sed 's@[]\[\()\{}]@__@g')
    if [  $clean_key = $selected_tag ]; then
        search_tag="$sanitized_object"
        continue
    fi
    sanitized_text=$(echo $all_text | sed 's@[]\[\()\{}]@__@g')
    all_text=$(echo $sanitized_text | sed "s/$sanitized_object//g")

done

## check if tag is not null
if [ -z "$search_tag" ];then
    echo "ERROR: no tag found"
    exit 1
fi

## searching..
results=$(echo $all_text | grep -oh $search_tag'.\w*')

if [ -z "$results" ]; then
    echo "ERROR: results are empty"
    exit 1
fi

## filling array and set lower case
result_set=()
i=0
for occurrence in $results
do
    occurrence=$(echo $occurrence | sed "s@$search_tag@@g" | tr '[:upper:]' '[:lower:]' )
    result_set[$i]=$occurrence
    (( i ++ ))
done

#echo ${result_set[@]}

## removing duplicates
set=$(echo ${result_set[@]} | tr ' ' '\n' | sort -u)

history -p "${set[@]}" ##printing data

exit 0

