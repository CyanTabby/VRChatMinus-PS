(Get-Host).UI.RawUI.BackgroundColor = 'Black'
(Get-Host).UI.RawUI.ForegroundColor = 'White'
Clear-Host

# Launch VRChat with EasyAntiCheat
Start-Process -FilePath "C:\Program Files (x86)\Steam\steamapps\common\VRChat\start_protected_game.exe" -ArgumentList "--profile=0","--fps=144","--enable-debug-gui","--osc=9000:127.0.0.1:9001"
# You may need to change the VRChat file path if it's installed on a different drive, and optionally modify launch arguments to your liking (list of common options at https://docs.vrchat.com/docs/launch-options)
# Example: Start-Process -FilePath "D:\SteamLibrary\steamapps\common\VRChat\start_protected_game.exe"-ArgumentList "--profile=0","--fps=120","--enable-debug-gui","--enable-sdk-log-levels","--log-debug-levels=API","--osc=9000:127.0.0.1:9001"

# Wait for number of running VRChat processes to change
$ProcessName = 'VRChat'
$NumberOfProcesses = (Get-Process -Name $ProcessName -ErrorAction SilentlyContinue).Count
Write-Host "Waiting for $ProcessName" -NoNewline
while ((Get-Process -Name $ProcessName -ErrorAction SilentlyContinue).Count -eq $NumberOfProcesses) {
    Write-Host '.' -NoNewline -ForegroundColor DarkGray
    Start-Sleep -Milliseconds 250
}

# Force stop EasyAntiCheat process
Stop-Process -Name EasyAntiCheat_EOS -Force
Write-Host "
Killed EasyAntiCheat_EOS.exe" -BackgroundColor Green -ForegroundColor Black
Start-Sleep 5
