# for i in {1..100..2}
# # {首..尾..增量}  
# # seq 首数 [增量] 末数
# do
#     echo $i
# done


# #!/bin/bash
# PREFIX=192.168.1.
# for i in `seq 100 110`
# 这里展示了
# do
#     echo -n "${PREFIX}$i "
#     ping -c5  ${PREFIX}${i} >/dev/null 2>&1
#     if [ "$?" -eq 0 ];then
#         echo "OK"
#     else
#         echo "Failed"
#     fi
# done

for f in *.md
  do 
   echo ${f%md}
   #%表示取左边，而#表示取右边，和键盘上'#,$,%'的排列有关
   #mv ./"$f" "${f%txt}htm"
 done