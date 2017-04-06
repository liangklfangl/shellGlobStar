function show()
{
        for i in **
        # * 被展开成当前目录下所有文件名
        # ** 当前目录以及子目录下的所有的文件
        # **就是我们常说的globalStar
        do
                echo FileName is $i
                # 前面不需要添加引号表示字符串
        done
}
 
cd  ../../src/
echo "------------------------"
echo "disable globstar option:"
# globstar is disabled by default
shopt -u globstar
show
echo "------------------------"
echo "enable globstar option:"
shopt -s globstar
show