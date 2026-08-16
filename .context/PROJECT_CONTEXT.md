# Project Context

## Project
- Name: context-manager-skill
- Repository/workspace: G:\codex\context-manager-skill

## Primary objective
- 将 context-manager Codex Skill 发布为独立公开 GitHub 仓库，并在本机 Codex 启用。

## Current phase
- 已完成：GitHub 发布验证通过 + 本机 Codex 安装启用完成。

## Confirmed facts
- GitHub 仓库 JiangFeng1314/context-manager-skill 已存在：public、默认分支 main。
- 远程 main 最新 commit: 3788f543a40e4aa735cc01c8317a3449b943ded4。
- 远程 12 个必需文件全部存在（README.md、install.ps1、.gitignore、context-manager/ 9 个文件）。
- 本机 Skill 已安装到 C:\Users\37350\.codex\skills\context-manager（9 个文件齐全）。
- 全局 C:\Users\37350\.codex\AGENTS.md 已加入 context-manager:auto 指令块（第 583–590 行）。
- Codex 可用技能列表已包含 context-manager。

## Constraints and conventions
- 只修改当前仓库，不碰其他项目。
- 不创建 PR/Issue，不上传 skill_archive.zip。
- GitHub 目标分支为 main（非 master），避免 force-push。
- 本机 Codex 从 .codex\skills 加载技能（不是 .agents\skills）。

## Current workflow
1. 从 skill_archive.zip 解包并整理为仓库根结构。
2. git init、切到 main 分支、本地 commit。
3. 验证 GitHub 仓库内容与默认分支。
4. 将 skill 复制到 C:\Users\37350\.codex\skills\context-manager 并更新全局 AGENTS.md。
5. 清理临时脚本。

## Key artifacts
- README.md — 安装与使用说明
- install.ps1 — 安装脚本（注意：目标为 .agents\skills）
- context-manager/SKILL.md — 技能主体
- context-manager/agents/openai.yaml — 隐式调用配置
- C:\Users\37350\.codex\AGENTS.md — 全局自动上下文规则

## Validation / definition of done
- GitHub 远程 12 个文件回读 PASS，默认分支 main。
- Codex 可用技能列表出现 context-manager。
- 全局 AGENTS.md 含 context-manager:auto 块。

## Current status
- 发布：完成。
- 启用：完成。
- 遗留：本地 git 历史与远程不一致、本地无 origin。
