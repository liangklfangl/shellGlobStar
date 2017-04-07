echo $1
echo $2
if [[ $1 == 10 && $2 == 10 ]] 
#这里的双等号两边必须有空格
then
	echo "两个参数都是10"
else
	echo "至少有一个参数不是10"
fi