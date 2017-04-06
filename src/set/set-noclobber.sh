# Cur_Dir=$(pwd)
# 获取当前你的命令行工具所在的目录，如： ~/Desktop/shellGlobStar/src (master)那么就是src的绝对目录
# 而不是获取你的bash文件的真实路径
# cd $Cur_Dir
# echo "kick" > ./temp.txt
# =$(cd `dirname $0`; pwd)
set -o noclobber
#如果文件不存在那么我们会创建，如果已经存在那么我们不会覆盖而是报错
declare path=$(cd `dirname $0`;pwd)
#获取到bash文件所在的目录，并将该路径赋值给path
echo "Bash file path:" $path
echo "kick" > $path/temp.txt
set +o noclobber
echo "kick noclobber close" > $path/temp.txt