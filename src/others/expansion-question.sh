declare cc=10;
echo ${cc:? "Value not set"}
#如果此时cc变量为空，那么后面的内容被输出到控制台，同时shell非正常退出，退出码为非0
#这里打印10
echo ${dd:?"Value not set"}
#打印错误消息：/c/Users/Administrator/Desktop/shellGlobStar/src/others/expansion-question.sh: line 4: dd: Value not set
