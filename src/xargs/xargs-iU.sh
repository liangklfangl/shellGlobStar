 declare path=$(cd `dirname $0`;pwd)
find $path -type f -name "*.txt" | xargs -I [] cp []  $path/tmp/n/
# 加 -I 参数 需要事先指定替换字符,该替换字符就是用于代表前面的管道输出，即find命令的结果
# 这里表示使用[]表示find的查询结果