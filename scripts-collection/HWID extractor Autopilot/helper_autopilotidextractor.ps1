Write-Output "Answer Y to all prompts, attention on American keyboard layout!"

# Set Path for drive-letter text file
$filePath = "$env:userprofile\drive_path.txt"

# Read the Drive-Letter from the File:
$driveLetter = Get-Content -Path $filePath 

$driveLetter = $driveLetter.TrimEnd($driveLetter[-1])

# Set the USB drive path
$usbDrivePath = "$driveLetter\Autopilot-Script\"

# Change directory to the USB drive
Set-Location -Path $usbDrivePath  > $null

# Create a directory named HWID in the USB drive
New-Item -ItemType Directory -Path (Join-Path $usbDrivePath "HWID")

# Set location to the created directory
Set-Location -Path ".\HWID"

# Temporarily set the execution policy to allow running scripts
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted

# Check if the script is installed and then run it
Install-Script -Name Get-WindowsAutoPilotInfo

# Run the script and output to AutoPilotHWID.csv
Get-WindowsAutoPilotInfo -OutputFile AutoPilotHWID.csv

# Remove Drive-Letter File
Remove-Item $filePath

# Reset the execution policy to its original state
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Restricted                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       