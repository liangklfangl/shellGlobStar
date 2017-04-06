shopt -u dotglob 
#文件开头是"."也能匹配
for i in *
 do
 	echo 'Filename:'$i
 done