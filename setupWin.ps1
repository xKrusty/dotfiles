# needs to be run as Administrator

# Neovim
New-Item -Force -ItemType SymbolicLink -Path "$env:localappdata/nvim" -Target "./nvim"

# WindowsTerminal
New-Item -Force -ItemType SymbolicLink -Path "$env:localappdata/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json" -Target "./WindowsTerminal/settings.json"

# Powershell
if($PROFILE) {
    New-Item -Force -ItemType SymbolicLink -Path "$env:userprofile/documents/PowerShell/Microsoft.PowerShell_profile.ps1" -Target "./pwsh/Microsoft.PowerShell_profile.ps1"
}
else {
    Write-Host "PowerShell not found. Please install via: winget install -e --id Microsoft.PowerShell"
    Write-Host "If PowerShell is installed create a 'PowerShell' folder inside your Documents folder"
}
