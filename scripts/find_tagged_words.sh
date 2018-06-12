#!/bin/sh
## author : Jacopo Pappalettera
## edited : 19/07/2017
## This scripts prints a list of values tagged with the specified value
## example: 
## sh find_tagged_words.sh tag
## value1
## value2 
## value3
## you can pass in input the source folder
## and also a destination file
## If you don't pass anything the default path will be taken from path.sh file
## If you don't pass a destination file this script prints in the terminal the output without writing any file

source $(dirname $0)/path.sh

selected_tag=$1
tags_path=$tags_path

if [[ $2 ]]; then
    source_path=$2
else
    source_path=$texts_path
fi

output_path=$3

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

if [[ $output_path ]]
    then
        history -p "${set[@]}" > $output_path
    else
        history -p "${set[@]}" 
fi
exit 0


