$ErrorActionPreference = 'Stop'

$packageRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$sourceSkill = Join-Path $packageRoot 'context-manager'
$skillHome = Join-Path $HOME '.agents\skills'
$targetSkill = Join-Path $skillHome 'context-manager'
$codexHome = Join-Path $HOME '.codex'
$agentsFile = Join-Path $codexHome 'AGENTS.md'

if (-not (Test-Path -LiteralPath $sourceSkill)) {
    throw "Cannot find skill folder: $sourceSkill"
}

New-Item -ItemType Directory -Force -Path $skillHome | Out-Null
New-Item -ItemType Directory -Force -Path $codexHome | Out-Null

if (Test-Path -LiteralPath $targetSkill) {
    $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
    $backup = "$targetSkill.backup-$stamp"
    Copy-Item -LiteralPath $targetSkill -Destination $backup -Recurse
    Write-Host "Backed up existing skill to $backup"
    Remove-Item -LiteralPath $targetSkill -Recurse -Force
}
Copy-Item -LiteralPath $sourceSkill -Destination $targetSkill -Recurse
Write-Host "Installed skill to $targetSkill"

$begin = '<!-- context-manager:auto:start -->'
$end = '<!-- context-manager:auto:end -->'
$block = @"
$begin
## Automatic context management

- For every substantive task in any repository, use the `$context-manager` skill at startup and before final handoff.
- Keep durable project facts in the current repository's `.context/` directory; never mix project-specific facts across repositories.
- Current explicit user instructions override stored context. Persist corrections, confirmed decisions, canonical sources, blockers, milestones, and handoff state.
- Do not ask the user to repeat information already present in project context.
$end
"@

$existing = ''
if (Test-Path -LiteralPath $agentsFile) {
    $existing = Get-Content -LiteralPath $agentsFile -Raw
    $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
    Copy-Item -LiteralPath $agentsFile -Destination "$agentsFile.backup-$stamp"
}

$escapedBegin = [regex]::Escape($begin)
$escapedEnd = [regex]::Escape($end)
$pattern = "(?s)$escapedBegin.*?$escapedEnd\s*"
$existing = [regex]::Replace($existing, $pattern, '')

$newContent = ($existing.TrimEnd() + "`r`n`r`n" + $block.Trim() + "`r`n").TrimStart()
Set-Content -LiteralPath $agentsFile -Value $newContent -Encoding utf8
Write-Host "Updated global Codex guidance: $agentsFile"

Write-Host ''
Write-Host 'Installation complete.'
Write-Host 'Restart Codex if the new skill does not appear immediately.'
Write-Host 'Verify in Codex with: /skills'
Write-Host 'Optional explicit test: $context-manager summarize the current project context.'
