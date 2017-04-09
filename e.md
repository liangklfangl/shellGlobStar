### find: missing argument to `-exec'
解决方案查看[find: missing argument to `-exec'](http://chenzhou123520.iteye.com/blog/1912633)

### /c/Users/Administrator/Desktop/shellGlobStar/src/grep/grep-content.sh: line 2: filelist: command not found
解决方案：等号两边没有空格

### grep: /c/Users/Administrator/Desktop/shellGlobStar/src/grep: Is a directory
```bash
#files=`grep magic $path`
#修改为如下内容
files=`grep magic $path/*`
```
