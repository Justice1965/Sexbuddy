@echo off
REM -- Start Tailscale service if not running
sc query Tailscale | find "RUNNING"
IF ERRORLEVEL 1 net start Tailscale

REM -- Give Tailscale a moment to initialize
timeout /t 5 /nobreak >nul

REM -- Start Flask app via Waitress
start "" python "C:\Users\Justice\sexbuddy\app.py"

REM -- Start Tailscale Funnel in background on port 3000
start "" "C:\Program Files\Tailscale\tailscale.exe" funnel --bg 3000
