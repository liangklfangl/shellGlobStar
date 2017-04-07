declare path=$(cd `dirname $0`;pwd)
filelist=`grep -n -d skip  "magic" $path/grep-w.txt`
#显示行号
filelist1=`grep -n -v -d skip   "magic" $path/grep-w.txt`
#-v可以用于反向选择显示，即显示不含有'magic'的行
echo -e "含有magic的行:\n"$filelist
#显示有'magic'的行
echo -e "不含有magic的行:\n"$filelist1