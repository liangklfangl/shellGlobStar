 declare path=$(cd `dirname $0`;pwd)
 #当前路径
 find $path -type f -name "*.txt" | xargs -i cp {}  $path/tmp/k/
 # 加-i 参数直接用 {}就能代替管道之前的标准输出的内容
 # 前面find命令就是获取到当前目录所有的txt文件，而`{}`就是代表所有的`txt`文件
 # 通过这个命令可以将这些文件移动到`tmp/k/`目录