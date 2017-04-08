 declare path=$(cd `dirname $0`;pwd)
 cd $path
for f in *.txt
  do 
   echo  $f
   echo ${f#1}
   echo "-------------"
 done