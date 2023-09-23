#!/bin/bash

#从文件中 一行一行 读

ls *.sh > execfile


while read LINE
do
   echo $LINE
done < execfile

