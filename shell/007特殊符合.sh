#!/bin/bash



echo "the # here not begin a comment."
echo 'the # xxx'
echo the \# does not begin a comment.


echo hello; echo there

abc="abc"

case "$abc" in 

abc)
	echo "\$abc=abc"
	;;
bcd)
	echo "\$abc=bcd"
	;;
esac



while true
do
	echo "ok"
	sleep 1
done



# 预定义变量
# $0 脚本名 
# $* 所有参赛
# $@ 所有参赛
# $# 参数个数
# $? 命令返回值，0 成功
# $$当前进程id


# [] 文件测试、数值比较、字符串比较
# [[]] # 增加了对正则对支持, [[ || ]] ,[[ && ]]

# ${} 变量引用
# $(( 1+2 )) 支持运算
# $()  => `command`
# (()) 数值比较，运算 ，支持正则
# () 在子shell中执行


# ./01.sh 在子shell中执行，需要执行权限
# bash sh  不需要执行权限，在子shell中执行
# .01.sh    不需要执行权限,在当前shell中执行
# source 01.sh  不需要执行权限,在当前shell中执行

# sh -n 02.sh  #仅调试语法
# sh -vx 02.sh # 已调试的方式执行,查询整个执行过程
