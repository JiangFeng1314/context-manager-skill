param(
    [string]$ProjectRoot = (Get-Location).Path
)

$ErrorActionPreference = 'Stop'
$skillRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$templateRoot = Join-Path $skillRoot 'assets'
$contextDir = Join-Path $ProjectRoot '.context'

New-Item -ItemType Directory -Force -Path $contextDir | Out-Null

$files = @{
    'PROJECT_CONTEXT.md' = 'PROJECT_CONTEXT.template.md'
    'DECISIONS.md'       = 'DECISIONS.template.md'
    'OPEN_ITEMS.md'      = 'OPEN_ITEMS.template.md'
    'SOURCE_MAP.md'      = 'SOURCE_MAP.template.md'
    'SESSION_HANDOFF.md' = 'SESSION_HANDOFF.template.md'
}

foreach ($target in $files.Keys) {
    $dst = Join-Path $contextDir $target
    if (-not (Test-Path -LiteralPath $dst)) {
        Copy-Item -LiteralPath (Join-Path $templateRoot $files[$target]) -Destination $dst
        Write-Host "Created $dst"
    } else {
        Write-Host "Kept existing $dst"
    }
}
