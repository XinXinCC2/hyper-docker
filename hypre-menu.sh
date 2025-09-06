#!/bin/bash

# Define color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

function start_containers() {
  echo "========== 启动批量 hyperspace 容器 =========="
  read -p "请输入起始序号 (默认为1): " start
  read -p "请输入结束序号 (默认为5000): " end
  start=${start:-1}
  end=${end:-5000}
  for i in $(seq $start $end)
  do
    service="hyperspace-$i"
    if [ $(docker ps -q -f name=$service) ]; then
      echo -e "${BLUE}[INFO] $service 已经在运行，跳过启动。${NC}"
      continue
    fi
    echo -e "${BLUE}[INFO] $(date '+%F %T') 正在启动 $service ...${NC}"
    docker compose -f docker-compose_1.yml up -d $service
    if [ $? -eq 0 ]; then
      echo -e "${GREEN}[SUCCESS] $(date '+%F %T') $service 启动成功${NC}"
    else
      echo -e "${RED}[ERROR] $(date '+%F %T') $service 启动失败${NC}"
    fi
    sleep_time=$((RANDOM % 6 + 5))
    echo -e "${BLUE}[INFO] $(date '+%F %T') 等待 $sleep_time 秒后启动下一个服务...${NC}"
    sleep $sleep_time
  done
}

function check_points() {
  echo "========== 查看积分 =========="
  for service in $(docker ps --format '{{.Names}}' | grep '^hyperspace-'); do
    echo -e "${BLUE}[INFO] 正在查看 $service 的积分...${NC}"
    docker exec $service aios-cli hive points | head -n 2
  done
}

function collect_key_pairs() {
  echo "========== 收集密钥对 =========="
  output_file="key_pairs.txt"
  echo "" > $output_file
  for service in $(docker ps --format '{{.Names}}' | grep '^hyperspace-'); do
    echo -e "${BLUE}[INFO] 正在收集 $service 的密钥对...${NC}"
    echo "$service" >> $output_file
    docker exec $service aios-cli hive whoami >> $output_file
  done
}

function stop_unstarted_containers() {
  echo "========== 关闭未启动的容器 =========="
  for service in $(docker ps --format '{{.Names}}' | grep '^hyperspace-'); do
    echo "[INFO] 正在检查 $service 的状态..."
    if ! docker exec $service aios-cli status | grep -q '50051'; then
      echo "[INFO] $service 未启动，正在关闭并删除..."
      docker stop $service
      docker rm $service
      echo "[SUCCESS] $service 已关闭并删除"
    else
      echo "[INFO] $service 正在运行"
    fi
  done
}

while true; do
  echo "请选择要执行的功能:"
  echo "1. 批量范围启动容器"
  echo "2. 查看积分"
  echo "3. 收集密钥对"
  echo "4. 退出"
  echo "5. 关闭未启动的容器"
  read -p "请输入选项 (1/2/3/4/5): " option

  case $option in
    1)
      start_containers
      ;;
    2)
      check_points
      ;;
    3)
      collect_key_pairs
      ;;
    4)
      echo -e "${BLUE}退出程序。${NC}"
      break
      ;;
    5)
      stop_unstarted_containers
      ;;
    *)
      echo -e "${RED}无效的选项，请重新选择。${NC}"
      ;;
  esac
done 