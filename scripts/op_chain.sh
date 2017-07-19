#!/bin/sh
## author : Jacopo Pappalettera
## edited : 19/07/2017
## This script prints a json with all the values found from every tag set
## sh op_chain.sh
## example:
## {
##  "tag0": [
##    "value1"
##  ],
##  "tag1": [
##    "value2",
##    "value3",
##    "value4"
##  ],
##  "tag2": [
##    "value12",
##    "value2",
##    "value4",
##    "value3",
##    "value4",
##    "value2"
##  ]
## }
## you can pass in input the source folder
## and also a destination file
## If you don't pass anything the default path will be taken from path.sh file

source path.sh

tags_path=$tags_path

if [[ $1 ]]; then
    source_path=$1
else
    source_path=$texts_path
fi

if [[ $2 ]]; then
    output_path=$2
else
    output_path=$structure_path
fi

##  check file is empty and if not filling it
if [[ ! -s $output_path ]]
then
    echo "{}" > $output_path
fi

all_keys=$(jq 'keys|.[]' $tags_path)
for key in $all_keys
do
    clean_key=$(echo $key | tr -d '"')
    set=$(sh find_tagged_words.sh $clean_key $source_path)
    if [ -z "$set" ]; then
        continue
    fi
## every result will be saved in the selected output file
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
    final_json=$(jq -c '."'$clean_key'" |= ['$result']'  $output_path)
    ## saving in the selected output file
    jq . <<< ${final_json} > $output_path
## end
    #   sh find.sh $key
done

    jq .  $output_path

exit 0;

