# Session Handoff

## What was just done
- 验证 GitHub 仓库 JiangFeng1314/context-manager-skill 内容完整、public、main。
- 将 skill 安装到本机 Codex 并更新全局 AGENTS.md，启用完成。

## What changed
- Codex 可用技能新增 context-manager，全局 AGENTS.md 新增自动上下文规则。

## What remains
- 本地 git 历史与远程不一致、无 origin；install.ps1 目标目录与本机不一致。

## Exact next step
- 在新 Codex 会话中验证 context-manager 会自动初始化其他项目的 .context/；或先决定是否同步本地/远程 git。

## Files to open first
- README.md
- context-manager/SKILL.md

## Known pitfalls / do-not-repeat failures
- install.ps1 写 .agents\skills，但本机 Codex 读 .codex\skills。
- G: 盘 git 会报 dubious ownership，需 git config --global --add safe.directory G:/codex/context-manager-skill。
- 升级审批通道因服务端模型配置错误会拒绝 require_escalated。
