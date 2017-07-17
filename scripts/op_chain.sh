#!/bin/sh
source path.sh

selected_tag=$1
tags_path=$tags_path
source_path=$texts_path
structure_path=$structure_path

##  check file is empty and if not filling it
if [[ ! -s $structure_path ]]
then
    echo "{}" > $structure_path
fi

all_keys=$(jq 'keys|.[]' $tags_path)
for key in $all_keys
do
    clean_key=$(echo $key | tr -d '"')
    set=$(sh find_tagged_words.sh $clean_key)

## every result will be saved in the structure.json file
## start
    j=0
    result_word_set=()
    for word in $set;do
        ## add quotes..
        w="\"$word\""
        result_word_set[$j]=$w
        (( j ++ ))
    done

    ## building a string from the array
    result=$(printf "%s,"  ${result_word_set[*]})
    result=${result%?}
    final_json=$(jq -c '."'$clean_key'" |= ['$result']'  $structure_path)

    ## saving in structure.json file
    jq . <<< ${final_json} > $structure_path
## end

    #   sh find.sh $key

done

    jq .  $structure_path

exit 0;

