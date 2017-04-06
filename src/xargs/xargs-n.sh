declare currentFolder=$(cd `dirname $0`;pwd)
cat $currentFolder/content.txt | xargs -n3
# Use at most max-args arguments per command line. Fewer than max-args arguments will be used
#if the size (see the -s option) is exceeded, unless the -x option is given, in which case
#xargs will exit. 
