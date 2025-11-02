@echo off
setlocal

echo ===============================================================================
echo  Flutter Vibe Coding Environment Setup Script for Windows
echo ===============================================================================
echo.
echo This script will install and configure the necessary tools for Flutter Vibe Coding.
echo It uses the Chocolatey package manager.
echo.

REM 1. Check for Chocolatey
echo [1/6] Checking for Chocolatey...
where choco >nul 2>nul
if %errorlevel% neq 0 (
    echo Chocolatey is not installed. Please install it first by following the
    echo instructions at: https://chocolatey.org/install
    echo After installing Chocolatey, please re-run this script.
    goto :eof
) else (
    echo Chocolatey is already installed.
)
echo.

REM 2. Install Git and Node.js
echo [2/6] Installing Git and Node.js...
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo Installing Git...
    choco install -y git
) else (
    echo Git is already installed.
)

where node >nul 2>nul
if %errorlevel% neq 0 (
    echo Installing Node.js...
    choco install -y nodejs-lts
) else (
    echo Node.js is already installed.
)
echo.

REM 3. Install FVM
echo [3/6] Installing FVM (Flutter Version Manager)...
where fvm >nul 2>nul
if %errorlevel% neq 0 (
    echo Installing FVM...
    choco install -y fvm
) else (
    echo FVM is already installed.
)
echo.

REM 4. Install and configure Flutter SDK via FVM
echo [4/6] Installing and configuring Flutter SDK via FVM...
echo Installing the latest stable version of Flutter. This may take a while...
call fvm install stable
echo.
echo Setting the stable version as the global default...
call fvm global stable
echo.
echo Pre-caching Flutter artifacts...
call fvm flutter precache
echo.
echo Running flutter doctor...
call fvm flutter doctor
echo.

REM 5. Configure Environment Variables
echo [5/6] Configuring environment variables...

set "FVM_FLUTTER_PATH=%USERPROFILE%\fvm\default\bin"
set "DART_PUB_CACHE_PATH=%USERPROFILE%\AppData\Local\Pub\Cache\bin"

echo Adding FVM Flutter path to your user PATH: %FVM_FLUTTER_PATH%
setx PATH "%PATH%;%FVM_FLUTTER_PATH%"

echo Adding Dart pub cache path to your user PATH: %DART_PUB_CACHE_PATH%
setx PATH "%PATH%;%DART_PUB_CACHE_PATH%"

echo.
echo IMPORTANT: Environment variables have been set.
echo You will need to restart your terminal for the changes to take effect.
echo.


REM 6. Install Firebase and Gemini CLI
echo [6/7] Installing Firebase Tools and Gemini CLI...
echo Installing firebase-tools (includes Firebase MCP)...
call npm install -g firebase-tools

echo.

echo Installing @google/gemini-cli...
call npm install -g @google/gemini-cli
echo.

REM 7. Configure Gemini CLI for Dart MCP
echo [7/7] Configuring Gemini CLI for Dart MCP...
set "GEMINI_SETTINGS_DIR=%USERPROFILE%\.gemini"
set "GEMINI_SETTINGS_FILE=%GEMINI_SETTINGS_DIR%\settings.json"

if not exist "%GEMINI_SETTINGS_DIR%" (
    echo Creating directory: %GEMINI_SETTINGS_DIR%
    mkdir "%GEMINI_SETTINGS_DIR%"
)

if not exist "%GEMINI_SETTINGS_FILE%" (
    echo Creating Gemini settings file with Dart MCP configuration...
    echo { "mcp": { "dart": { "command": ["dart", "mcp-server"] } } } > "%GEMINI_SETTINGS_FILE%"
    echo Gemini CLI configured to use Dart MCP server.
) else (
    echo Gemini settings file already exists (%GEMINI_SETTINGS_FILE%).
    echo Please manually verify that it contains the Dart MCP server configuration.
    echo You may need to add this JSON object to your settings file:
    echo "mcp": { "dart": { "command": ["dart", "mcp-server"] } }
)
echo.


echo ===============================================================================
echo  Installation Complete!
echo ===============================================================================
echo.
echo What's next?
echo.
echo 1. **Restart your terminal** to apply the new environment variable settings.
echo 2. In the new terminal, verify the setup by running: `flutter doctor`
echo 3. Authenticate the Gemini CLI: `gemini auth login`
echo 4. Install the Firebase extension for Gemini CLI: `gemini extensions install firebase`
echo 5. Verify MCP server availability:
echo    - For Dart: `dart mcp-server --help`
echo    - For Firebase: `firebase mcp --help`
echo.
echo Happy Vibe Coding!
echo.

endlocal
