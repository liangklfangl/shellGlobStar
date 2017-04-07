declare path=$(cd `dirname $0`;pwd)
filelist=`grep -w -d skip "magic" $path/grep-w.txt`
echo -e "只有完全匹配才行:\n"$filelist
