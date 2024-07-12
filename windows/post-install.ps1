Write-Host "**************************************************" -ForegroundColor Yellow
Write-Host "Software Installation Setup" -ForegroundColor Yellow
Write-Host "**************************************************" -ForegroundColor Yellow
Write-Host ""
Write-Host ""

# Check for Admin, and restart if not admin
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process PowerShell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$env:userprofile\Desktop\script.ps1`"" -Verb RunAs
    exit
}

function Update-Path {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
}

# Ask some variables

$gitUserName = Read-Host "Please enter your Git username"
Write-Host ""
$gitUserEmail = Read-Host "Please enter your Git email"
Write-Host ""
$favoriteColor = Read-Host "What is your favorite color? (blue, green, red)"
Write-Host ""

$gamingApps = @(
    "Mojang.MinecraftLauncher", "Moonsworth.LunarClient", 
    "EpicGames.EpicGamesLauncher", "GOG.Galaxy", "Valve.Steam", 
    "Modrinth.ModrinthApp", "Guru3D.Afterburner", 
    "RazerInc.RazerInstaller", "Nvidia.GeForceExperience", 
    "Discord.Discord"
)

$creativeApps = @(
    "JGraph.Draw", "Adobe.Acrobat.Reader.64-bit", 
    "OBSProject.OBSStudio", "KDE.Kdenlive", "GIMP.GIMP", 
    "Rainmeter.Rainmeter", "Inkscape.Inkscape"
)

$DevApps = @(
    "OpenJS.NodeJS", "Git.Git", "Python.Python.3.11", 
    "Microsoft.DotNet.DesktopRuntime.7", "yt-dlp.yt-dlp", 
    "gnu.wget2", "curl.curl","streamlink.streamlink", 
    "Microsoft.Powershell", "Famatech.AdvancedIPScanner"
)

$essentialApps = @(
    "Microsoft.VisualStudioCode", "Microsoft.WindowsTerminal", "Mozilla.Firefox"
)

$defaultApps = @(
    "9NKSQGP7F2NH", "9N9WCLWDQS5J", "9PF4KZ2VN4W9", "9MT60QV066RP",
    "7zip.7zip", "AnyDeskSoftwareGmbH.AnyDesk", 
    "DeepL.DeepL", "VideoLAN.VLC", "Microsoft.PowerToys", 
    "Oracle.JDK.18", "Nilesoft.Shell", "Bitwarden.Bitwarden", 
    "OpenWhisperSystems.signal", "valinet.ExplorerPatcher", 
    "AdrienAllard.FileConverter", "JanDeDobbeleer.OhMyPosh", 
    "Insomnia.Insomnia", "Element.Element", "Flameshot.Flameshot", 
    "localsend.localsend", "SomePythonThings.WingetUIStore"
)

$otherApps = @(
    "GnuCash.GnuCash", "Garmin.Express",
    "MusicBrainz.Picard", "Balena.Etcher", "VMware.WorkstationPro",
    "Macrodeck.macrodeck", "Jellyfin.JellyfinMediaPlayer",
    "WiresharkFoundation.Wireshark", "Rufus.Rufus", "Brave.Brave", 
    "Google.GoogleDrive", "RaspberryPiFoundation.RaspberryPiImager", "Samsung.DeX", 
    "Samsung.SmartSwitch","Nvidia.CUDA"
)

$pythonPackages = @(
    "selenium", "websockets", "alive_progress", "beautifulsoup4", 
    "chromedriver", "browserist", "pytz", "tqdm", "requests",
    "Markdown", "Future", "Jinja2", "pyautogui", 
    "fastapi", "starlette", "pydantic", "uvicorn[standard]"
)

# Categories
$categories = @("Gaming", "Creative", "Development", "Other", "Default")
$appsToInstall = @()

# Always install essentials
foreach ($app in $essentialApps) {
    $appsToInstall += $app
}

# Ask installation preference
foreach ($category in $categories) {
    Write-Host ""
    $userInput = Read-Host "Would you like to install $category apps? (y/n)"
    Write-Host "" -ForegroundColor Yellow
    if ($userInput -eq 'y') {
        switch ($category) {
            "Gaming" {
                $appsToInstall += $gamingApps
            }
            "Creative" {
                $appsToInstall += $creativeApps
            }
            "Development" {
                $appsToInstall += $DevApps
            }
            "Other" {
                $appsToInstall += $otherApps
            }
            "Default" {
                $appsToInstall += $defaultApps
            }
        }
    }
}


# Install what the user selected
Write-Host ""
Write-Host "Performing installation tasks..." -ForegroundColor Cyan
foreach ($app in $appsToInstall) {
    winget install -h --accept-package-agreements --accept-source-agreements $app
}

Write-Host "**************************************************" -ForegroundColor Green
Write-Host "Installations completed." -ForegroundColor Green
Write-Host "**************************************************" -ForegroundColor Green
Write-Host ""
Write-Host ""

# Install python pip packages
while ($true) {
    Write-Host ""
    $userInput = Read-Host "Would you like to install some pip dependencies? (y/n)"
    if ($userInput -eq 'y') {
        Update-Path
        foreach ($package in $pythonPackages) {
            pip install $package
        }
        Write-Host "Installed Python Packages."
        break
    } elseif ($userInput -eq 'n') {
        Write-Host "Cancelled"
        break
    } else {
        Write-Host "Invalid input. Please enter 'y' for yes or 'n' for no."
    }
}


# Set Windows Spotlight as lock screen
while ($true) {
    Write-Host ""
    $userInput = Read-Host "Would you like to set Windows Spotlight as your lock screen? (y/n)"
    if ($userInput -eq 'y') {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "RotatingLockScreenEnabled" -Value 1
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "RotatingLockScreenOverlayEnabled" -Value 1
        Write-Host "Windows Spotlight has been set as the lock screen."
        break
    } elseif ($userInput -eq 'n') {
        Write-Host "Cancelled"
        break
    } else {
        Write-Host "Invalid input. Please enter 'y' for yes or 'n' for no."
    }
}

# Set Windows Accent color
while ($true) {
    Write-Host ""
    $userInput = Read-Host "Would you like to set the Windows Accent color to $favoriteColor? (y/n)"
    if ($userInput -eq 'y') {
        switch ($favoriteColor.ToLower()) {
            "blue" { $color = 16711680 }
            "green" { $color = 1080336 }
            "red" { $color = 255 }
            # set green as default
            default { $color = 1080336 } 
        }
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "AccentColor" -Value $color
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "AccentColorInactive" -Value $color
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent" -Name "AccentPalette" -Value $color
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Value 1
        Write-Host "Windows Accent color has been set to $favoriteColor, dark mode enabled, and transparency effects activated."
        break
    } elseif ($userInput -eq 'n') {
        Write-Host "Cancelled"
        break
    } else {
        Write-Host "Invalid input. Please enter 'y' for yes or 'n' for no."
    }
}

# Set Windows Terminal config
while ($true) {
    Write-Host ""
    $userInput = Read-Host "Would you like to set Windows Terminal configuration to my personal configuration? (y/n)"
    if ($userInput -eq 'y') {
        $settingsPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
        if (Test-Path $settingsPath) {
            Remove-Item $settingsPath -Force
        }
        $url = "https://raw.githubusercontent.com/CrazyWolf13/dotfiles/main/windows-terminal/settings.json"
        Invoke-WebRequest -Uri $url -OutFile $settingsPath
        Write-Host "Windows Terminal configuration has been reset."
        $regPath = "HKCU:\Software\Nilesoft\Shell\Disable"
        if (-not (Test-Path $regPath)) {
            New-Item -Path $regPath -Force | Out-Null
        }
        Set-ItemProperty -Path $regPath -Name "Taskbar" -Value 1
        Write-Host "Set the RegKey at $regPath\Taskbar to fix Nilesoft-Shell Taskbar."
        break
    } elseif ($userInput -eq 'n') {
        Write-Host "Cancelled"
        break
    } else {
        Write-Host "Invalid input. Please enter 'y' for yes or 'n' for no."
    }
}

# Display seconds in the taskbar clock
while ($true) {
    Write-Host ""
    $userInput = Read-Host "Would you like to activate the seconds display in the taskbar clock? (y/n)"
    if ($userInput -eq 'y') {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSecondsInSystemClock" -Value 1
        Write-Host "The seconds display in the taskbar clock has been activated."
        break
    } elseif ($userInput -eq 'n') {
        Write-Host "Cancelled"
        break
    } else {
        Write-Host "Invalid input. Please enter 'y' for yes or 'n' for no."
    }
}

# Install custom Pwsh profile
while ($true) {
    Write-Host ""
    $userInput = Read-Host "Would you like to install my custom PowerShell profile? (y/n)"
    if ($userInput -eq 'y') {
        $profilePath = "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
        if (-not (Test-Path $profilePath)) {
            New-Item -ItemType File -Path $profilePath -Force
        }
        $content = "iex (iwr https://raw.githubusercontent.com/CrazyWolf13/dotfiles/main/pwsh/Microsoft.PowerShell_profile.ps1).Content"
        Set-Content -Path $profilePath -Value $content
        Write-Host "Custom PowerShell profile has been installed."
        break
    } elseif ($userInput -eq 'n') {
        Write-Host "Cancelled"
        break
    } else {
        Write-Host "Invalid input. Please enter 'y' for yes or 'n' for no."
    }
}

# Set Git configuration
while ($true) {
    Write-Host ""
    $userInput = Read-Host "Would you like to set my custom Git configuration? (y/n)"
    if ($userInput -eq 'y') {
        git config --global user.name $gitUserName
        git config --global user.email $gitUserEmail
        git config --global core.autocrlf input
        git config --global core.editor "code --wait"
        git config --global init.defaultBranch main
        Write-Host "Custom Git configuration has been applied."
        break
    } elseif ($userInput -eq 'n') {
        Write-Host "Cancelled"
        break
    } else {
        Write-Host "Invalid input. Please enter 'y' for yes or 'n' for no."
    }
}


while ($true) {
    Write-Host ""
    $userInput = Read-Host "Would you like to generate a new SSH Key? (y/n)"
    if ($userInput -eq 'y') {
        $sshKeyPath = "$env:USERPROFILE\.ssh\id_ed25519"
        ssh-keygen -t ed25519 -b 1028 -f $sshKeyPath
        $publicKeyPath = "$sshKeyPath.pub"
        $privateKeyPath = $sshKeyPath
        $publicKey = Get-Content $publicKeyPath
        $privateKey = Get-Content $privateKeyPath
        Write-Host "SSH key generated."
        Write-Host "Public Key:"
        Write-Host $publicKey
        Write-Host ""
        Write-Host "Private Key:"
        Write-Host $privateKey
        break
    } elseif ($userInput -eq 'n') {
        Write-Host "Cancelled"
        break
    } else {
        Write-Host "Invalid input. Please enter 'y' for yes or 'n' for no."
    }
}


while ($true) {
    Write-Host ""
    $userInput = Read-Host "Would you like to disable Lockscreen timeout at all? (y/n)"
    if ($userInput -eq 'y') {
        Set-ItemProperty -Path "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\7516b95f-f776-4464-8c53-06167f40cc99\8EC4B3A5-6868-48c2-BE75-4F3044BE88A7" -Name "Attributes" -Value 2
        Write-Host "Lockscreen timeout disabled."
        break
    } elseif ($userInput -eq 'n') {
        Write-Host "Cancelled"
        break
    } else {
        Write-Host "Invalid input. Please enter 'y' for yes or 'n' for no."
    }
}

Write-Host "**************************************************" -ForegroundColor Blue
Write-Host "Automated configuration done, starting with manual tasks " -ForegroundColor Blue
Write-Host "**************************************************" -ForegroundColor Blue
Write-Host ""
Write-Host ""

# Function to process my unautomated tasks
function Invoke-Tasks($tasks) {
    foreach ($task in $tasks) {
        Write-Host ("$($task.description): $($task.url)") -ForegroundColor Cyan
        Write-Host $task.question -ForegroundColor Yellow
        while ($true) {
            $response = Read-Host "Enter 'y' for done, 'n' to skip"
            if ($response -eq 'y') {
                Write-Host "" -ForegroundColor Green
                break
            } elseif ($response -eq 'n') {
                Write-Host "" -ForegroundColor Yellow
                break
            } else {
                Write-Host "Invalid input. Please enter 'y' when done or 'n' to skip." -ForegroundColor Red
            }
        }
    }
}

# Array of program tasks
$programs = @(
    @{description="Veeam Agent for Windows"; url="https://www.veeam.com/de/agent-for-windows-community-edition.html"; question="Have you installed Veeam Agent for Windows?"}
    @{description="Farming Simulator 19"; url="https://eshop.giants-software.com/downloads.php"; question="Have you installed Farming Simulator 19 from CD or Web?"}
    @{description="Corel VideoStudio Pro 2019"; url="Exe in Zip files added to installation Guide on Bookstack"; question="Did you follow the guide to install Corel VideoStudio Pro 2019?"}
    @{description="Office"; url="https://setup.office.com"; question="Have you set up Office via setup.office.com?"}
    @{description="Corsair iCUE"; url="https://www.corsair.com/de/de/s/downloads"; question="Did you download and install Corsair iCUE?"}
    @{description="Roccat Mouse"; url="https://support.roccat.com/s/downloads"; question="Did you download the driver for Roccat Mouse?"}
    @{description="iTunes (NOT Store Version!)"; url="https://support.apple.com/de-ch/HT210384"; question="Have you installed iTunes from the provided link?"}
    @{description="Sideloadly"; url="https://sideloadly.io/"; question="Did you install Sideloadly?"}
    @{description="GFPGAN"; url="https://github.com/CrazyWolf13/auto_gfpgan-installer"; question="Have you set up GFPGAN for Ahnenfotos?"}
    @{description="WinAero Tweaker"; url="https://winaerotweaker.com/"; question="Did you install WinAero Tweaker?"}
    @{description="Nvidia CUDA for Ahnenfotos"; url="https://developer.nvidia.com/cuda-downloads"; question="Is Nvidia CUDA installed for Ahnenfotos?"}
    @{description="ChrisTitusTweaker"; url="irm https://christitus.com/win | iex"; question="Did you run the ChrisTitusTweaker script?"}
    @{description="WSL2"; url="wsl --install -d ubuntu"; question="Is WSL2 installed with Ubuntu?"}
    @{description="Gog: The Settlers"; url=""; question="Have you installed The Settlers from Gog?"}
    @{description="Steam: TimeSpy"; url=""; question="Did you install TimeSpy on Steam?"}
    @{description="Steam: Couterstrike 2"; url=""; question="Is CS 2 installed via Steam?"}
    @{description="Steam: Crosshair V2"; url=""; question="Have you installed Crosshair V2 from Steam?"}
    @{description="EpicGames: Fortnite"; url=""; question="Is Fortnite installed from EpicGames?"}
)

# Array of configuration tasks
$tasks = @(
    @{description="Set Dark Mode and Night Mode at Night Time"; question="Is Dark Mode and Night Mode set for nighttime?"}
    @{description="Connect localsend with devices, enable background service and autostart on login, and set auto-accept"; question="Is localsend connected and configured with auto-accept and autostart?"}
    @{description="Set PWSH as Default env, set WT as default Terminal"; question="Have you set PWSH as Default env and WT as default Terminal?"}
    @{description="Set Energy Settings to 1h and never"; question="Are the Energy Settings configured to 1h and never?"}
    @{description="Activate Windows"; question="Is Windows activated?"}
    @{description="Enable Developer Mode: All except Device Portal and RemoteDesktop to ON"; question="Is Developer Mode enabled with the correct settings?"}
    @{description="Install Drivers of Hardware"; question="Have you installed the Hardware Drivers?"}
    @{description="Install Features: Developer-Mode, Drahtlose Anzeigen, Fax-und Scan, Speicherverwaltung, OpenSSH client, Windows Sandbox, WSL"; question="Are the necessary Features installed?"}
    @{description="Activate CloudSync on ViolentMonkey and uBlock Origin, backup and import FFZ addon"; question="Is CloudSync activated and FFZ addon backed up and imported?"}
    @{description="Add Static entry for 'raw.githubusercontent.com' to windows hosts file"; question="Is the Static entry added to the hosts file?"}
    @{description="Set up Firefox: Sign in and activate sync, Set as default Browser, Configure Extensions, Readd old 7TV Extension, Reconfigure BTTV, 7TV, FFZ, Set 'extensions.pocket.enabled' to false, Sign-Ins, Enable 'Tab audio muting UI control', Set Dark UI and Background Image"; question="Is Firefox set up with the required configurations?"}
    @{description="Vmware Workstation Licensing via Github"; question="Is Vmware Workstation licensed via GitHub?"}
    @{description="Configure Nilesoft Shell with my config from my repository"; question="Is Nilesoft Shell configured https://github.com/CrazyWolf13/dotfiles/blob/main/customisation/nilesoftShell/README.md ?"}
    @{description="Backup and load MusicBrainzPicard Backup file"; question="Is the MusicBrainzPicard backup file loaded?"}
    @{description="Run GeForce Experience to update Graphics Drivers"; question="Did you run GeForce Experience to update the Graphics Drivers?"}
    @{description="Change default 'Change image size' tooltips to percent instead of pixel (IMG Resize by PowerToys)"; question="Is the 'Change image size' tooltip set to percent in PowerToys?"}
    @{description="Start, Connect and Sign into all downloaded App"; question="Have you signed into all Apps?"}
    @{description="Download all Games from Steam, Epic, Gog"; question="Are all Games downloaded from Steam, Epic, and Gog?"}
    @{description="Disable Remote Play on Steam"; question="Is Remote Play disabled on Steam?"}
    @{description="Turn off Notifications in Epic Games"; question="Are Notifications turned off in Epic Games?"}
    @{description="Setup Signal and WhatsApp"; question="Are Signal and WhatsApp set up?"}
    @{description="Sign into Firefox check Settings"; question="Have you signed into Firefox and checked settings?"}
    @{description="Setup Dev Home App"; question="Is the Dev Home App set up?"}
    @{description="Test FireStrike and TimeSpy and set 3DMark the default app for .3dmark-result files"; question="Did you test FireStrike and TimeSpy and set 3DMark as the default app?"}
    @{description="Import GnuCash Files (%APPDATA\gnucash, C:\USER\Documents\GnuCash)"; question="Are the GnuCash Files imported?"}
    @{description="Import VideoStudio Pro Files (2 Directories in Documents Folder)"; question="Did you import the VideoStudio Pro Files?"}
    @{description="Import Call of Duty Settings"; question="Are the Call of Duty Settings imported?"}
    @{description="Import Rainmeter Settings: Copy Layouts Folder from %appdata%/Rainmeter, Copy Skins From Documents Folder"; question="Are the Rainmeter Settings imported?"}
    @{description="Import PowerToys Settings (First Create backup via App then restore)"; question="Did you import the PowerToys Settings?"}
    @{description="Import Farming Sim19 Settings and Worlds"; question="Are the Farming Sim19 Settings and Worlds imported?"}
    @{description="Start up Fortnite and Sign into Account"; question="Have you signed into Fortnite?"}
    @{description="Copy and reimport Fortnite Settings from %localappdata%\FortniteGame\Saved\Config\WindowsClient\"; question="Are the Fortnite Settings reimported?"}
    @{description="Reinstall Video Studio 2021 (Via Zip File added in Software List, Bookstack)"; question="Did you reinstall Video Studio 2021?"}
    @{description="Install Macrodeck, Import Appdata Folder and change IP in config, redo all updates to beta, create taskscheduler tasks"; question="Is Macrodeck installed and configured?"}
    @{description="Install MS Office from setup.office.com: Sign into School and Work Accounts, Open all Notebooks on OneNote, Run updates"; question="Is MS Office installed and configured?"}
    @{description="Install GFPGAN with Batch on Github: Run the Modifier Scripts and test whole GFPGAN stuff. Fix GFPGAN by https://github.com/AUTOMATIC1111/stable-diffusion-webui/issues/13985"; question="Is GFPGAN installed and configured?"}
    @{description="Download VSCode Installer: Additional Tasks (add 'open in vscode' to right click menu), Sign In"; question="Is VSCode installed and configured?"}
    @{description="Install Roccat Swarm: Import Macros and Profiles"; question="Did you install and configure Roccat Swarm?"}
    @{description="Copy Videos, Images and Download Userfolders"; question="Are Videos, Images, and Userfolders copied?"}
    @{description="Install Minecraft Launcher from Microsoft Store: Import .minecraft Folder, Install Modrinth and Import all Data, Import all LunarClient Data: Set up LunarClient, Change Path in .lunarclient/settings/launcher.json"; question="Is the Minecraft Launcher installed and configured?"}
    @{description="Install Veeam Agent for Microsoft Windows: Configure Backup"; question="Is Veeam Agent installed and backup configured?"}
    @{description="Set up TranslucentTB"; question="Is TranslucentTB set up?"}
    @{description="Sign into Adobe online and Download Product"; question="Have you signed into Adobe and downloaded the product?"}
    @{description="Export and reimport Task Scheduler Tasks: Use Microsoft Account Password"; question="Are the Task Scheduler Tasks exported and reimported?"}
    @{description="Change Hardware Clock Sync in Linux Systems if conflicting: sudo timedatectl set-local-rtc 1"; question="Is the Hardware Clock Sync in Linux Systems set?"}
    @{description="Clean Images\Batchs Folder and changed 'Minecraft Survival Backup.bat'"; question="Is the Images\Batchs Folder cleaned and Minecraft Survival Backup.bat changed?"}
    @{description="Sign into Google Drive"; question="Are you signed into Google Drive?"}
    @{description="Configure WingetUI and run Updates, import latest packages file from software list"; question="Is WingetUI configured and updated?"}
    @{description="Setup Modern Flyouts: Disable all except Audio"; question="Is Modern Flyouts set up with only Audio enabled?"}
    @{description="Windows Defender: Turn on all Features"; question="Are all Windows Defender Features turned on?"}
    @{description="Import Autostart Script and put it into C:\Users\tobia\Pictures\Batchs\Autostart.pyw: Create a shortcut to shell:startup"; question="Is the Autostart Script imported and shortcut created?"}
    @{description="Install and Configure ExplorerPatcher"; question="Is ExplorerPatcher installed and configured?"}
    @{description="Explorer: 'Open File Explorer for This PC', Compact View, Show Seconds on Taskbar, Enable Network Sharing, Connect OMV- + Pi-Share with Credentials Manually"; question="Is the Explorer configured with the necessary settings?"}
    @{description="Win Aero Tweaker (File added in bookstack)"; question="Is Win Aero Tweaker configured?"}
    @{description="OO Shutup(file aded in bookstack)"; question="Have you executed OO Shutup with my config?"}
    @{description="Setup Triple Displays: Rainmeter, Set VSCode as Editor, Correct Honeycomb Paths, Background Image, Match Real-life Display orientation, Configure Night-Mode, Set FancyZones Zones, Set accent Color, Set Windows Spotlight as Lockscreen, Disable Lockscreen Timeout via Registry: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\7516b95f-f776-4464-8c53-06167f40cc99\8EC4B3A5-6868-48c2-BE75-4F3044BE88A7, Set Attributes to '2'"; question="Are the Triple Displays set up correctly?"}
    @{description="Add Bluetooth Devices"; question="Are the Bluetooth Devices added?"}
    @{description="Connect Rainmeter WebNowPlaying Redux + Macrodeck "; question="Is Rainmeter + Macrodeck connected to WebNowPlaying Redux?"}
    @{description="Import all Disks and SSDs Data"; question="Are all Disks and SSDs Data imported?"}
    @{description="Stop grouping via Time in Explorer"; question="Is grouping by Time stopped in Explorer?"}
    @{description="Import VMs"; question="Are the VMs imported?"}
    @{description="Set Notepad to start with New Empty Tab instead of opening all ever opened files again"; question="Is Notepad set to start with a New Empty Tab?"}
    @{description="Remove unnecessary autostart-entrys: Taskscheduler, Taskmanager and Services"; question="Are the unnecessary autostart entries removed?"}
    @{description="Run Asus Updater and install Wifi/Bluetooth-PCIE Driver for PCE-AX3000"; question="Did you run the Asus Updater and install the drivers?"}
    @{description="Disable 'Asus Q-Installer' in Bios and delete 'C:\Windows\System32\ASUSUpdateCheck.exe' and 'C:\Program Files (x86)\ASUS\Q-Installer'"; question="Is 'Asus Q-Installer' disabled and the files deleted?"}
    @{description="Set new user Path inside Macrodeck if Windows username changed"; question="Is the new user Path set in Macrodeck?"}
    @{description="Setup Flameshot to use PrtSc and disable snipping tool"; question="Is Flameshot set to use PrtSc and snipping tool disabled?"}
    @{description="Set this inside all Office applications to include fonts on export"; question="Is the setting to include fonts on export configured in Office applications?"}
    @{description="Set VSCode as Editor (C:\Users\tobia\AppData\Local\Programs\Microsoft VS Code)"; question="Did you set VSCode as the editor in Rainmeter any anywhere else?"}
    @{description="Correct Honeycomb Paths"; question="Are the paths corrected in the Honeycomb skin configuration files?"}
    @{description="Set Background Image"; question="Is the background image set to your preference?"}
    @{description="Match Real-life Display Orientation to Windows Orientation"; question="Have you matched the display orientation in Windows to your physical setup?"}
    @{description="Standard applications"; question="Have you set up all standard applications"}
    @{description="Import config files"; question="Have you imported all Config files from 10.10.20.8\omv\dropzone\configs ?"}
    @{description="Clock Fix"; question="Have you fixed the linux clock by running `sudo timedatectl set-local-rtc 1` on any linux that is dualbooted?"}
)

while ($true) {
    $userInput = Read-Host "Would you like to open some helpful screenshots now? (y/n)"
    if ($userInput -eq 'y') {
        Start-Process "https://raw.githubusercontent.com/CrazyWolf13/home-assets/main/windows/assets/screenshot_key.png"
        Start-Process "https://raw.githubusercontent.com/CrazyWolf13/home-assets/main/windows/assets/download_folder_fix.png"
        Start-Process "https://raw.githubusercontent.com/CrazyWolf13/home-assets/main/windows/assets/ChrisTitusWinUtil.png"
        Start-Process "https://raw.githubusercontent.com/CrazyWolf13/home-assets/main/windows/assets/pptx_embed_font.jpg"
        break
    } elseif ($userInput -eq 'n') {
        Write-Host "Cancelled"
        break
    } else {
        Write-Host "Invalid input. Please enter 'y' for yes or 'n' for no."
    }
}


# Process the program tasks
Invoke-Tasks $programs

# Process the configuration tasks
Invoke-Tasks $tasks

# Prompt for reboot
while ($true) {
    Write-Host ""
    $userInput = Read-Host "Would you like to reboot now? (y/n)"
    if ($userInput -eq 'y') {
        Restart-Computer
    } elseif ($userInput -eq 'n') {
        Write-Host "The installation and configuration tasks are complete. Please reboot manually to apply all changes."
        break
    } else {
        Write-Host "Invalid input. Please enter 'y' for yes or 'n' for no."
    }
}


Write-Host "**************************************************" -ForegroundColor Yellow
Write-Host "Installation and Configuration Completed!" -ForegroundColor Yellow
Write-Host "**************************************************" -ForegroundColor Yellow
Write-Host ""
Write-Host ""

