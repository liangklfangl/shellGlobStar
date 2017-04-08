 declare path=$(cd `dirname $0`;pwd)
 cd $path
for f in *.txt
  do 
   echo ${f%txt}
   #%表示取左边，而#表示取右边，和键盘上'#,$,%'的排列有关
   mv ./"$f" "${f%txt}htm"
   #将该目录下所有的txt后缀文件转化为'html'
 done