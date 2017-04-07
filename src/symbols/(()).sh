##symbols文件夹用于测试在shell中有特殊含义的字符
((a=110))
echo -e "inital value, a=$a/10"
((a++)) 
echo  "after a++, a=$a"
# inital value, a=110/10
# after a++, a=111

