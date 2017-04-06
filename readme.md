#####注意：因为个人专注于前端开发，所以很多shell命令可能没有接触到，下面列举的只是自己常用的一些命令，如果你需要更加深入的学习shell命令建议你查看[官方文档](https://ss64.com/bash/),你也可以阅读[linux命令大全](http://man.linuxde.net/xargs)，或者阅读文末的参考资料。文中涉及的例子都在src目录下，每一个命令有一个文件夹，因此你可以直接运行相应文件夹下的shell命令！


### 1.set命令
set通过选项来开关shell的不同特性，每个特性都对应一个选项。每个特性都有两种配置方式：

(1)一种是通过 set -e 和 set +e 这种形式，即直接指定选项。

(2)另一种是通过 set -o errexit 和 set +o errexit 这种形式，即通过 o 这个选项来指定选项名。

`我想你一定对选项是用 + 号还是 - 号十分好奇。在set命令中，选项前面跟着 - 号表示开启这个选项， + 表示关闭这个选项。`下面给出一个set命令的例子：

```bash
#!/bin/bash
set -o xtrace
# 设置了这个选项之后，对于每一条要执行的命令，shell在扩展了命令之后（参数扩展）、执行命令之前输出trace到stderr。
set -o errexit 
 # 可以把这样注释掉看下执行效果有什么不一样。
echo "Before"
ls   
# ls也不存在的文件
echo "After"
```
下面给出几个例子：

例子1：noclobber的例子
```bash
set -o noclobber
#如果文件不存在那么我们会创建，如果已经存在那么我们不会覆盖而是报错
declare path=$(cd `dirname $0`;pwd)
#获取到bash文件所在的目录，并将该路径赋值给path
echo "Bash file path:" $path
echo "kick" > $path/temp.txt
set +o noclobber
//关闭选项noclobber，此时如果文件存在那么内容会被覆盖
echo "kick noclobber close" > $path/temp.txt
```
noclobber特性可以防止重定向时不经意地重写了已存在的文件。通过设置变量noclobber可以将此特性打开。打开后若将输出重定向到某个已存在文件，则shell将报告错误消息，并且不执行重定向命令。

例子2：ignoreeof实例
```bash
set –o ignoreeof
#用于交互式shell脚本，等待深入研究，如电视开发互动营销等
```
ignoreeof变量用来禁止使用ctrl d来退出shell（ctrl d不但用来退出shell，而且能够终止用户直接输往标准输出上的输入。该操作经常在一些shell实用命令中使用，例如实用命令cat。在这些实用程式 操作中，很容易误操作而意外地退出shell。ignoreeof特别变量正是用来防止这种意外的退出。设置该选项之后，用户只能用`logout`或`exit`命令退出shell。

