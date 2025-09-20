@echo off
title Sexbuddy App
cd /d C:\Users\Justice\sexbuddy

echo Starting Flask app with Waitress...
start "" /B python app.py

echo Starting Tailscale Serve on port 3000...
:retry
"C:\Program Files\Tailscale\tailscale.exe" serve 3000
if %errorlevel% neq 0 (
    echo Tailscale crashed, retrying in 5 seconds...
    timeout /t 5 >nul
    goto retry
)

echo All services started.
pause
