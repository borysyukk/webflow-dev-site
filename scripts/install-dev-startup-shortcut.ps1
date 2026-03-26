param(
  [string]$ShortcutName = "WebflowDevSite - Dev Server.lnk"
)

$ErrorActionPreference = "Stop"

$projectDir = (Split-Path -Parent $PSScriptRoot)
$cmdPath = Join-Path $projectDir "start-dev.cmd"

if (-not (Test-Path -LiteralPath $cmdPath)) {
  throw "Missing file: $cmdPath"
}

$startupDir = [Environment]::GetFolderPath("Startup")
$shortcutPath = Join-Path $startupDir $ShortcutName

$wsh = New-Object -ComObject WScript.Shell
$sc = $wsh.CreateShortcut($shortcutPath)
$sc.TargetPath = $cmdPath
$sc.WorkingDirectory = $projectDir
$sc.WindowStyle = 7 # Minimized
$sc.Description = "Start Astro dev server for webflow-dev-site"
$sc.Save()

Write-Host "Installed startup shortcut: $shortcutPath"

