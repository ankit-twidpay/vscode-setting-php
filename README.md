# Visual Studio Code Setup

This script automates the installation and setup of Visual Studio Code (VS Code) on macOS using Homebrew. It installs VS Code (if you have already please uninstall), moves it to the Applications folder, sets up the PATH, installs recommended extensions, and copies the settings file.

[Coding Standard Doc](https://docs.google.com/document/d/1Sk1SMQ3McLKg96MlHc_lF4AjPeUGLdOkDZmAsXmcGwM/edit?usp=sharing)

## Prerequisites

- Windows: Ensure that you have [Chocolatey](https://chocolatey.org/) installed on your system.
- macOS: Make sure you have [Homebrew](https://brew.sh/) installed on your system.

## Usage (macOS)

1. Make sure you have Homebrew installed on your macOS system. If not, you can install it by following the instructions at [https://brew.sh/](https://brew.sh/).

2. Open Terminal git clone the repo and navigate to the directory.

5. Make the script executable by running the following command:
   ```bash
   chmod +x mac-install.sh
6. Run the script using the following command:
    ```bash
    ./mac-install.sh
7. The script will install VS Code using Homebrew, move it to the Applications folder, add VS Code to the PATH, install the recommended extensions from the extensions.txt file, copy the settings.json file to the appropriate location, and display success messages.

8. After running the script, you can open VS Code by typing code in the terminal.

## Usage (Windows)

1. Windows: Ensure that you have [Chocolatey](https://chocolatey.org/) installed on your system.

2. git clone the repo and navigate to the directory.

3. Run the script using the following command:
    ```bash
    ./window-install.bat
4. Follow the prompts and allow the script to complete the installation and configuration process.

5. Once the script finishes, Visual Studio Code will be installed and ready to use.

## Customisation

1. To customize the list of recommended extensions, edit the extensions.txt file and add or remove the desired extensions.

2. To customize the VS Code settings, edit the settings.json file and specify your desired settings.

## Note

This script assumes you have Homebrew installed and configured on your macOS system.

Review the script and understand the changes it makes to your system before running it.

This script is provided as-is without any warranties. Use it at your own risk 😜.

For more information, please refer to the script's comments and the accompanying shell script file.

## License

This script is released under the MIT License.