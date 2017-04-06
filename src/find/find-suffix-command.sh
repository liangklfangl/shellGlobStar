declare currentFolder=$(cd `dirname $0`;pwd)
# find . -type d -delete 
#删除当前目录下的所有目录 
find $currentFolder -type f -ok wc -l {} \;
#找出当前目录下所有的普通文件并显示文件行数(需确认) 
#其中-c表示多少字节，l表示行数(如果是n就有n+1行，至少我这里测试的结果是这样的)，-w有多少个英文单词
#-L打印最长的哪一行的长度
# find . -type f -exec wc -l {} \; 
#找出当前目录下所有的普通文件并显示文件行数(无需确认)
echo "下面不需要询问"

find $currentFolder -type f -exec wc -l {} \;