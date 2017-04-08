IFS=";"
#此时我强制要求控制台输入的变量的值之间通过";"分隔
read sex location des
printf "%d\n" "'$IFS"
#此时你会发现如果没有第一句的`IFS=";"`，那么此处打印的ASCII为32，也就是说默认就是空格的
echo "echo输出"$REPLY
#如果read后没有name等名称，那么变量都是在$REPLY中，如果有name那么这个变量为空
#read必须以空格分隔，控制台输入的时候也必须用空格分隔
#如果你输入male hangzhou hunan dalian hefei shanghai
#那么将会打印：sex=male,location=hangzhou,des=hunan dalian hefei shanghai
echo "sex=$sex,location=$location,des=$des"