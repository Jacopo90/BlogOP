### install
If you are using a macOS system you have to install before some libraries:
* brew command
* jq command

##### Installing brew
- open terminal application
- copy installation link from https://brew.sh/index_it.html
- run command in the terminal

##### Installing jq
- run in the teminal "brew install jq"

Once you have succesfully installed these libraries you can use the scripts!!


### FileSystem

Once you downloaded the repo, you can find 
 - a folder named "chapters": here you can find a brief description of every (every! WTF) op chapter.
 - a foldere named "def": here you can defines your own tags
 - a folder named "scripts": scripts .



### scripts usage

First of all : open terminal application!

run
```shell
cd Desktop/BlogOp/scripts
```

Every script in this folder has a goal, an input and an output that can be visualized directly in the terminal or printed in a file.



##### I want to see/update the stats of a certain chapter:

```shell
sh update_stats.sh [root_path]/Desktop/op/chapters/chapter_2
```
In the folder "[root_path]/Desktop/op/chapters/chapter_2" now you can see a stats file

##### I want to find every occurrence of a certain word:
```shell
sh find_relations.sh --default pippo
```

You can also find combo relations between multiple words!
```shell
sh find_relations.sh --default pippo pluto
```
