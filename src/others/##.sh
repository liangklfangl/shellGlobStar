#!/bin/sh
files=`find -name *.txt`
for i in $files
do
  echo $i
  echo ${i##*/}
  #如$i的结果为./src/cat/cat.txt，那么${i##*/}得到的就是"cat.txt"
  #表示最后一个/之后的部分，从左到右计算
  echo ${i%%/*}
  #如$i的结果为./src/cat/cat.txt，那么${i%%*/}得到的就是"."
  #表示从右到左最后一个/之前的部分
  echo "----------------"
done