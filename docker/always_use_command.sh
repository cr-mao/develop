#!/bin/bash

## 常用docker命令


# 移除停止的容器
docker container prune

# 运行并进入容器
docker run -it xxx  image:tag  /bin/bash



# 导出镜像
docker save  xxx:tag  > xxx.tar
# 倒入镜像
docker load < xxx.tar



