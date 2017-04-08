declare cc=10;
echo ${cc:+"Value not set1"}
#这里的${cc}被设置了，表达式返回后面的值"Value not set1"
echo ${dd:+"Value not set2"}
#当${dd}没有设置的时候，表达式返回null