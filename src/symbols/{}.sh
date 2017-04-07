#这里不会产生subshell而是直接在父shell中运行
{cd ~ ; vcgh=`pwd` ; echo $vcgh}
echo "没有产生subshell:"$vcgh