# HyperSpace Docker 部署

这是一个用于部署 HyperSpace 服务的 Docker 配置项目。该项目使用 Docker 和 Docker Compose 来管理多个 HyperSpace 服务实例。

## 项目结构

```
.
├── Dockerfile              # Docker 镜像构建文件
├── docker-compose.example.yml  # Docker Compose 配置示例文件
├── start-hyperspace.sh     # 服务启动脚本
└── README.md              # 项目说明文档
```

## 前置准备

拷贝模型文件到当前文件夹(不同系统位置不一样)：
   ```bash
   cp -r ~/.cache/hyperspace/models/hf__TheBloke___phi-2-GGUF__phi-2.Q4_K_M.gguf .
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

2. 配置服务：
```bash
# 复制示例配置文件
cp docker-compose.example.yml docker-compose.yml

# 编辑配置文件，设置您的 AIOS_KEY
vim docker-compose.yml
```

3. 启动服务：
```bash
docker-compose up -d
```

4. 查看服务状态：
```bash
docker-compose ps
```

5. 查看服务日志：
```bash
docker-compose logs -f
```

## 单个容器操作

### 启动、停止、重启单个容器
```bash
# 启动单个容器
docker-compose up -d <service-name>

# 停止单个容器
docker-compose stop <service-name>

# 重启单个容器
docker-compose restart <service-name>

# 示例：重启 hyperspace-1 服务
docker-compose restart hyperspace-1
```

### 进入容器内部
```bash
# docker exec
docker exec -it <container-name> /bin/bash

# 退出容器
exit
```

### 查看容器日志
```bash
# 查看容器实时日志
docker-compose logs -f <service-name>

# 查看容器最近日志
docker-compose logs <service-name>

# 查看容器最后几行日志
docker-compose logs --tail=50 <service-name>

# 或者使用 docker logs
docker logs <container-name>
docker logs --tail=50 <container-name>

# 示例：查看 hyperspace-1 的最后 20 行日志
docker-compose logs --tail=20 hyperspace-1
```

## 配置说明

- 每个服务实例使用独立的端口映射
- 通过环境变量 `AIOS_KEY` 配置服务密钥
- 服务自动重启策略已配置
- 配置文件说明：
  - `docker-compose.example.yml`: 示例配置文件，不包含敏感信息
  - `docker-compose.yml`: 实际使用的配置文件（需要自行创建，不要提交到 Git）

## 注意事项

- 请确保 Docker 和 Docker Compose 已正确安装
- 运行前请确保有足够的系统资源
- 请妥善保管 AIOS_KEY
- 不要将包含实际 AIOS_KEY 的 docker-compose.yml 提交到 Git 仓库 