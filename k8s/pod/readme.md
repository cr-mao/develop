
k8s的配置文件中经常看到有imagePullPolicy属性，这个属性是描述镜像的拉取策略

`Always` 总是拉取镜像
`IfNotPresent` 本地有则使用本地镜像,不拉取
`Never` 只使用本地镜像，从不拉取，即使本地没有
如果省略imagePullPolicy，  策略为always 