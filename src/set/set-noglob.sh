set -o noglob
#开启通配符
declare path=$(cd `dirname $0`;pwd)
ls -ahl -n $path/noglob$
echo "Next is noglob closed:"
set +o noglob
#关闭通配符
ls -ahl -n $path/noglob$


#例子2
# set -o noglob
# #关闭通配符
# declare path=$(cd `dirname $0`;pwd)
# ls -ahl -n $path/noglo[bc]
# echo "Next is noglob closed:"
# set +o noglob
# #开启通配符
# ls -ahl -n $path/noglo[bc]