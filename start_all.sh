#!/bin/bash

cd /Users/chenghh/Documents/区块链/空投/hyperspace/hyper_docker || exit 1

echo "========== 启动批量 hyperspace 容器脚本 =========="
echo "开始时间: $(date)"

for i in $(seq 1 100)
do
  service="hyperspace-$i"
  echo "[INFO] $(date '+%F %T') 正在启动 $service ..."
  docker compose -f docker-compose_1.yml up -d $service
  if [ $? -eq 0 ]; then
    echo "[SUCCESS] $(date '+%F %T') $service 启动成功"
  else
    echo "[ERROR] $(date '+%F %T') $service 启动失败"
  fi
  sleep_time=$((RANDOM % 6 + 10))
  echo "[INFO] $(date '+%F %T') 等待 $sleep_time 秒后启动下一个服务..."
  sleep $sleep_time
done

echo "========== 所有服务启动完毕 =========="
echo "结束时间: $(date)" 