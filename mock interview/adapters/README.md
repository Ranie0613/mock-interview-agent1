# 接入各平台：把本仓库的提示词变成你自己的 Agent

同一份提示词可以装进不同平台。下面按「零代码 → 低代码 → 有代码」排列，任选其一即可。

---

## 1. ChatGPT（GPTs / 自定义指令）

**适用**：有 ChatGPT Plus，想最快拿到一个可分享的链接。

1. 打开 ChatGPT → 左上角「探索 GPT」→「创建」；
2. 在 **Instructions** 框粘贴 `prompts/system_prompt.md` 全文（若提示超长，用 `prompts/system_prompt_compact.md`）；
3. **Conversation starters** 建议填：
   - `开始一场业务面模拟，JD 和简历我马上贴给你`
   - `帮我把上次复盘的短板重点再考一遍`
   - `出一份 30 分钟的压力面`
4. Name 填「秋招模拟面试官」，上传一个头像 → **Save**；
5. 分享：选 `Anyone with the link`，得到 `https://chatgpt.com/g/g-xxxx` 形式的链接。

---

## 2. 扣子 Coze（国内可直接发布到微信/飞书/网页）

**适用**：想给链接给同学用，或想接公众号、飞书。

1. 打开 [coze.cn](https://www.coze.cn) → 「工作空间」→「创建 Bot」；
2. **人设与回复逻辑** 粘贴 `prompts/system_prompt.md`；
3. 模型选 `豆包·1.5 Pro` 或 `DeepSeek-V3`（长提示词遵循度更好）；
4. **开场白**：
   > 我是你的秋招模拟面试官。请把 **简历 + 岗位 JD + 面试类型** 发我，我会先给你一份面试准备摘要，然后开始提问。
5. 需要长期记忆时，在「知识库」上传你的历史复盘报告，并在人设末尾加一句：
   > 回答前先检索知识库中的历史复盘报告，优先考察其中暴露的不足点。
6. 右上角 **发布** → 勾选「Bot 商店 / API / 网页」→ 得到分享链接。

---

## 3. Dify（可自托管，适合做多轮 + 工作流）

**适用**：想要数据私有、或想做成带工作流的正式应用。

1. [cloud.dify.ai](https://cloud.dify.ai) 或自托管 →「创建应用」→ 选 **Chatbot**；
2. **编排 → 提示词** 粘贴 `prompts/system_prompt.md`，变量可留空（由用户对话输入）；
3. 需要「复盘报告存档」闭环时，加两个节点：
   - 开始 → LLM（本提示词）→ 结束
   - 另建一个 **工作流** 应用：输入「复盘报告文本」→ LLM 抽取为结构化 JSON → 写入数据库/表格；
4. 发布 → 「公开访问」得到 `https://udify.app/chat/xxxx` 链接。

---

## 4. 其他国产模型（Kimi / 通义 / 智谱 / DeepSeek 网页版）

没有 Agent 发布能力时，用「智能体 / 提示词」功能即可：

- **Kimi**：左侧「Kimi+」→ 创建自己的 Kimi+ → 粘贴提示词；
- **通义千问**：智能体中心 → 创建智能体 → 角色设定粘贴提示词 → 发布；
- **智谱清言**：智能体 → 创建 → 配置提示词 → 发布得到分享链接；
- **DeepSeek**：无 Agent 发布能力，直接用「系统提示词」或配合本仓库 `index.html` 使用。

---

## 5. 本仓库网页版（自带 UI，最灵活）

见根目录 `index.html`：填入任意 OpenAI 兼容接口的 Base URL / 模型名 / Key 即可运行，无需部署后端。

- 本地用：直接双击打开（部分浏览器限制 `file://` 请求，建议用 `python3 -m http.server` 起本地服务）；
- 公开分享：推到 GitHub → Settings → Pages → Source 选 `Deploy from a branch` / `main` / `/ (root)`，几分钟后得到 `https://<用户名>.github.io/<仓库名>/`。
