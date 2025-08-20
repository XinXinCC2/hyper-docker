# #!/bin/bash
# aios-cli kill

# # 启动守护进程
# echo "Starting aios-cli daemon..."
# aios-cli start &
# DAEMON_PID=$!

# # 等待守护进程完全启动
# sleep 5

# # 登录hive
# echo "Logging into hive..."
# aios-cli hive login
# sleep 1


# # 连接hive
# echo "Connecting to hive..."
# max_retries=3
# retry_count=0
# while [ $retry_count -lt $max_retries ]; do
#     if aios-cli hive connect | grep -q "Failed to connect to Hive"; then
#         echo "连接失败，正在重试... (尝试 $((retry_count + 1))/$max_retries)"
#         retry_count=$((retry_count + 1))
#         sleep 5
#     else
#         echo "成功连接到 Hive"
#         break
#     fi
# done

# if [ $retry_count -eq $max_retries ]; then
#     echo "达到最大重试次数，连接失败"
#     exit 1
# fi

# sleep 5

# # 关闭进程
# echo "Killing current process..."
# aios-cli kill
# sleep 5

# # 重新启动并连接
# echo "Restarting with connection..."
# aios-cli start --connect

# # 保持容器运行
# tail -f /dev/null 


aios-cli start --connect