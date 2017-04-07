declare path=$(cd `dirname $0`;pwd)
filelist=`grep -i -d skip "magic" $path/*`
echo -e "忽略子文件夹的同时不区分pattern与输入:\n"$filelist
# Ignore case distinctions in both the `PATTERN` and the input files.
filelist1=`grep -I -d skip "magic" $path/*`
echo -e "和-i的区别在于二进制数据，-I认为二进制数据默认就是不匹配的，和--binary-files=without-match一样:\n"$filelist