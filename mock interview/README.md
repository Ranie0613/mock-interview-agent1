# 秋招模拟面试 Agent

一个**可复用、可分享**的模拟面试 Agent：输入「简历 + 岗位 JD + 面试类型」，它会像真实企业面试一样，由 3–4 位不同风格的面试官交替提问、深挖追问，结束后输出带评分的复盘报告。

> 面向 2027 届秋招求职者设计，也适用于任何需要「面试演练 + 结构化复盘」的求职场景。

---

## 它做什么

| 阶段 | Agent 的动作 |
|---|---|
| 输入校验 | 检查简历、JD、面试类型是否齐全，缺失时一次性指出并给示例 |
| 分析拆解 | 拆简历（经历/能力/风险点）→ 建岗位画像 → 人岗匹配出题目库 → 生成含「人物·地点·时间」的情境题 |
| 模拟面试 | 随机 3–4 位面试官（审判型/引导型/专业型/随缘型/犀利型/刁钻型/亲切和蔼型/笑面虎型/喜欢奉承型），每题标注提问者，同一问题链追问 ≤ 4 轮 |
| 复盘 | 四维评分（内容质量 30% / 结构表达 25% / 深度真实感 25% / 应变心态 20%）、逐题点评引用原话、短板分析、下次训练重点 |

四种面试类型对应真实面试官角色：**专业面**（平级资深专家）、**业务面**（直属上级）、**交叉面**（相关部门负责人）、**HR 面**（部门 HR）。

---

## 三种用法

### 方式一：直接用网页版（零配置部署）

打开 `index.html`（或访问本仓库的 GitHub Pages 地址），在右上角「⚙ 模型设置」填入任意 **OpenAI 兼容** 接口：

| 服务 | Base URL | 模型名示例 | 浏览器直连 |
|---|---|---|---|
| DeepSeek | `https://api.deepseek.com/v1` | `deepseek-chat` | ✅ 已实测可直连 |
| 通义千问 | `https://dashscope.aliyuncs.com/compatible-mode/v1` | `qwen-plus` | ✅ 已实测可直连 |
| Kimi | `https://api.moonshot.cn/v1` | `moonshot-v1-32k` | ✅ 已实测可直连 |
| OpenAI | `https://api.openai.com/v1` | `gpt-4o-mini` | ⚠️ 境内通常不可达，会一直卡在「思考中」 |
| 智谱 | `https://open.bigmodel.cn/api/paas/v4` | `glm-4-plus` | ⚠️ 预检未返回 CORS 头，浏览器会被拦截 |
| 本地 Ollama | `http://localhost:11434/v1` | `qwen2.5:14b` | ✅ 需本机运行并允许跨域 |

> **选接口时先看「浏览器直连」这一列**：页面在浏览器里直接调 API，接口必须允许跨域（CORS）。
> 填了不可达或不允许跨域的地址，会表现为长时间「面试官思考中」。v2 已加 45 秒超时与「测试连接」按钮，
> 但仍建议直接用上面标 ✅ 的接口。

Key 只存在浏览器 localStorage，不经任何中转服务器。面试结束可「导出复盘」下载 Markdown。

### 方式二：粘贴到任意 AI 工具（最快）

把 [`prompts/system_prompt.md`](prompts/system_prompt.md) 全文粘进系统提示词 / 自定义指令 / 智能体人设即可。
有字数限制的平台用精简版 [`prompts/system_prompt_compact.md`](prompts/system_prompt_compact.md)。

### 方式三：发布成平台 Bot（给链接就能用）

ChatGPT GPTs、扣子 Coze、Dify、Kimi+、智谱清言的操作步骤见 [`adapters/README.md`](adapters/README.md)。

---

## 仓库结构

```
mock-interview-agent/
├── index.html                        # 网页版 Agent（单文件，无后端）
├── prompts/
│   ├── system_prompt.md              # 完整版系统提示词（推荐）
│   └── system_prompt_compact.md      # 精简版（平台限长时用）
├── adapters/README.md                # 各平台接入步骤
├── docs/
│   └── 秋招模拟面试Agent定义文档.docx   # 设计规格（含模块说明与模板）
├── scripts/push.sh                   # 一键推送脚本
└── LICENSE
```

---

## 快速开始（本地）

```bash
git clone https://github.com/<你的用户名>/mock-interview-agent.git
cd mock-interview-agent
python3 -m http.server 8080
# 浏览器打开 http://localhost:8080
```

---

## 设计要点

- **提示词即产品**：核心能力全部沉淀在 `prompts/`，不绑定任何平台，换模型不换逻辑；
- **状态可执行**：追问轮次、时间预算、已考/待考维度都是显式状态字段，避免模型跑飞；
- **复盘可累积**：每场输出档案字段（日期/岗位/类型/分数/短板/下次重点），下次把上次报告贴进「训练诉求」即可形成训练闭环。

---

## Roadmap

- [ ] 面试档案导出为 JSON，支持多场次对比曲线
- [ ] 接入语音（TTS 面试官提问 + ASR 转写回答），练真实「口感」
- [ ] 按行业内置 JD 模板库（互联网/金融/快消/国企）

---

## License

MIT，可自由修改与二次分发。仅供个人求职训练，请勿用于任何形式的作弊或商业转售。
