# VRChatMinus PS script
This is a PowerShell script based on the concept of the original [VRChatMinus](https://github.com/Koyoinu/VRChat-Minus).
### What's the difference?
This version:
* Doesn't require you to force close and restart Steam every time you launch VRChat (due to Steam thinking the game is still running)
* Accepts launch options and passes them through to VRChat
* Allegedly doesn't break video players with certain links <!--why?-->

# Setup
1. Download the files [here](https://github.com/CyanTabby/VRChatMinus-PS/archive/refs/heads/main.zip) or by clicking the green `<> Code` button then `Download ZIP`
2. Extract `VRChatMinus-PS-main.zip`
3. Allow local PowerShell scripts to run without being signed. You can find this in Windows settings by searching for "scripts" (:warning:Never run untrusted scripts:warning:)
4. (Optional) Modify or add your preferred VRChat launch options in `VRChatMinus-PS.ps1` with any text editor
5. Right click on `VRChatMinus-PS.ps1` and select `Run with PowerShell` to test run the script and generate a shortcut
6. Move the shortcut wherever you want (desktop, taskbar, start menu, etc.)

# Usage
1. Open the shortcut

# Notes
* If you just installed/relocated VRChat you may need to restart Steam for the game library location in `libraryfolders.vdf` to update
* If the location of `VRChatMinus-PS.ps1` changes you may need to generate a new shortcut the same way as in step 5 of [Setup](https://github.com/CyanTabby/VRChatMinus-PS#setup)
* If you want the shortcut icon to be VRChat then just delete `VRChatMinus-PS.ico` and a new shortcut will be created next time it's run
* If you want to change the launch options for a specific shortcut then right click it, go to Properties, and you'll find them at the end of Target (be sure to leave the double quotes at the end)
###### Fun fact: I wrote this (with VR controllers) mainly just for practice with PowerShell and GitHub repos
<!-- TODO:
compare launch speed and in-game performance to original and baseline
-->
