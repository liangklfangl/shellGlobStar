declare path=$(cd `dirname $0`;pwd)
files=`grep magic $path/*`
#等号两边没有空格,必须是$path/*而不是$path,否则报错说是一个文件夹而不是有效的路径
echo "含有magic字段的文件为\n"$files
#此时会打印所有的含有`magic`单词的文件完整文件名和出现该单词的一行的内容，注意：
#一个文件可能会打印多行

#上面这种方式无法搜索该目录下的inner子目录，输出内容为：
#grep: /c/Users/Administrator/Desktop/shellGlobStar/src/grep/inner: Is a directory
filess1=`grep -r magic $path/*`
#明确要求搜索子目录
#此时inner目录内的文件也会被搜索出来
filess2=`grep -d skip magic $path/*`
#明确要求忽略子目录，inner目录的文件没有被搜出
filess3=`grep magic $path/* | less`
#通过管道将输出转移到less中阅读
echo -e "明确搜索子目录\n"$filess1
echo -e "明确忽略子目录\n"$filess2
echo -e "明确将管道输出到less\n"$filess3