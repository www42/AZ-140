# Latest version installed?
winget --version
$latest = (Invoke-RestMethod "https://api.github.com/repos/microsoft/winget-cli/releases/latest").tag_name
$latest

# Upgrade winget - Run Windows PowerShell as administrator
winget upgrade Microsoft.AppInstaller  # --> Reboot?
winget --version

# Install packages - Run Windows PowerShell as administrator
$packages = @(
    "Git.Git",
    "Microsoft.Bicep",
    "Microsoft.AzureCLI",
    "Microsoft.PowerShell",
    "Microsoft.VisualStudioCode"
)

foreach ($pkg in $packages) {
    Write-Host "Installing $pkg ..." -ForegroundColor Cyan
    winget install --id $pkg --exact --silent --accept-package-agreements --accept-source-agreements
}

# Reload PATH variable
Write-Host "Refreshing PATH ..." -ForegroundColor Cyan
$env:PATH = [System.Environment]::GetEnvironmentVariable("PATH", "Machine") + ";" +
            [System.Environment]::GetEnvironmentVariable("PATH", "User")


# Install VS Code extensions - *NO* administrator
$extensions = @(
    "ms-vscode.powershell",
    "ms-vscode.azurecli",
    "ms-azuretools.vscode-bicep",
    "redhat.vscode-yaml",
    "eriklynd.json-tools",
    "tomoki1207.pdf"
)

foreach ($ext in $extensions) {
    Write-Host "Installing Extension $ext ..." -ForegroundColor Cyan
    $env:NODE_NO_WARNINGS = "1"
    code --install-extension $ext --force
}

# Create keyboard shortcut
#   `Ctrl-K Ctrl-S` -> `Run Selected Text in Active Terminal` -> F8


# Useful user settings
#   `Ctrl-Shift-P` -> Preferences: `Open User Settings (JSON)`

{
    "editor.minimap.enabled": false,
    "editor.occurrencesHighlight": "off",
    "editor.selectionHighlight": false,
    "editor.inlineSuggest.enabled": true,
    "explorer.openEditors.visible": 1,
    "powershell.codeFolding.enable": true,
    "powershell.codeFolding.showLastLine": false,
    "powershell.codeFormatting.useCorrectCasing": true,
    "powershell.integratedConsole.showOnStartup": false,
    "powershell.promptToUpdatePowerShell": false,
    "powershell.scriptAnalysis.enable": false,
    "terminal.integrated.cursorBlinking": true,
    "terminal.integrated.cursorStyle": "block",
    "terminal.integrated.cursorWidth": 2,
    "terminal.integrated.defaultProfile.windows": "PowerShell",
    "terminal.integrated.shellIntegration.enabled": true,
    "window.commandCenter": false,
    "window.zoomLevel": 1,
    "workbench.colorCustomizations": {
        "editor.findMatchBackground": "#E8A23580",
        "editor.findMatchBorderColor": "#E8A235",
        "editor.findMatchHighlightBackground": "#E8A23540",
        "editor.findMatchHighlightBorderColor": "#E8A23580"
    },
    "workbench.startupEditor": "none",
    "workbench.tree.indent": 20
}

# Install Modules (this takes some time ☕)
$modules = @(
    "Az",
    "Microsoft.Entra",
    "Microsoft.Graph"
)

foreach ($mod in $modules) {
    Write-Host "Installing Module $mod ..." -ForegroundColor Cyan
    Install-Module $mod -Force -AllowClobber -Scope CurrentUser
}

Get-Module -ListAvailable az,microsoft.entra,microsoft.graph