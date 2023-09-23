#!/bin/bash

# expr 两边必须有有空格
# (()) 双小括号 和[] 可以运算 
# let 

# 小数用bc管道

num1=10
num2=20


num3=`expr $num1 + $num2`
echo $num3


expr 2 \* 2




sum=$(($num1+$num2))
echo $sum


echo sum=$[$num1+$num2]


unset sum
sum=2
let sum=sum+8
echo $sum # 10


echo "2.1*4" |bc

# 变量自增
i=1
let i++
echo $i
