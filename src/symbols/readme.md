### 该文档用于测试在shell中有特殊含义的字符
#### (())作用
这组符号的作用与 let 指令相似，用在算数运算上，是 bash 的内建功能。所以，在执行效率上会比使用 let 指令要好许多。
```bash
((a=110))
echo -e "inital value, a=$a/10"
((a++)) 
echo  "after a++, a=$a"
# inital value, a=110/10
# after a++, a=111
```

#### ()产生指令群组
```bash
#这里是一个指令群组的例子
(cd ~ ; vcgh=`pwd` ; echo $vcgh)
echo "退出subshell获取subshell变量:"$vcgh
#在这里访问不了子shell中的变量
```
用括号将一串连续指令括起来，这种用法对 shell 来说，称为指令群组。如下面的例子：(cd ~ ; vcgh=`pwd` ; echo $vcgh)，指令群组有一个特性，shell会以产生 subshell 来执行这组指令。因此，在其中所定义的变数，仅作用于指令群组本身。

#### {}不会产生subshell
```bash
#这里不会产生subshell而是直接在父shell中运行
{cd ~ ; vcgh=`pwd` ; echo $vcgh}
echo "没有产生subshell:"$vcgh
```
这种用法与上面介绍的`指令群组`非常相似，但有个不同点，它在`当前的 shell 执行，不会产生 subshell`。大括号也被运用在`` “函数” 的功能`上。广义地说，单纯只使用大括号时，作用就像是个没有指定名称的函数一般。因此，这样写 script 也是相当好的一件事。尤其对输出输入的重导向上，这个做法可精简 script 的复杂度。大括号也可以用于产生目录上:
```bash
mkdir {userA,userB,userC}-{home,bin,data}
#产生多目录
chown root /usr/{ucb/{ex,edit},lib/{ex?.?*,how_ex}}
#同时修改多个文件件的权限
```
我们得到 `userA-home, userA-bin, userA-data, userB-home, userB-bin, userB-data, userC-home, userC-bin, userC-data`，这几个目录

#### []用于流程控制
常出现在流程控制中，扮演括住判断式的作用。也可用于正则表达式！
```bash
echo $1
if [ $1 == 0 ]
#这里的双等号两边必须有空格
then
    echo "参数输入为0"
else
    echo "输入的参数非0"
fi
```

#### [[]]也可用于流程控制但是同时支持||或者&&逻辑符号
```bash
echo $1
echo $2
if [[ $1 == 10 && $2 == 10 ]] 
#这里的双等号两边必须有空格
then
    echo "两个参数都是10"
else
    echo "至少有一个参数不是10"
fi
```
这组符号与先前的 [] 符号，基本上作用相同，但她允许在其中直接使用 || 与 && 逻辑等符号。单一个& 符号，且放在完整指令列的最后端，即表示`将该指令列放入后台中工作`。如 tar cvfz data.tar.gz data > /dev/null &

#### alias命令可以用于设置一个别名来替换另外一个命令
```bash
alias ll='ls -lhF --color=auto'
#设置一个新命令
```
<pre>
-h, --human-readable
print sizes in human readable format (e.g., 1K 234M 2G)

-F, --classify, --file-type

在每个文件名后附上一个字符以说明该文件的类型。"*"表示普通的可执行文件； "/ "表示目录；"@"表示符号链接；"|"表示FIFOs；"="表示套接字 (sockets) ；什么也没有则表示普通文件。
</pre>




参考资料：

[Linux Shell中的特殊符号和含义简明总结（包含了绝大部份）](http://www.jb51.net/article/51342.htm)

[linux grep命令详解](http://www.cnblogs.com/ggjucheng/archive/2013/01/13/2856896.html)

[Linux常用命令ll 即 ls -l --color=auto](http://www.linuxidc.com/Linux/2015-01/112123.htm)

[.bashrc文件]()