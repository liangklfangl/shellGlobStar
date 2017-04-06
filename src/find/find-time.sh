declare currentFolder=$(cd `dirname $0`;pwd)
#$0表示当前shell文件
ctime=$(find $currentFolder -cmin +10 -ls )
#显示当前目录下所有超过[10min]没有改变过的文件的详细信息，包括文件名或者文件属性
atime=$(find $currentFolder -atime -1 )
#显示当前目录下所有在1天以内访问过得文件的详细信息 
mtime=$(find $currentFolder -mtime 0)
#显示修改时间在[0,24h]之内的文件，文件内容没有变化
echo "10分钟内没有修改的文件:"$ctime 
echo "1天以内没有访问的文件:"$atime
echo "24小时之内没有修改的文件:"$mtime
