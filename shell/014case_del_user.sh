#!/bin/bash

read -p "please input a username " user

id $user &>/dev/null
if [ $? -ne 0 ];then
	echo "no such user: $user"
	exit 1
fi 
read -p "Are you sure ? [y/n];" action
case "$action" in 
y|Y|yes|YES)
	userdel -r $user
        ;;
*)
	echo "error"
esac
