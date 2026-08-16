# Decisions

<!-- Newest first. Record only material decisions. -->

## 2026-08-16 — 本机安装位置改为 .codex\skills
- Decision: 将 skill 安装到 C:\Users\37350\.codex\skills\context-manager，而非 install.ps1 默认的 .agents\skills。
- Why: 本机 Codex 的技能根目录是 .codex\skills，.agents 目录不存在且不在扫描范围内。
- Replaces: none
- Affects: 本机启用方式；仓库内 install.ps1 未改动。

## 2026-08-16 — 本地提交作者邮箱
- Decision: 本地 commit 使用 GitHub noreply 邮箱 194370882+JiangFeng1314@users.noreply.github.com。
- Why: 从 GitHub 连接器确认了用户 id=194370882，避免使用不存在的 noreply 邮箱。
- Replaces: none
- Affects: 本地 git 提交元数据。
