declare currentFolder=$(cd `dirname $0`;pwd)
#$0表示当前shell文件
filelist=$(find $currentFolder -type f -a -size -3k -a -name "[a-z]*.txt")
#注意：获取size小于3k的文件，如果没有单位那么1=0.5k!
echo "size文件查询结果:"$filelist 

