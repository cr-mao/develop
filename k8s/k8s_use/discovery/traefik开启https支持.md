```### 此资源由 58学课资源站 收集整理 ###
	想要获取完整课件资料 请访问：58xueke.com
	百万资源 畅享学习

```


# traefik开启https支持


## 修改Traefik服务配置

args添加参数
```bash
- --entrypoints.http.address=:80
- --entrypoints.https.address=:443
```

ports新增端口映射：

```bash
- name: https
  containerPort: 443
  hostPort: 443
```

## 生成证书

```bash
openssl req -newkey rsa:2048 -nodes -keyout tls.key -x509 -days 3650 -out tls.crt
```

## 创建Secret

```bash
kubectl create secret generic kubeimooc-cert --from-file=tls.crt --from-file=tls.key -n kubeimooc-system
```

## IngressRoute指定secret
```yaml
tls:
  secretName: kubeimooc-cert
```