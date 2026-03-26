param(
  [string]$TaskName = "WebflowDevSite - Astro Dev",
  [string]$ProjectDir = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $ProjectDir)) {
  throw "ProjectDir not found: $ProjectDir"
}

$node = (Get-Command node -ErrorAction Stop).Source
$npm = (Get-Command npm -ErrorAction Stop).Source

$action = New-ScheduledTaskAction `
  -Execute $npm `
  -Argument "run dev" `
  -WorkingDirectory $ProjectDir

$trigger = New-ScheduledTaskTrigger -AtLogOn

$settings = New-ScheduledTaskSettingsSet `
  -AllowStartIfOnBatteries `
  -DontStopIfGoingOnBatteries `
  -MultipleInstances IgnoreNew `
  -ExecutionTimeLimit (New-TimeSpan -Hours 0)

Register-ScheduledTask `
  -TaskName $TaskName `
  -Action $action `
  -Trigger $trigger `
  -Settings $settings `
  -Description "Auto-start Astro dev server for webflow-dev-site on login." `
  -User $env:USERNAME `
  -RunLevel Limited `
  -Force | Out-Null

Write-Host "Installed scheduled task: $TaskName"

