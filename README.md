# HyperSpace Docker 部署

这是一个用于部署 HyperSpace 服务的 Docker 配置项目。该项目使用 Docker 和 Docker Compose 来管理多个 HyperSpace 服务实例。

## 项目结构

```
.
├── Dockerfile              # Docker 镜像构建文件
├── docker-compose.yml      # Docker Compose 配置文件
├── start-hyperspace.sh     # 服务启动脚本
└── README.md              # 项目说明文档
```

## 功能特点

- 支持多实例部署
- 自动端口映射
- 服务自动重启
- 环境变量配置

## 使用方法

1. 构建镜像：
```bash
docker build -t hyper-cli .
```

2. 启动服务：
```bash
docker-compose up -d
```

3. 查看服务状态：
```bash
docker-compose ps
```

4. 查看服务日志：
```bash
docker-compose logs -f
```

## 配置说明

- 每个服务实例使用独立的端口映射
- 通过环境变量 `AIOS_KEY` 配置服务密钥
- 服务自动重启策略已配置

## 注意事项

- 请确保 Docker 和 Docker Compose 已正确安装
- 运行前请确保有足够的系统资源
- 请妥善保管 AIOS_KEY 