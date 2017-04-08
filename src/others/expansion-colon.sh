declare bb=10;
echo ${aa-${bb}}
#此时aa为空，打印结果为${bb}的值，即10
echo ${aa:=${bb}}
#符号`:=`表示，如果aa为空，那么aa被赋值为${bb}的值，打印10
echo ${cc}
#打印空
echo ${cc:=${bb}}
#如果cc为空，那么设置为bb的值，即10
echo ${cc}
#此时cc已经在上一步被设置为10了