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

# Add Visual Studio Code to PATH
echo 'export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"' >> ~/.zshrc

# Source the .zshrc file to apply changes
source ~/.zshrc

# Display success message
echo "Visual Studio Code installed successfully."

cat extensions.txt | xargs -L 1 code --install-extension

cp setting.json ~/Library/Application\ Support/Code/User/settings.json