# https://github.com/CyanTabby/VRChatMinus-PS

# VRChat's Steam app ID
$AppId = '438100'
$ProcessName = 'VRChat'
# Saves number of already running VRChat processes to a variable
$NumberOfProcesses = (Get-Process -Name $ProcessName -ErrorAction SilentlyContinue).Count

# Gets installation path of Steam (for x64 systems)
$SteamInstallPath = Get-ItemPropertyValue 'HKLM:\SOFTWARE\Wow6432Node\Valve\Steam' 'InstallPath'
# Saves contents of Steam's libraryfolders.vdf (Valve data file) to a variable as a single string
$LibraryFolders = Get-Content $SteamInstallPath\steamapps\libraryfolders.vdf -Delimiter 'delimit me daddy~ UwU'
# RegEx to get the path of the Steam library that VRChat is in (not thoroughly tested yet)
If (-Not ($LibraryFolders -Match "(?s).*path`"\s*?`"(?<librarypath>.*?)`"(?:(?!path).)*$AppId")) {
    Write-Host "Error: Couldn't find Steam library path in libraryfolders.vdf for $ProcessName (AppId: $AppId)" -ForegroundColor Red
    Write-Host "Closing this window in 30 seconds..." -ForegroundColor DarkGray
    Start-Sleep 30
    Exit
}
$LibraryPath = $Matches.librarypath
$CurrentPath = Get-Location

# Creates PowerShell shortcut to VRChatMinus-PS with launch options that are passed to VRChat
$Shortcut = (New-Object -ComObject ("WScript.Shell")).CreateShortcut("$CurrentPath\VRChatMinus-PS.lnk")
$Shortcut.TargetPath = "PowerShell"
# Here's where you can modify or add your preferred launch arguments for VRChat (list of common options at https://docs.vrchat.com/docs/launch-options)
#                                                           |           |           |
# --enable-sdk-log-levels --log-debug-levels=API            V           V           V
$Shortcut.Arguments = " -Command `"& '.\VRChatMinus-PS.ps1' --profile=0 --fps=144 --enable-debug-gui --osc=9000:127.0.0.1:9001`""
$Shortcut.Description = "Launch VRChat and kill the background EAC process"
# Uses provided shortcut icon if it exists, otherwise uses the VRChat icon
If (Test-Path "$CurrentPath\VRChatMinus-PS.ico") {
    $Shortcut.IconLocation = "$CurrentPath\VRChatMinus-PS.ico"
} Else {
    $Shortcut.IconLocation = "$LibraryPath\steamapps\common\VRChat\VRChat.exe"
}
$Shortcut.WorkingDirectory = "$CurrentPath"
$Shortcut.Save()



# Starts VRChat with provided launch arguments if there are any
If ($Args.count -eq '0') {
    Start-Process -FilePath "$LibraryPath\steamapps\common\VRChat\start_protected_game.exe"
} Else {
    Start-Process -FilePath "$LibraryPath\steamapps\common\VRChat\start_protected_game.exe" -ArgumentList "$Args"
}

# Opens new PowerShell window as administrator (required to kill EasyAntiCheat_EOS.exe) with UAC prompt if it's enabled
Start-Process PowerShell -Verb RunAs -ArgumentList "
(Get-Host).UI.RawUI.BackgroundColor = 'Black'
(Get-Host).UI.RawUI.ForegroundColor = 'White'
Clear-Host
Write-Host `"Number of already running $ProcessName processes: $NumberOfProcesses`"
Write-Host `"Waiting for $ProcessName`" -NoNewline
while ((Get-Process -Name $ProcessName -ErrorAction SilentlyContinue).Count -eq $NumberOfProcesses) {
    Write-Host '.' -NoNewline -ForegroundColor DarkGray
    Start-Sleep -Milliseconds 250
}
Stop-Process -Name EasyAntiCheat_EOS -Force
Write-Host '
Killed EasyAntiCheat_EOS.exe' -ForegroundColor Green
Write-Host 'Closing this window in 5 seconds...' -ForegroundColor DarkGray
Start-Sleep 5"
#
