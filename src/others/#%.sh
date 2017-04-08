#!/bin/sh
files=`find -name *.txt`
# 如果当前pwd为~/Desktop/shellGlobStar，那么就是获取该目录下的所有的txt文件绝对路径。 
# 如下面的$i可以是./src/cat/cat.txt,注意：这里的$i是一个相对路径，其是相对于pwd来说的
# 但是${i#*/}得到的是`src/cat/cat.txt`,也就是直接去掉了前面的相对路径部分!
# 同时${i%/*}得到的就是`src/cat`,也就是仅仅包含了name的path部分，而不包括文件名
for i in $files
do
  echo $i
  #完整相对路径
  name=${i#*/}
  #去掉完整相对路径的相对部分
  #表示取从第一个slash之后的完整内容
  echo $name
  dir=${name%/*}
  #直接获取到name的path部分
  #即%/*代表取从头到最后一个slash之前的所有内容，不包括slash本身
  echo $dir
  echo "----------------"
  # 
done