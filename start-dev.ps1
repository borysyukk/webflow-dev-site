param(
  [switch]$Host
)

$ErrorActionPreference = "Stop"

Set-Location -LiteralPath $PSScriptRoot

if ($Host) {
  npm run dev -- --host
} else {
  npm run dev
}

