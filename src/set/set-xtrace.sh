#!/bin/bash
set -o xtrace
# set +o noglob
# 设置了这个选项之后，对于每一条要执行的命令，shell在扩展了命令之后（参数扩展）、执行命令之前
# 输出trace到stderr。
set -o errexit 
 # 可以把这样注释掉看下执行效果有什么不一样。

echo "Before"
ls   
# ls也不存在的文件
echo "After"