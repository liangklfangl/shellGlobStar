declare path=$(cd `dirname $0`;pwd)
find $path -type f -name "*.log" -print0 | xargs -0 rm -f
#print0的作用如下:
#True; print the full file name on the standard output, followed by a null character (instead of the newline character that '-print' uses).
# This allows file names that contain newlines or other types of white space to be correctly interpreted by programs that process the find output. This option corresponds to the '-0' option of xargs.
#使用print0输出完整的文件名，即使文件名中有换行符或者空格也能正确的处理