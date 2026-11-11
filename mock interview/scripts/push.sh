#!/usr/bin/env bash
# 一键推送本仓库到你的 GitHub（需先准备 Personal Access Token，权限勾 repo）
# 用法：GITHUB_USER=你的用户名 GITHUB_TOKEN=ghp_xxx ./scripts/push.sh [仓库名]
set -euo pipefail

USER_NAME="${GITHUB_USER:?请先设置 GITHUB_USER}"
TOKEN="${GITHUB_TOKEN:?请先设置 GITHUB_TOKEN（Personal Access Token，勾选 repo 权限）}"
REPO="${1:-mock-interview-agent}"

echo "→ 创建仓库 ${USER_NAME}/${REPO}（若已存在则跳过）"
curl -s -X POST -H "Authorization: Bearer ${TOKEN}" \
  -H "Accept: application/vnd.github+json" \
  https://api.github.com/user/repos \
  -d "{\"name\":\"${REPO}\",\"description\":\"秋招模拟面试 Agent：简历+JD 驱动的多面试官模拟面试与复盘工具\",\"private\":false,\"has_pages\":true}" \
  > /dev/null || true

if [ ! -d .git ]; then
  git init -q
  git branch -M main
fi
git add .
git commit -m "init: 秋招模拟面试 Agent（提示词 + 网页版）" || echo "（无新增改动）"
git remote remove origin 2>/dev/null || true
git remote add origin "https://oauth2:${TOKEN}@github.com/${USER_NAME}/${REPO}.git"
git push -u origin main

echo "→ 开启 GitHub Pages（main / root）"
curl -s -X POST -H "Authorization: Bearer ${TOKEN}" \
  -H "Accept: application/vnd.github+json" \
  "https://api.github.com/repos/${USER_NAME}/${REPO}/pages" \
  -d '{"source":{"branch":"main","path":"/"}}' > /dev/null || echo "（Pages 可能已开启，可到仓库 Settings → Pages 手动确认）"

echo ""
echo "✓ 完成"
echo "  仓库：https://github.com/${USER_NAME}/${REPO}"
echo "  网页：https://${USER_NAME}.github.io/${REPO}/  （Pages 首次构建约需 1-2 分钟）"
