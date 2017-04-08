declare bb=3
echo ${aa}
#aa此时为空
echo ${bb}
#bb此时为3
echo ${aa-${bb}}
#${aa-world}表示如果aa为空，那么就使用world的值替换
aa=2
echo ${aa-${bb}}
#此时aa已经非空，那么直接打印aa的值