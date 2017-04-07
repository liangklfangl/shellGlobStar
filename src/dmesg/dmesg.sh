 declare path=$(cd `dirname $0`;pwd)
 dmesg | grep -n -d skip -A3 -B2 --color=auto "magic" $path/dmesg.txt
 #显示行号的同时我们高亮显示,同时将关键行的前两行与后两行都显示出来
 #其中如A3，B2的部分全部在前面添加上