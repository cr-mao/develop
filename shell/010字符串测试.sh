-z 字符串长度为0
-n 字符串长度是否非0
!= 

=  判断2个字符串是否相等
!= 判断2个字符串是否不等






#!/bin/bash

if [ $user != 'root' ];then 
	echo "没有权限"
	exit 
fi 

yum -y install httpd
