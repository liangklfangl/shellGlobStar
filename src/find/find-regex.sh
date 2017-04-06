declare currentFolder=$(cd `dirname $0`;pwd)
#$0表示当前shell文件
#到当前目录中
# filelist=$(find $currentFolder -regex .*.sh)
filelist=`find $currentFolder -regex .*.sh`
echo "regex文件查询结果:"$filelist 