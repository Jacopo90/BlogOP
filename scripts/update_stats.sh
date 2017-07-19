#!/bin/sh
## author : Jacopo Pappalettera
## edited : 19/07/2017


source path.sh

if [[ $1 ]]; then
    source_path=$1
else
    source_path=$texts_path
fi
destination_path=$source_path/$default_stat_file_name

sh op_chain.sh $source_path $destination_path