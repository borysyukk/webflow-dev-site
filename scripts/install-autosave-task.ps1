param(
  [int]$Minutes = 10,
  [string]$TaskName = "WebflowDevSite-GitAutosave"
)

$ErrorActionPreference = "Stop"

if ($Minutes -lt 1) {
  Write-Error "Minutes must be >= 1."
}

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$autosaveScript = Resolve-Path (Join-Path $PSScriptRoot "autosave-once.ps1")

$powershellExe = (Get-Command powershell).Source
$taskCommand = "`"$powershellExe`" -NoProfile -ExecutionPolicy Bypass -File `"$autosaveScript`""

schtasks /Create /SC MINUTE /MO $Minutes /TN $TaskName /TR $taskCommand /F | Out-Null

Write-Host "Autosave task installed."
Write-Host "Task name: $TaskName"
Write-Host "Interval: every $Minutes minute(s)"
Write-Host "Repo: $repoRoot"
Write-Host "Run now: schtasks /Run /TN `"$TaskName`""
