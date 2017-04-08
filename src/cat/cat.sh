 cat  >  stdin.txt
 #用于从控制台中将内容输出到文件stdin.txt中，ctrl+c停止输出
 #只能创建新文件,不能编辑已有文件.
 cat cat.txt stdin.txt > output.txt
#将多个文件合并成一个文件
cat -n cat.txt > catnumber.txt
#标记行号
cat -b cat.txt stdin.txt >> linuxfile3.txt
#对空白行不编号,但是发现在windows上的bash中也是编号的