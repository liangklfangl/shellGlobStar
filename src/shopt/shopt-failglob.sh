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
#因为我们设置了nullglob，表示如果没有文件那么直接返回null，所以这里没输出任何内容


