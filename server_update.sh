#!/bin/bash

set -e  # 出错即退出

# 默认值
DEFAULT_TAR_FILE="/home/ubuntu/public.tar.gz"
DEFAULT_WEB_DIR="/usr/share/nginx/html"

# 参数解析：使用传入参数或默认值
TAR_FILE="${1:-$DEFAULT_TAR_FILE}"
WEB_DIR="${2:-$DEFAULT_WEB_DIR}"

echo "使用压缩包: $TAR_FILE"
echo "目标目录: $WEB_DIR"

# 检查压缩文件是否存在
if [ ! -f "$TAR_FILE" ]; then
  echo "错误：压缩文件 $TAR_FILE 不存在"
  exit 1
fi

# 删除目标目录下所有内容（保护性地引用变量）
echo "清空目录 $WEB_DIR ..."
sudo rm -rf "${WEB_DIR:?}/"*

# 解压压缩包到目标目录，去除 public/ 顶级目录
echo "解压 $TAR_FILE 到 $WEB_DIR ..."
sudo tar -xzvf "$TAR_FILE" -C "$WEB_DIR" --strip-components=1

echo "✅ 更新完成"