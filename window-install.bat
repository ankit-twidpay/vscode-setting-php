@echo off

rem Install Chocolatey (if not already installed)
choco -? >nul 2>&1
if %errorlevel% neq 0 (
    echo Chocolatey is not installed. Installing Chocolatey...
    powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
)

rem Check if Chocolatey installation was successful
choco -? >nul 2>&1
if %errorlevel% neq 0 (
    echo Chocolatey installation failed. Please install Chocolatey manually and re-run the script.
    exit /b 1
)

rem Check if Visual Studio Code is already installed
where code >nul 2>&1
if %errorlevel% equ 0 (
    echo Visual Studio Code is already installed. Skipping installation.
) else (
    rem Install Visual Studio Code using Chocolatey
    choco install vscode -y

    rem Check if Visual Studio Code installation was successful
    where code >nul 2>&1
    if %errorlevel% neq 0 (
        echo Visual Studio Code installation failed. Please install Visual Studio Code manually and re-run the script.
        exit /b 1
    )
)

rem Move Visual Studio Code to the Applications folder
move "%USERPROFILE%\AppData\Local\Programs\Microsoft VS Code" "%ProgramFiles%\Microsoft VS Code"

rem Update permissions
icacls "%ProgramFiles%\Microsoft VS Code\bin\code.cmd" /grant Everyone:F

rem Detect the shell profile file
set "shell_profile="
if exist "%USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" (
    set "shell_profile=%USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
) else if exist "%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" (
    set "shell_profile=%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
) else if exist "%USERPROFILE%\Documents\WindowsPowerShell\profile.ps1" (
    set "shell_profile=%USERPROFILE%\Documents\WindowsPowerShell\profile.ps1"
) else if exist "%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.VSCode_profile.ps1" (
    set "shell_profile=%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.VSCode_profile.ps1"
) else (
    echo PowerShell profile file not found. Creating a new profile file...
    echo # Add Visual Studio Code to PATH >> "%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.VSCode_profile.ps1"
    echo '$env:Path = "%ProgramFiles%\Microsoft VS Code\bin;" + $env:Path' >> "%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.VSCode_profile.ps1"
    set "shell_profile=%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.VSCode_profile.ps1"
)

rem Restart the shell to apply changes
rem powershell.exe -NoProfile -Command "echo Restarting shell...; shutdown /r /t 1"

rem Display success message
echo Visual Studio Code installation completed successfully.

rem Install extensions
for /f "usebackq tokens=*" %%I in ("extensions.txt") do code --install-extension %%I

rem Copy settings file
xcopy /Y settings.json "%APPDATA%\Code\User\settings.json"
xcopy /Y keybindings.json "%APPDATA%\Code\User\keybindings.json"

echo VS Code settings copied to the appropriate location.
