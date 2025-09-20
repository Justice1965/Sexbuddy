# -------------------------------
# Fully automated setup for sexbuddy-app service with NSSM + Waitress
# -------------------------------

# Paths
$serviceName = "sexbuddy-app"
$batFile = "C:\Users\Justice\sexbuddy\run_sexbuddy.bat"
$appFile = "C:\Users\Justice\sexbuddy\app.py"
$logOut = "C:\Users\Justice\sexbuddy\sexbuddy-out.log"
$logErr = "C:\Users\Justice\sexbuddy\sexbuddy-err.log"

# 1️⃣ Stop and remove existing service if it exists
try {
    Write-Host "Stopping and removing existing service (if any)..."
    nssm stop $serviceName -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 2
    nssm remove $serviceName confirm
} catch {
    Write-Host "No existing service to remove."
}

# 2️⃣ Clear logs
Write-Host "Clearing old logs..."
Set-Content -Path $logOut -Value ""
Set-Content -Path $logErr -Value ""

# 3️⃣ Create .bat wrapper to run app.py
Write-Host "Creating batch wrapper..."
$batContent = "@echo off`npy -3.13 `"$appFile`""
Set-Content -Path $batFile -Value $batContent
Write-Host "Wrapper created at $batFile"

# 4️⃣ Install the service with NSSM
Write-Host "Installing NSSM service..."
nssm install $serviceName $batFile

# 5️⃣ Set stdout/stderr logs
Write-Host "Configuring logs for service..."
nssm set $serviceName AppStdout $logOut
nssm set $serviceName AppStderr $logErr

# 6️⃣ Start the service
Write-Host "Starting service..."
nssm start $serviceName
Start-Sleep -Seconds 3

# 7️⃣ Check status
$status = nssm status $serviceName
Write-Host "`nService status: $status"

# 8️⃣ Tail last 20 lines of stdout log
Write-Host "`n--- Last 20 lines of sexbuddy-out.log ---`n"
Get-Content $logOut -Tail 20
