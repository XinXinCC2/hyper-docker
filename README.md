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

1. 下载 aios-cli 二进制文件：
   - 访问 https://download.hyper.space/api/install 下载
   - 或使用以下命令：
   ```bash
   curl https://download.hyper.space/api/install -o aios-cli-x86_64-unknown-linux-gnu.tar.gz
   ```

2. 将下载的文件放在项目根目录

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