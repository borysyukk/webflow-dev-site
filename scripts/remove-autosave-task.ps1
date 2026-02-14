param(
  [string]$TaskName = "WebflowDevSite-GitAutosave"
)

$ErrorActionPreference = "Stop"

schtasks /Delete /TN $TaskName /F | Out-Null
Write-Host "Autosave task removed: $TaskName"
