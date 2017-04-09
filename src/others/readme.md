#### 这个页面主要记录那些在开发过程中遇到的问题，与具体的命令无关

### 1.%,#的作用
```bash
 declare path=$(cd `dirname $0`;pwd)
 cd $path
for f in *.txt
  do 
   echo ${f%txt}
   #%表示取左边，即变量f的txt左边的部分
   mv ./"$f" "${f%txt}htm"
   #将该目录下所有的txt后缀文件转化为'htm'
 done
```
其中${f%/str}用于获取$f变量在`str`左侧的部分内容，这个例子就是，将该目录下所有的txt后缀文件转化为'htm'。下面再给出一个"#"的例子：
```bash
 declare path=$(cd `dirname $0`;pwd)
 cd $path
for f in *.txt
  do 
   echo  $f
   echo ${f#1}
   #去掉文件名前面的"1"这个前缀
   echo "-------------"
 done
```
此时你会发现在此时打印出来如下结果：
```js
1.txt
.txt
-------------
2.txt
2.txt
-------------
```
你会发现'1.txt'中的`'1'这前缀`已经被移除了！

下面再给出一个${i#*/}与${name%/*}的例子：
```bash
#!/bin/sh
files=`find -name *.txt`
# 如果当前pwd为~/Desktop/shellGlobStar，那么就是获取该目录下的所有的txt文件绝对路径。 
# 如下面的$i可以是./src/cat/cat.txt,注意：这里的$i是一个相对路径，其是相对于pwd来说的
# 但是${i#*/}得到的是`src/cat/cat.txt`,也就是直接去掉了前面的相对路径部分!
# 同时${i%/*}得到的就是`src/cat`,也就是仅仅包含了name的path部分，而不包括文件名
for i in $files
do
  echo $i
  #完整相对路径
  name=${i#*/}
  #去掉完整相对路径的相对部分
  #表示取从第一个slash之后的完整内容
  echo $name
  dir=${name%/*}
  #直接获取到name的path部分
  #即%/*代表取从头到最后一个slash之前的所有内容，不包括slash本身
  echo $dir
  echo "----------------"
  # 
done
```
总之：
<pre>
'#'代表删除从前往后最小匹配的内容,具体格式为${varible#*string}。即，从左向右截取第一个string后的字符串，这也是为什么$name得到的是`src/cat/cat.txt`
'%'代表删除从后往前最小匹配的内容。具体格式为：${varible%string*}从右向左截取第一个string后留下的字符串，这也是为什么$dir为`src/cat`。
注意：之所以`#`代表从左向右截取后留下的内容，而`%`代表从右向左截取后的内容，原因在于：键盘上的#在$的左侧，而%在$的右侧！
</pre>

下面再给出一个的${i##*/}与${i%%/*}例子：
```bash
#!/bin/sh
files=`find -name *.txt`
for i in $files
do
  echo $i
  echo ${i##*/}
  #如$i的结果为./src/cat/cat.txt，那么${i##*/}得到的就是"cat.txt"
  #表示最后一个/之后的部分，从左到右计算
  echo ${i%%/*}
  #如$i的结果为./src/cat/cat.txt，那么${i%%*/}得到的就是"."
  #表示从右到左最后一个/之前的部分
  echo "----------------"
done
```
总之：
<pre>
 ${varible##*string} 从左向右截取最后一个string后的字符串
 ${varible%%string*}从右向左截取最后一个string之前的字符串
</pre>

### 2.Linux Shell参数扩展（Parameter Expansion）

#### 2.1 ${parameter:-[word]}
<pre>
Use Default Values. If parameter is unset or null, the expansion of word (or an empty string if word is omitted) shall be substituted; otherwise, the value of parameter shall be substituted.
</pre>
```bash
declare bb=3
echo ${aa}
#aa此时为空
echo ${bb}
#bb此时为3
echo ${aa-${bb}}
#${aa-world}表示如果aa为空，那么就使用world的值替换
aa=2
echo ${aa-${bb}}
#此时aa已经非空，那么直接打印aa的值即可，注意，此时与后面的${bb}无关
```
#### 2.2 ${parameter:=[word]}
<pre>
Assign Default Values. If parameter is unset or null, the expansion of word (or an empty string if word is omitted) shall be assigned to parameter. In all cases, the final value of parameter shall be substituted. Only variables, not positional parameters or special parameters, can be assigned in this way.
</pre>
```bash
declare bb=10;
echo ${aa-${bb}}
#此时aa为空，打印结果为${bb}的值，即10
echo ${aa:=${bb}}
#符号`:=`表示，如果aa为空，那么aa被赋值为${bb}的值，打印10
echo ${cc}
#打印空
echo ${cc:=${bb}}
#如果cc为空，那么设置为bb的值，即10
echo ${cc}
#此时cc已经在上一步被设置为10了
```
#### 2.3 ${parameter:?[word]}
<pre>
`Indicate Error if Null or Unset`. If parameter is unset or null, the expansion of word (or a message indicating it is unset if word is omitted) shall be written to standard error and the shell exits with a non-zero exit status. Otherwise, the value of parameter shall be substituted. An interactive shell need not exit.
</pre>
```bash
declare cc=10;
echo ${cc:? "Value not set"}
#如果此时cc变量为空，那么后面的内容被输出到控制台，同时shell非正常退出，退出码为非0
#这里打印10
echo ${dd:?"Value not set"}
#打印错误消息：/c/Users/Administrator/Desktop/shellGlobStar/src/others/expansion-question.sh: line 4: dd: Value not set

```
#### 2.4 ${parameter:+[word]}
<pre>
Use Alternative Value. If parameter is unset or null, null shall be substituted; otherwise, the expansion of word (or an empty string if word is omitted) shall be substituted.
</pre>
```bash
declare cc=10;
echo ${cc:+"Value not set1"}
#这里的${cc}被设置了，表达式返回后面的值"Value not set1"
echo ${dd:+"Value not set2"}
#当${dd}没有设置的时候，表达式返回null
```
当${parameter}值为空或者没有设定的时候，表达式返回null。否则用[word]替换表达式的值。
#### 2.5 ${#parameter}
<pre>
String Length. The length in characters of the value of parameter shall be substituted. If parameter is '*' or '@', the result of the expansion is unspecified. If parameter is unset and set -u is in effect, the expansion shall fail.
</pre>
```bash
declare cc=10;
echo ${#cc}
#cc的字符个数为2，打印2
echo ${#dd}
#dd没有定义，长度为0
```
#### 2.6 其他组合的特殊字符
${parameter%[word]}或者${parameter%%[word]}，${parameter#[word]}，${parameter##[word]}等都在前面已经看到了,此处不再说明

### 3.Shell的read方法$IFS与$REPLY
```bash
IFS=";"
#此时我强制要求控制台输入的变量的值之间通过";"分隔
read sex location des
printf "%d\n" "'$IFS"
#此时你会发现如果没有第一句的`IFS=";"`，那么此处打印的ASCII为32，也就是说默认就是空格的
echo "echo输出"$REPLY
#如果read后没有name等名称，那么变量都是在$REPLY中，如果有name那么这个变量为空
#read必须以空格分隔，控制台输入的时候也必须用空格分隔
#如果你输入male hangzhou hunan dalian hefei shanghai
#那么将会打印：sex=male,location=hangzhou,des=hunan dalian hefei shanghai
echo "sex=$sex,location=$location,des=$des"
```
此处说明了$REPLY,$IFS的用法，同时也展示了`使用printf来打印ASCII的方法`！

### 3.linux中的link命令,即软连接与硬链接
其中link命令的学习，你可以[查看这个文档](./link-hard-soft.md)。

### 4.linux中的alias命令
其中linux的命令的学习，你可以[查看这个文档](../alias/read.md)

### 5.linux中的一些基础内容，如颜色等
你可以[查看这个文档](./linux-foundation.md)


参考资料：

[ Shell中#*/和%/*是什么意思？](http://blog.csdn.net/hongchangfirst/article/details/28436947)

[在shell里面，“%”、“#”、“*” 是什么意思，如${a%#.}、${a%%.*}、${a##.*}](https://zhidao.baidu.com/question/179948099.html)

[Linux Shell参数扩展（Parameter Expansion](http://blog.csdn.net/tanzhangwen/article/details/41248671)

[Shell Expansion](https://ss64.com/bash/syntax-expand.html#parameter)

[Shell Command Language](http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_13)