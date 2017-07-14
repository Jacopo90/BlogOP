#!/bin/sh

selected_tag=$1
tags_path=$2
source_path=$3


## check if tah path is valid
if [ ! -f "$tags_path" ];then
    echo "ERROR: tags path is not valid"
    exit 1
fi

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

if [ -z "$search_tag" ];then
    echo "ERROR: no tag found"
    exit 1
fi

##removing all occurrences of every single tag
for key in $all_keys
do
    clean_key=$(echo $key | tr -d '"')
    if [  $clean_key = $selected_tag ]; then
        echo "continue" $key $selected_tag
        continue
    fi
    clean_key=$(echo $key | tr -d '"')
    object=$(jq .''$key'' $tags_path)
    clean_object=$(echo $object | tr -d '"')
    echo "removing all occurrences of" $clean_object

    all_text=$(cat $source_path/* |  sed "s/$clean_object//g")

    echo $all_text
done
exit 1

results=$(grep -oh $search_tag'.\w*' $source_path/*)

if [ -z "$results" ]; then
    echo "ERROR: results are empty"
    exit 1
fi

for occurrence in $results
do
    word=$occurrence
    for key in $all_keys
    do
    clean_key=$(echo $key | tr -d '"')
    object=$(jq .''$key'' $tags_path)
    clean_object=$(echo $object | tr -d '"')
echo "deleting .." $clean_object "from" $word

    word=$(echo $word | sed "s@clean_object@@g")
echo $word
    done


#echo $word
done

exit 0
