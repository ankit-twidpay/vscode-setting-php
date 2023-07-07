@echo off

rem Install Visual Studio Code using Chocolatey
choco install vscode -y

rem Check if Visual Studio Code is installed
where code >nul 2>&1
if %errorlevel% neq 0 (
    echo Visual Studio Code installation not found.
    exit /b 1
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
    echo Could not find PowerShell profile file.
    exit /b 1
)

rem Add Visual Studio Code to PATH in the detected shell profile file
echo '$env:Path = "%ProgramFiles%\Microsoft VS Code\bin;" + $env:Path' >> "%shell_profile%"
echo Visual Studio Code added to PATH in %shell_profile%.

rem Restart the shell to apply changes
powershell.exe -NoProfile -Command "echo Restarting shell...; shutdown /r /t 1"

rem Display success message
echo Visual Studio Code installed successfully.

rem Install extensions
for /f "usebackq tokens=*" %%I in ("extensions.txt") do code --install-extension %%I

rem Copy settings file
xcopy /Y settings.json "%APPDATA%\Code\User\settings.json"
xcopy /Y keybindings.json "%APPDATA%\Code\User\keybindings.json"

echo VS Code settings copied to the appropriate location.
