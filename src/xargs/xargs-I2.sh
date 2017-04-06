 declare path=$(cd `dirname $0`;pwd)
ls $path/*.PNG | xargs -n1 -I {} cp {} $path/data/images
# Use at most max-args arguments per command line. Fewer than max-args arguments will be used
#if the size (see the -s option) is exceeded, unless the -x option is given, in which case
# xargs will exit. 
