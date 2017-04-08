#### 这个页面主要记录那些在开发过程中遇到的问题，与具体的命令无关

### 1.%,#符号的作用
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
其中${f%/str}用于获取$f变量在`str`左侧的部分内容，这个例子就是，将该目录下所有的txt后缀文件转化为'htm'

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
 ${varible%%string*}从右向左截取最后一个string后之前的字符串
</pre>










参考资料：

[ Shell中#*/和%/*是什么意思？](http://blog.csdn.net/hongchangfirst/article/details/28436947)

[在shell里面，“%”、“#”、“*” 是什么意思，如${a%#.}、${a%%.*}、${a##.*}](https://zhidao.baidu.com/question/179948099.html)