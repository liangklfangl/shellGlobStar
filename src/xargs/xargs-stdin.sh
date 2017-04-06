declare path=$(cd `dirname $0`;pwd)
#当前的工作目录
cat $path/args.txt | xargs -I {} $path/sk.sh -p {} -l
#  Prompt for confirmation before running each command line.
# Only run the command line if the response starts with 'y' or 'Y'. Implies -t.