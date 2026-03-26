@echo off
setlocal

REM Start Astro dev server in this project
cd /d "%~dp0"
npm run dev

endlocal
