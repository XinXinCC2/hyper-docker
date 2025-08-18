FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y \
        curl \
        tar \
        vim \
        libc6 \
        libgomp1 \
    && rm -rf /var/lib/apt/lists/*

# 关闭模型拷贝-直接采用映射
# # 创建目标目录
# RUN mkdir -p /root/.cache/hyperspace/models/hf__TheBloke___phi-2-GGUF__phi-2.Q4_K_M.gguf

# # 复制模型文件到容器
# COPY hf__TheBloke___phi-2-GGUF__phi-2.Q4_K_M.gguf /root/.cache/hyperspace/models/hf__TheBloke___phi-2-GGUF__phi-2.Q4_K_M.gguf

# 安装 aiOs CLI
RUN curl https://download.hyper.space/api/install | bash

# 设置工作目录
WORKDIR /root

# 将 .aios 目录加入 PATH
ENV PATH="/root/.aios:${PATH}"

# 复制启动脚本
COPY start-hyperspace.sh /root/start-hyperspace.sh
RUN chmod +x /root/start-hyperspace.sh

# 使用 CMD 而不是 ENTRYPOINT
CMD ["/bin/bash", "/root/start-hyperspace.sh"]
