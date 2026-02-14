param(
  [Parameter(ValueFromRemainingArguments = $true)]
  [string[]]$MessageParts
)

$ErrorActionPreference = "Stop"

function Get-CommitMessage {
  if ($MessageParts -and $MessageParts.Count -gt 0) {
    $raw = ($MessageParts -join " ").Trim()
    if ($raw.Length -gt 0) {
      return "checkpoint: $raw"
    }
  }
  $stamp = Get-Date -Format "yyyy-MM-dd HH:mm"
  return "checkpoint: $stamp"
}

$insideRepo = git rev-parse --is-inside-work-tree 2>$null
if ($LASTEXITCODE -ne 0 -or $insideRepo -ne "true") {
  Write-Error "Not inside a git repository."
}

$status = git status --porcelain
if ([string]::IsNullOrWhiteSpace($status)) {
  Write-Host "No changes detected. Nothing to checkpoint."
  exit 0
}

git add -A
$commitMessage = Get-CommitMessage
git commit -m $commitMessage

if ($LASTEXITCODE -eq 0) {
  Write-Host "Created checkpoint: $commitMessage"
}
