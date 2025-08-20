
# 启动守护进程
echo "Starting aios-cli daemon..."
aios-cli start &
DAEMON_PID=$!

# 等待守护进程完全启动
sleep 5

# 将密钥写入文件（使用 printf 避免换行符问题）
echo "Writing AIOS key to file..."
echo "$AIOS_KEY" > /root/my.pem

# 密钥导入程序
echo "Importing keys..."
aios-cli hive import-keys /root/my.pem

# 登录hive
echo "Logging into hive..."
aios-cli hive login
sleep 1

# 检查并下载所需模型
echo "Checking required models..."
if ! aios-cli models list | grep -q "phi-2.Q4_K_M.gguf"; then
    echo "Downloading required model..."
    aios-cli models add hf:TheBloke/phi-2-GGUF:phi-2.Q4_K_M.gguf
fi

# 分配 GPU 内存（这将自动选择最佳 tier）
echo "Allocating GPU memory..."
aios-cli hive allocate 2GB
sleep 2

# 连接hive
echo "Connecting to hive..."
max_retries=3
retry_count=0
while [ $retry_count -lt $max_retries ]; do
    if aios-cli hive connect | grep -q "Failed to connect to Hive"; then
        echo "连接失败，正在重试... (尝试 $((retry_count + 1))/$max_retries)"
        retry_count=$((retry_count + 1))
        sleep 5
    else
        echo "成功连接到 Hive"
        break
    fi
done

if [ $retry_count -eq $max_retries ]; then
    echo "达到最大重试次数，连接失败"
    exit 1
fi

sleep 5

# 关闭进程
echo "Killing current process..."
aios-cli kill
sleep 5

# 重新启动并连接
echo "Restarting with connection..."
aios-cli start --connect

# 保持容器运行
tail -f /dev/null 