例子3：noglob实例
```bash
set -o noglob
#关闭通配符
declare path=$(cd `dirname $0`;pwd)
ls -ahl -n $path/noglo[bc]
echo "Next is noglob closed:"
set +o noglob
#开启通配符
ls -ahl -n $path/noglo[bc]
```
配置noglob变量后，shell将不扩展文档名中一些特别的字符或字符串。如字符`*、?、［］`等将不再作为通配符。假如用户希望列出结尾为?的文档名 answer?，可通过如下步骤：首先，用户使noglob变量为无效，然后再列出文档名。下面是windows下的输出结果：
```js
 ls: cannot access '/c/Users/Administrator/Desktop/shellGlobStar/src/set/noglo[bc]': No such file or directory
 <!-- 因为我们上面关闭了通配符，所以noglo[bc]文件不存在，因此报错 -->
Next is noglob closed:
-rw-r--r-- 1 197108 197121 0 四月  6 10:21 /c/Users/Administrator/Desktop/shellGlobStar/src/set/noglob
-rw-r--r-- 1 197108 197121 5 四月  6 10:35 /c/Users/Administrator/Desktop/shellGlobStar/src/set/nogloc 
<!-- noglob与nogloc同时都被匹配出来了 -->
```
下面再给出一个例子，该例子你可以知道通配符与正则表达式的区别：
```bash
set -o noglob
#开启通配符
declare path=$(cd `dirname $0`;pwd)
ls -ahl -n $path/noglob$
echo "Next is noglob closed:"
set +o noglob
#关闭通配符
ls -ahl -n $path/noglob$
```
此时windows上打印结果为：
```js
-rw-r--r-- 1 197108 197121 0 四月  6 08:53 '/c/Users/Administrator/Desktop/shellGlobStar/src/set/noglob$'
Next is noglob closed:
-rw-r--r-- 1 197108 197121 0 四月  6 08:53 '/c/Users/Administrator/Desktop/shellGlobStar/src/set/noglob$'
```
通过这个文章你可以知道[通配符与正则表达式的区别](http://www.cnblogs.com/sujz/archive/2011/12/14/2288164.html)

### 2.shopt命令
#### 2.1 shopt命令分析
(1) set 命令是 `POSIX` 规范，`shopt` 不是,如下可以获取到每一个命令的配置项的个数：
```bash
 set -o | wc -l
 shopt | wc -l
```

(2)set命令有一个$SHELLOPTS环境变量，通过对他运行export命令可以将当前shell打开的选项传递给子进程shell，如下首先通过`set`再$SHELLOPTS传入配置项，然后通过`export`同步即可：
```bash
set -o noglob
#通过set设置时，SHELLOPTS变量的值会自动同步(所有开启的选项名用冒号join 成的字符串）
export $SHELLOPTS
#这个变量默认并不是环境变量，需要手动 export 一下，然后子进程 Shell 会获取到这个环境变量的值
```
在当前 Shell 中打开了 noglob 选项，然后 `SHELLOPTS `变量的值会自动同步（所有开启的选项名用冒号 join 成的字符串），但这个变量默认并不是环境变量，需要`手动 export` 一下，然后子进程 Shell 会获取到这个环境变量的值，解析之后，打开这些继承来的选项。

#### 2.2 shopt命令的环境变量
```bash
shopt -s cdspell
#-s开启cd拼写检查，-u关闭检查
export $BASHSHOPTS
#导出到子进程shell中
```
`$BASHOPTS` 变量，它的功能和 SHELLOPTS 一样，用来把 shopt 命令打开的选项传递给子进程 Shell。注意：shopt提供了一个`-o`选项，其用于查看我们通过`set`设置的那些选项：
```bash
shopt -o noglob
```

#### 2.3 shopt参数使用
(1)nullglob参数
```bash
shopt -u nullglob
#关闭shopt行为，其中-s表示激活指定的shell行为
declare path=$(cd `dirname $0`;pwd)
cd $path/tmp/empty
#cd到emty目录
for i in *
   do 
    echo "file: $i";
 done
#此时的"*"就是获取该目录下所有的文件了，包括目录，但是不包括子目录以及子目录下文件
#注意：此时如果再一个empty目录下运行上面的for，那么就会打印"*"，即将通配符作为字符打印！
shopt -s nullglob
#启动nullglob,表示没有匹配的文件时候直接输出null
for i in *
 do
  echo "file: $i"; 
done;
#因为我们设置了nullglob，表示如果没有文件那么直接返回null，所以这里没输出任何内容
```
你可以查看该库[下面的文件](./src/shopt/shopt-nullglob.sh)

(2)failglob参数
```bash
shopt -u failglob
#关闭shopt行为，其中-s表示激活指定的shell行为
declare path=$(cd `dirname $0`;pwd)
cd $path/tmp/empty
#cd到emty目录
for i in *
   do 
    echo "file: $i";
 done
#此时的"*"就是获取该目录下所有的文件了，包括目录，但是不包括子目录以及子目录下文件
#注意：此时如果再一个empty目录下运行上面的for，那么就会打印"*"，即将通配符作为字符打印！
shopt -s failglob
#启动nullglob,表示没有匹配的文件时候直接输出null
for i in *
 do
  echo "file: $i"; 
done;
```
此时输出内容为：
```bash
$ /c/Users/Administrator/Desktop/shellGlobStar/src/shopt/shopt-failglob.sh
file: *
/c/Users/Administrator/Desktop/shellGlobStar/src/shopt/shopt-failglob.sh: line 14: no match: *
#报错
```
也就是说如果我们禁止了failglob，那么没有文件的时候我们打印`通配符`。而如果启用这个配置，那么没有文件被搜索到的时候就`报错`~

(3)extglob参数

例子1：
```bash
shopt -u extglob   
#关闭shopt行为，其中-s表示激活指定的shell行为
declare path=$(cd `dirname $0`;pwd)
mv !(backup|tmp) backup/
```
我们关闭了extglob行为，所以我们最后会得到下面的错误信息,也就是我们这里的扩展通配符无效：
```bash
/c/Users/Administrator/Desktop/shellGlobStar/src/shopt/shopt-extglob.sh: line 4: syntax error near unexpected token `('/c/Users/Administrator/Desktop/shellGlobStar/src/shopt/shopt-extglob.sh: line 4: `mv !(backup|tmp) backup/')`
```
正确的例子如下：
```bash
shopt -s extglob   
#启动shopt行为，其中-s表示激活指定的shell行为
declare path=$(cd `dirname $0`;pwd)
mv !(backup|tmp) backup/
```
此时你会发现除了tmp/backup目录外，其它的文件全部被移动到`backup/`目录下。

例子2：rm -rf删除文件
```bash
shopt -s extglob   
#启动shopt行为，其中-s表示激活指定的shell行为
rm -rf file[1-2].js
```
此时你会发现我们[src/shopt/file1.js与file2.js全部被删除了!](./src/shopt/)

例子3：扩展模式之*(pattern-list) 
```bash
shopt -s extglob
for i in *(f)ile1.js
 do 
   echo "FileName:$i";
 done
```
此时你会发现打印的结果如下：
```js
FileName:fffile1.js
FileName:ffile1.js
FileName:file1.js
FileName:ile1.js
//也就表示f这个字符出现0此或者1-无穷多次
```
例子4：扩展模式之+(pattern-list)  
```bash
shopt -s extglob
for i in +(f)ile1.js
 do 
   echo "FileName:$i";
 done
```
此时你们看到的结果将会是如下的内容：
```js
FileName:fffile1.js
FileName:ffile1.js
FileName:file1.js
```
也就是说，此种匹配模式会匹配`f`字符的`>=1`次！

例子6：扩展模式之?(pattern-list)  
```bash
shopt -s extglob
for i in ?(f)ile1.js
 do 
   echo "FileName:$i";
 done
```
此时结果如下：
```js
FileName:file1.js
FileName:ile1.js
```
即`f`字符出现次数为`0|1`

例子7：匹配模式@(pattern-list)
```bash
shopt -s extglob
echo 'Shell本身的PID'$$
#Shell本身的PID（ProcessID） 
echo 'Shell最后运行的后台process的PID:'$!
#Shell最后运行的后台process的PID:
echo "所有参数列表"$* 
#shopt-extglob.sh win-98 sex name运行shell程序得到的结果为：win-98 sex name
echo "参数个数："$#
#添加到shell中参数个数
echo "shell本身文件名" $0
# @(pattern-list) 表示匹配列表中其中一个pattern
echo "逐个访问参数"$1
#添加到Shell的各参数值。$1是第1参数、$2是第2参数…
# !(pattern-list) 表示匹配任何一个非列表中的pattern
case $1 in
@(win-98|win-xp|win-7|win-10))
   echo "windows";;
@(Redhat*|Centos*|Debian*|Ubuntu*))
  echo "linux";;
*) 
echo "others";;
esac
```
也就是我们的模式满足一个就可以了

例子7：!(pattern-list)
```bash
shopt -s extglob
case $1 in 
    !(windows7|windowXP))
      echo "You are not in windows7 nor windowXP platform";;
     *)
#This is default router
     echo "You are  in windows  platform";;
esac
```
这种匹配和正则模式一致！

(4)dotglob参数
```bash
shopt -u dotglob 
#文件开头是"."也能匹配
for i in *
 do
    echo 'Filename:'$i
 done
```
如果设置了这个参数那么那些文件名以‘.’开头的文件也能匹配,结果如下：
```js
Filename:..dotfile
Filename:.dotfile
Filename:backup
Filename:fffile1.js
```
(5)globstar选项
```bash
function show()
{
        for i in **
        # * 被展开成当前目录下所有文件名
        # ** 当前目录以及子目录下的所有的文件
        # **就是我们常说的globalStar
        do
                echo FileName is $i
                # 前面不需要添加引号表示字符串
        done
}
 
cd  ../../src/
echo "------------------------"
echo "disable globstar option:"
# globstar is disabled by default
shopt -u globstar
show
echo "------------------------"
echo "enable globstar option:"
shopt -s globstar
show
```
此时你会看到下面的结果(截取部分内容)：
```js
------------------------
disable globstar option:
FileName is find
FileName is outer
FileName is set
FileName is shopt
------------------------
enable globstar option:
FileName is find
FileName is find/find-regex.sh
FileName is outer
FileName is outer/inner
FileName is outer/inner/inner.txt
FileName is outer/outer.txt
FileName is set
FileName is set/file.txt
FileName is set/file1.txt
FileName is set/file2.txt
```
总之，开启了globstar，那么我们会遍历文件夹下的所有的文件以及子文件！

(6)其他配置如nocaseglob

如果开启了该参数,那么我们不会对文件名大小写敏感了!

### 3.find命令
find支持文件名的`正则表达式`查找,按文件`修改时间`查找,按`文件大小`查找,按`文件权限`查找,按`文件类型`查找等,查找到以后还`支持直接对查找到的文件使用命令`,功能非常强大。
#### 3.1 正则表达式查找
典型的find命令的写法是:

`find 查找路径 查找的标准 查找到之后的动作`

比如: `find /home -type d -ls `意思是: 找出/home/下所有的目录,并显示目录的详细信息。下面给出一个例子：
```bash
declare currentFolder=$(cd `dirname $0`;pwd)
#$0表示当前shell文件
#到当前目录中
# filelist=$(find $currentFolder -regex .*.sh)
filelist=`find $currentFolder -regex .*.sh`
echo "regex文件查询结果:"$filelist 
```
这个是查询shell文件所在的目录的所有的.sh的shell文件。注意：使用-regex时有一点要注意：`-regex不是匹配文件名，而是匹配完整的文件名（包括路径）`。例如，当前目录下有一个文件"abar9"，如果你用"ab.*9"来匹配，将查找不到任何结果，正确的方法是使用".*ab.*9"或者".*/ab.*9"来匹配。同时，这个例子也展示了如何将find命令返回的结果保存到变量中,[可以通过反引号``也可以通过$(command)将命令包裹起来](http://bbs.csdn.net/topics/390794417)

#### 3.2名称查找-name/-iname
```bash
declare currentFolder=$(cd `dirname $0`;pwd)
#$0表示当前shell文件
#到当前目录中
# filelist=$(find $currentFolder -regex .*.sh)
filelist=$(find ./ -name "[a-z]*.sh")
#注意：-name/-iname都是使用通配符而不是正则表达式来匹配文件名的，如果使用find ./ -name ".*\.sh$" -ls
#得不到任何内容
echo "name文件查询结果:"$filelist 
```
一定要注意，使用-name或者-iname是`通配符而不是正则表达式`!而且最好将通配符使用引号扩起来

#### 3.3使用type查找
```bash
declare currentFolder=$(cd `dirname $0`;pwd)
#$0表示当前shell文件
#到当前目录中
# filelist=$(find $currentFolder -regex .*.sh)
filelist=$(find ./ -type f)
#注意：-name/-iname都是使用通配符而不是正则表达式来匹配文件名的，如果使用find ./ -name ".*\.sh$" -ls
#得不到任何内容
echo "type文件查询结果:"$filelist 
```
-type 文件属性如下：
<pre>
d: 目录
f: 普通文件
l: 链接文件(link)
s: socket文件
p: 管道文件(pipe)
b: 块设备文件
c: 字符设备文件
</pre>

#### 3.4 uid/gid/user等查找
```bash
declare currentFolder=$(cd `dirname $0`;pwd)
#$0表示当前shell文件
#到当前目录中
# filelist=$(find $currentFolder -regex .*.sh)
filelist=$(find $currentFolder -user administrator)
echo "uid/gid/user文件查询结果:"$filelist 
```
可以查找的参数如下:
<pre>
 -gid GID
-uid UID
-user USER
-group GROUP
-nouser
-nogroup
</pre>
注意：此时获取到的是文件的`绝对路径`！

#### 3.5文件大小查找
```bash
declare currentFolder=$(cd `dirname $0`;pwd)
#$0表示当前shell文件
filelist=$(find $currentFolder -type f -size -3k)
#注意：获取size小于3k的文件，如果没有单位那么1=0.5k!
echo "size文件查询结果:"$filelist 
```
注意：`默认单位是b，而它代表的是512字节，所以2表示1K，1M则是2048，如果不想自己转换，可以使用其他单位，如c、K、M等。`

#### 3.5 ctime,atime,mtime查询
首先我们[弄清楚三者的区别](http://blog.chinaunix.net/uid-24500107-id-2602881.html)：

mtime(modified time):仅仅在文件内容发生变化以后才会改变，而如文件名或者文件的属性发生修改了值是不变的!

ctime(change time):`当文件内容`或者`文件名`，`文件属性`发生变化以后，该值都会发生变化！

在通过`ls`命令可以输出上面三种时间：
<pre>
ls -lc filename 列出文件的 ctime
ls -lu filename 列出文件的 atime
ls -l filename 列出文件的 mtime
</pre>

下面也给出一个mtime的例子：
```js
-mtime 0 
//表示文件修改时间距离当前为0天的文件，即距离当前时间不到1天（24小时）以内的文件
-mtime -1
//表示文件修改时间为小于1天的文件，即距离当前时间1天（24小时）之内的文件
-mtime 1
//表示文件修改时间距离当前为1天的文件，即距离当前时间1天（24小时－48小时）的文件
-mtime+1 
//表示文件修改时间为大于1天的文件，即距离当前时间2天（48小时）之外的文件。这里-mtime +1 为什么是48小时以外，而不是24小时以外呢，因为n只能是整数，比1大的下一个整数是2，所以是48小时以外的
```
下面是一个shell实例：
```bash
declare currentFolder=$(cd `dirname $0`;pwd)
#$0表示当前shell文件
ctime=$(find $currentFolder -cmin +10 -ls )
#显示当前目录下所有超过[10min]没有改变过的文件的详细信息，包括文件名或者文件属性
atime=$(find $currentFolder -atime -1 )
#显示当前目录下所有在1天以内访问过得文件的详细信息 
mtime=$(find $currentFolder -mtime 0)
#显示修改时间在[0,24h]之内的文件，文件内容没有变化
echo "10分钟内没有修改的文件:"$ctime 
echo "1天以内没有访问的文件:"$atime
echo "24小时之内没有修改的文件:"$mtime
```

#### 3.6 权限查询
基本说明如下：
<pre>
-perm MODE 
/MODE: 任意一位匹配即满足条件 
-MODE: 文件权限能完全包含此MODE时才符合条件
</pre>
下面是一个简单的例子：
```bash
find . -perm -644 -ls 
#显示当前目录下文件权限的每一位至少包含r-xr–r–的文件的详细信息 
find . -perm /464 -ls 
#显示当前目录下文件权限的某一位至少包含r–rx-r–的文件的详细信息
```
其中关于[权限信息的文章请查看这里](https://github.com/liangklfangl/npm-command)

#### 3.7组合查询
```bash
declare currentFolder=$(cd `dirname $0`;pwd)
#$0表示当前shell文件
filelist=$(find $currentFolder -type f -a -size -3k -a -name "[a-z]*.txt")
#注意：获取size小于3k的文件，如果没有单位那么1=0.5k!
echo "size文件查询结果:"$filelist 
```
这里是查询所有文件，大小小于3看，同时name以`.txt`结尾，注意这里是通配符的name查询，而不是regex~，下面是组合符号：
<pre>
-a: and 
-o: or 
-not:
</pre>

#### 3.8 find的后继操作命令
<pre>
-print: 显示
-ls：类似ls -l的形式显示每一个文件的详细
-quit: 查找到一个就退出
-delete: 删除匹配到的行
-ok COMMAND {} \; 每一次操作都需要用户确认,{}表示引用找到的文件,是占位符
-exec COMMAND {} \; 每次操作无需确认
</pre>
下面是shell命令的例子：
```bash
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
```
其中`find $currentFolder -type f -ok wc -l {} \;`在询问的时候不要直接回车，输入`yes/y`即可；同时我们的获取到的line的个数要注意，如果输出为n那么行数为`n+1`。同时-c表示有多少个`字节`!

下面再给出几个例子:
```bash
find ./ -name test -print -exec cat {} \;
#打印文件名同时打印文件内容
```

### 4.[xargs](https://ss64.com/bash/xargs.html)命令
xargs命令是给[其他命令传递参数的一个过滤器](http://man.linuxde.net/xargs)，也是组合多个命令的一个工具。它擅长`将标准输入数据转换成命令行参数，xargs能够处理管道或者stdin并将其转换成特定命令的命令参数`。xargs也可以将单行或多行文本输入转换为其他格式，例如多行变单行，单行变多行。xargs的默认命令是echo，空格是默认定界符。这意味着通过管道传递给xargs的输入将会包含换行和空白，不过通过xargs的处理，换行和空白将被空格取代。xargs是构建单行命令的重要组件之一。

#### 4.1匿名管道 vs 命名管道
使用管道进行通信时，`两端的进程向管道读写数据是通过创建管道时，系统设置的文件描述符进行的`。从本质上说，管道也是一种文件，但它又和一般的文件有所不同，可以克服使用文件进行通信的两个问题，这个文件`只存在内存中`。你可以查看[ linux管道的那点事 ](http://blog.chinaunix.net/uid-27034868-id-3394243.html)。对于管道来说具有以下特点:

*** 数据只能由一个进程流向另一个进程（其中`一个读管道，一个写管道`）；如果要进行双工通信，需要建立两个管道。

*** 管道只能用于`父子进程或者兄弟进程间通信`。也就是说管道只能用于具有亲缘关系的进程间通信。 

上面是匿名管道的内容，下面我们看看命名管道：

FIFO不同与管道之处在与她提供一个`路径名与之关联`，`以FIFO的文件形式存储在文件系统中`。`有名管道是一个设备文件`，因此，即使进程与创建FIFO的进程不存在亲缘关系，只要可以访问该路径，就能够通过FIFO相互通信了。值得注意的是FIFO（First In First Out）总是按照先进先出的原则工作，第一个被写入的数据首先从管道中读出。

在Linux中我们经常使用管道重定向数据,如下面的例子：
```bash
ls > a.txt
```

#### 4.2 xargs -i/xargs -I
下面给出一个例子：
```bash
 declare path=$(cd `dirname $0`;pwd)
 #当前路径
 find $path -type f -name "*.txt" | xargs -i cp {}  $path/tmp/k/
 # 加-i 参数直接用 {}就能代替管道之前的标准输出的内容
 # 前面find命令就是获取到当前目录所有的txt文件，而`{}`就是代表所有的`txt`文件
 # 通过这个命令可以将这些文件移动到`tmp/k/`目录
```
下面是`xargs-I`的例子：
```bash
 declare path=$(cd `dirname $0`;pwd)
find $path -type f -name "*.txt" | xargs -I [] cp []  $path/tmp/n/
# 加 -I 参数 需要事先指定替换字符,该替换字符就是用于代表前面的管道输出，即find命令的结果
# 这里表示使用[]表示find的查询结果
```
下面是一个稍微复杂一点的例子：
```bash
declare path=$(cd `dirname $0`;pwd)
#当前的工作目录
cat $path/args.txt | xargs -I {} $path/sk.sh -p {} -l
#  Prompt for confirmation before running each command line.
# Only run the command line if the response starts with 'y' or 'Y'. Implies -t.
```
此时你会发现xargs后面还接着运行了一个`shell`命令了,在`sk.sh`中我们可以看到传入了三个参数：
```bash
echo "所有参数列表"$* 
#有-p,aaa,-l
#-p,bbb,-l
#-p,ccc,-l
```
下面是xargs与find命令一起使用时候的例子：
```bash
declare path=$(cd `dirname $0`;pwd)
find $path -type f -name "*.log" -print0 | xargs -0 rm -f
#print0的作用如下:
#True; print the full file name on the standard output, followed by a null character (instead of the newline character that '-print' uses).
# This allows file names that contain newlines or other types of white space to be correctly interpreted by programs that process the find output. This option corresponds to the '-0' option of xargs.This option corresponds to the '-0' option of xargs.
#使用print0输出完整的文件名，即使文件名中有换行符或者空格也能正确的处理。这个选项与xargs的-0一起使用
```
下面的例子是xargs压缩文件与下载资源的例子：
```bash
cat url-list.txt | xargs wget -c
#将url-list.txt中的url全部下载下来
find . -type f -name "*.jpg" -print | xargs tar -czvf images.tar.gz
#将所有的jng打包成为一个文件
```
这里是[wget命令用于文件下载特别游泳](http://man.linuxde.net/wget)与[tar命令用于压缩文件](http://man.linuxde.net/tar)的文档。同时如[压缩解压缩](http://man.linuxde.net/compress)都可以在这个网页上学习，这里不再深入讨论了！

以上几个例子你也可以查看[xargs命令](http://man.linuxde.net/xargs)

#### 4.3 子shell
```bash
#!/bin/bash
cd ./tmp/n
```
此时当你在[该目录下](./src/xargs/)运行该文件你会发现我们的控制台的路径仍然为:
```bash
 ~/Desktop/shellGlobStar/src/xargs
```
如果你要在父shell中运行该脚本可以如下:
```bash
. ./test.sh
```
此时你会发现，控制台路径已经变化为./tmp/n了




参考文献：

[linux shell 获取当前正在执行脚本的绝对路径](http://www.cnblogs.com/FlyFive/p/3640267.html)

[set命令设置shell的特殊选项](http://blog.sina.com.cn/s/blog_3d2d79aa0100h08i.html)

[shell的set命令](http://www.tuicool.com/articles/QfyYrm)

[set命令官方网站](http://pubs.opengroup.org/onlinepubs/009695399/utilities/set.html)

[Bash 为何要发明 shopt 命令](http://www.cnblogs.com/ziyunfei/p/4913758.html)

[Shell官网中文](http://man.linuxde.net/export)

[使用BASH中的GLOBSTART选项](http://smilejay.com/2013/10/enable-globstar-in-bash/)

[rm用法之 删除除了某个文件之外的所有文件, extglob enable](http://blog.csdn.net/ciedecem/article/details/18315543)

[linux中shell变量$#,$@,$0,$1,$2的含义解释](http://www.cnblogs.com/fhefh/archive/2011/04/15/2017613.html)

[shopt官方参数文档](https://ss64.com/bash/shopt.html)

[Linux下的find命令详解](http://blog.csdn.net/gavin__zhou/article/details/52152419)

[linux 根据文件大小查找文件](http://www.cnblogs.com/feng18/p/6004339.html)

[atime、mtime、ctime](http://blog.chinaunix.net/uid-24500107-id-2602881.html)

[彻底搞明白find命令的-mtime参数的含义](http://blog.itpub.net/23249684/viewspace-1156932/)

[wc命令的使用](https://ss64.com/bash/wc.html)

[linux之find命令详解](http://www.cnblogs.com/bigbean/p/3669739.html)

[linux find -regex 使用正则表达式](http://www.cnblogs.com/jiangzhaowei/p/5451173.html)

[ Linux进程间通信——使用匿名管道](http://blog.csdn.net/ljianhui/article/details/10168031)

[ Linux进程间通信——使用命名管道](http://blog.csdn.net/ljianhui/article/details/10202699)

[管道与命名管道（FIFO文件）](http://www.cnblogs.com/yxmx/articles/1599187.html)

[linux管道的那点事 ](http://blog.chinaunix.net/uid-27034868-id-3394243.html)

[xargs的i参数](http://blog.csdn.net/luojiafei/article/details/7213489)

[xargs 命令](http://www.cnblogs.com/xuxm2007/archive/2010/12/02/1894798.html)

[ 父Shell与子Shell](http://blog.csdn.net/a600423444/article/details/6451111)