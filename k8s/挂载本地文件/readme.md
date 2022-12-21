定义volumns给容器用
```yaml
volumes:
  - name: v1
    hostPath:
    path: /home/shenyi/myweb
```

定义在容器里
```yaml
volumeMounts:
  - name: v1
    mountPath: /app
```


/home/www/myweb 下有个myserver的gin可执行二进制文件






