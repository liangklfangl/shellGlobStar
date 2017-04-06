#例子1:
# shopt -u extglob   
# #关闭shopt行为，其中-s表示激活指定的shell行为
# declare path=$(cd `dirname $0`;pwd)
# mv !(backup|tmp) backup/

#例子2
# shopt -s extglob   
# #启动shopt行为，其中-s表示激活指定的shell行为
# rm -rf file[1-2].js

#例子3
# shopt -s extglob
# for i in *(f)ile1.js
#  do 
#    echo "FileName:$i";
#  done


#例子4：
# shopt -s extglob
# for i in +(f)ile1.js
#  do 
#    echo "FileName:$i";
#  done

#例子5
# shopt -s extglob
# for i in ?(f)ile1.js
#  do 
#    echo "FileName:$i";
#  done

#例子6
# shopt -s extglob
# echo 'Shell本身的PID'$$
# #Shell本身的PID（ProcessID） 
# echo 'Shell最后运行的后台process的PID:'$!
# #Shell最后运行的后台process的PID:
# echo "所有参数列表"$* 
# #shopt-extglob.sh win-98 sex name运行shell程序得到的结果为：win-98 sex name
# echo "参数个数："$#
# #添加到shell中参数个数
# echo "shell本身文件名" $0
# # @(pattern-list) 表示匹配列表中其中一个pattern
# echo "逐个访问参数"$1
# #添加到Shell的各参数值。$1是第1参数、$2是第2参数…
# # !(pattern-list) 表示匹配任何一个非列表中的pattern
# case $1 in
# @(win-98|win-xp|win-7|win-10))
#    echo "windows";;
# @(Redhat*|Centos*|Debian*|Ubuntu*))
#   echo "linux";;
# *) 
# echo "others";;
# esac


shopt -s extglob
case $1 in 
	!(windows7|windowXP))
      echo "You are not in windows7 nor windowXP platform";;
     *)
#This is default router
     echo "You are  in windows  platform";;
esac