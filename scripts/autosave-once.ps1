param(
  [string]$Prefix = "chore(autosave):"
)

$ErrorActionPreference = "Stop"

$insideRepo = git rev-parse --is-inside-work-tree 2>$null
if ($LASTEXITCODE -ne 0 -or $insideRepo -ne "true") {
  Write-Error "Not inside a git repository."
}

$lockPath = Join-Path ".git" ".autosave.lock"
if (Test-Path $lockPath) {
  Write-Host "Autosave lock exists. Skipping this run."
  exit 0
}

New-Item -ItemType File -Path $lockPath -Force | Out-Null

try {
  $status = git status --porcelain
  if ([string]::IsNullOrWhiteSpace($status)) {
    Write-Host "No changes detected. Autosave skipped."
    exit 0
  }

  $stamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
  $message = "$Prefix $stamp [skip ci]"

  git add -A
  git commit -m $message | Out-Null

  if ($LASTEXITCODE -eq 0) {
    Write-Host "Autosave commit created: $message"
  } else {
    Write-Host "Autosave commit failed."
    exit 1
  }
}
finally {
  if (Test-Path $lockPath) {
    Remove-Item $lockPath -Force
  }
}
