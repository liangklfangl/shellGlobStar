declare currentFolder=$(cd `dirname $0`;pwd)
#$0表示当前shell文件
#到当前目录中
# filelist=$(find $currentFolder -regex .*.sh)
filelist=$(find ./ -name "[a-z]*.sh")
#注意：-name/-iname都是使用通配符而不是正则表达式来匹配文件名的，如果使用find ./ -name ".*\.sh$" -ls
#得不到任何内容
echo "name文件查询结果:"$filelist 