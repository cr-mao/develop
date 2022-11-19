#!/bin/bash

# cr-mao 

# check linux info
uname -a
cat /etc/os-release

# check hostname
hostname

# check hardware info
cat /proc/cpuinfo
cat /proc/meminfo | head

# check ip info
ip addr
