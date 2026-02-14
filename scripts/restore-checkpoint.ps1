param(
  [string]$Commit = ""
)

$ErrorActionPreference = "Stop"

if ([string]::IsNullOrWhiteSpace($Commit)) {
  Write-Host "Provide a commit hash to restore into a new branch."
  Write-Host "Example: npm run restore:branch -- a1b2c3d"
  Write-Host ""
  git log --oneline -n 20
  exit 0
}

git rev-parse --verify $Commit 2>$null | Out-Null
if ($LASTEXITCODE -ne 0) {
  Write-Error "Commit not found: $Commit"
}

$short = (git rev-parse --short $Commit).Trim()
$stamp = Get-Date -Format "yyyyMMdd-HHmmss"
$branchName = "restore/$short-$stamp"

git switch -c $branchName $Commit

if ($LASTEXITCODE -eq 0) {
  Write-Host "Switched to restore branch: $branchName"
  Write-Host "You can inspect and cherry-pick any changes you need."
}
