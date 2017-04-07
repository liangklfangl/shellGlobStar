declare path=$(cd `dirname $0`;pwd)
filelist=`grep -L -d skip "magic" $path/*`
echo -e "不输出文件的内容，只输出文件名，找到第一个文件时候退出:\n"$filelist
#/c/Users/Administrator/Desktop/shellGlobStar/src/grep/magic1.txt 
#/c/Users/Administrator/Desktop/shellGlobStar/src/grep/no-magic.txt
# /c/Users/Administrator/Desktop/shellGlobStar/src/grep/no-magic1.txt
