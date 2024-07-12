$architecture = $Env:PROCESSOR_ARCHITECTURE
$wt_filename = "Microsoft.WindowsTerminal_1.20.11381.0_arm64.zip"
$wt_version = "1.20.11381.0"

if ($architecture -eq "AMD64") {
    Write-Host "Architecture: x64 (AMD64)"
} elseif ($architecture -eq "ARM64") {
    Write-Host "Architecture: ARM64"
} else {
    Write-Host "Unknown architecture: $architecture"
}


# Background Tasks to be run after the installation
$backgroundCommands = @(
    "winget source remove msstore",
    "winget install Microsoft.Powershell --accept-package-agreements --accept-source-agreements",
    "winget install git.git --accept-package-agreements --accept-source-agreements"
)
$backgroundScriptBlock = [scriptblock]::Create(($backgroundCommands -join "; "))


# List of URLs with a secondary property for filename
$urls = @{
    "AMD64" = @(
        @{ Url = "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx"; FileName = "Microsoft.VCLibs.x64.14.00.Desktop.appx" },
        @{ Url = "https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.8.6/Microsoft.UI.Xaml.2.8.x64.appx"; FileName = "Microsoft.UI.Xaml.2.8.x64.appx" },
        @{ Url = "https://github.com/microsoft/terminal/releases/download/v1.20.11381.0/Microsoft.WindowsTerminal_1.20.11381.0_8wekyb3d8bbwe.msixbundle"; FileName = "Microsoft.WindowsTerminal_1.20.11381.0_8wekyb3d8bbwe.msixbundle" },
        @{ Url = "https://aka.ms/getwinget"; FileName = "Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" }
    )
    "ARM64" = @(
        @{ Url = "https://aka.ms/Microsoft.VCLibs.arm64.14.00.Desktop.appx"; FileName = "Microsoft.VCLibs.arm64.14.00.Desktop.appx" },
        @{ Url = "https://globalcdn.nuget.org/packages/microsoft.ui.xaml.2.8.6.nupkg"; FileName = "microsoft.ui.xaml.2.8.6.zip" },
        @{ Url = "https://github.com/microsoft/terminal/releases/download/v$wt_version/$wt_filename"; FileName = "$wt_filename" },
        @{ Url = "https://aka.ms/getwinget"; FileName = "Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" }
    )
}


# List of file paths to the downloaded package files
$packagePaths = @{
    "AMD64" = @(
        "Microsoft.VCLibs.x64.14.00.Desktop.appx",
        "Microsoft.UI.Xaml.2.8.x64.appx",
        "Microsoft.WindowsTerminal_1.20.11381.0_8wekyb3d8bbwe.msixbundle",
        "Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
    )
    "ARM64" = @(
        "Microsoft.VCLibs.arm64.14.00.Desktop.appx",
        "microsoft.ui.xaml.2.8.6\tools\AppX\arm64\Release\Microsoft.UI.Xaml.2.8.appx",
        "Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
    )
}


# Initialize the download tasks
$downloadTasks = @()
Add-Type @"
using System;
using System.Net;
using System.Threading.Tasks;

public class WebClientHelper
{
    public static Task DownloadFileTaskAsync(string address, string fileName)
    {
        using (WebClient webClient = new WebClient())
        {
            return webClient.DownloadFileTaskAsync(new Uri(address), fileName);
        }
    }
}
"@

Write-Host "Starting the parallel Downloads"
# Download each file
foreach ($url in $urls[$architecture]) {
    $downloadTasks += [WebClientHelper]::DownloadFileTaskAsync($url.Url, $url.FileName)
}

Write-Host "Waiting for completion..."
[System.Threading.Tasks.Task]::WaitAll($downloadTasks)


# Post-Installation commands
# Execute the custom commands per architecture
if ($architecture -eq "ARM64") {
    Write-Host "Executing ARM64 specific commands"
    Expand-Archive -Path "microsoft.ui.xaml.2.8.6.zip" -DestinationPath "microsoft.ui.xaml.2.8.6"
    # Windows Terminal manuell installieren.
    # DestinationPath is filename without the extension
    Expand-Archive -Path "$wt_filename" -DestinationPath "$($wt_filename.Substring(0, $wt_filename.Length - 4))"
    $wt_destinationPath = "${env:ProgramFiles}\WindowsTerminal"
    Move-Item -Path "$($wt_filename.Substring(0, $wt_filename.Length - 4))\terminal-$wt_version" -Destination $wt_destinationPath
    # Add WT to PATH
    $env:Path += ";$wt_destinationPath"
    [System.Environment]::SetEnvironmentVariable("Path", $env:Path, [System.EnvironmentVariableTarget]::Machine)
    Write-Host "Windows Terminal installed to $wt_destinationPath"
    Start-Process powershell -ArgumentList "-Command wt.exe -p 'Windows Terminal'"

    # Path to wt.exe
    $wtExecutablePath = Join-Path -Path $wt_destinationPath -ChildPath "wt.exe"
    # Pfad zum Startmenü-
    $startMenuPath = [System.Environment]::GetFolderPath("CommonStartMenu")
    # Vollständiger Pfad, wo die Verknüpfung erstellt werden soll
    $linkPath = Join-Path -Path $startMenuPath -ChildPath "Programs\Windows Terminal.lnk"
    # Erstellen der Verknüpfung
    $shell = New-Object -ComObject WScript.Shell
    $shortcut = $shell.CreateShortcut($linkPath)
    $shortcut.TargetPath = $wtExecutablePath
    $shortcut.Save()
    Write-Host "Created a shortcut to Windows Terminal in the Start Menu."

} elseif ($architecture -eq "AMD64") {
    Write-Host "Executing AMD64 specific commands"
    Start-Process powershell -ArgumentList "-Command wt.exe -p 'Windows Terminal'"
}

Write-Host "Install the Packages"
foreach ($file in $packagePaths[$architecture]) {
    Add-AppxPackage $file
    Write-Host "Installed $file"
    Write-Host "\n"
}

Write-Host "Downloads and installation completed successfully."

# Run the following commands in the background and exit the main script
Write-Host "Executing the background commands"
Start-Process -FilePath "powershell.exe" -ArgumentList "-Command $backgroundScriptBlock" -WindowStyle Hidden
[Environment]::Exit(1)
