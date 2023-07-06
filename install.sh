#!/bin/bash

# Install Visual Studio Code using Homebrew
brew install --cask visual-studio-code

# Get the installed location of Visual Studio Code
vscode_path=$(mdfind kMDItemCFBundleIdentifier == "com.microsoft.VSCode")

# Check if Visual Studio Code is found
if [ -z "$vscode_path" ]; then
    echo "Visual Studio Code installation not found."
    exit 1
fi

# Move Visual Studio Code to the Applications folder
mv "$vscode_path" /Applications/

# Update permissions
chmod +x /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code

# Detect the shell profile file
shell_profile=""
if [ -f "$HOME/.zshrc" ]; then
    shell_profile="$HOME/.zshrc"
elif [ -f "$HOME/.bashrc" ]; then
    shell_profile="$HOME/.bashrc"
else
    echo "Could not find .zshrc or .bashrc file."
    exit 1
fi

# Add Visual Studio Code to PATH in the detected shell profile file
echo 'export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"' >> "$shell_profile"
echo "Visual Studio Code added to PATH in $shell_profile."

# Source the detected shell profile file to apply changes
source "$shell_profile"

# Display success message
echo "Visual Studio Code installed successfully."

# Install extensions
cat extensions.txt | xargs -L 1 code --install-extension

# Copy settings file
cp settings.json ~/Library/Application\ Support/Code/User/settings.json
echo "VS Code settings copied to the appropriate location."