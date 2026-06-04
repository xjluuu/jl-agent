@echo off
setlocal EnableExtensions
cd /d "%~dp0"

set "NO_PAUSE=0"
if /I "%~1"=="--no-pause" set "NO_PAUSE=1"

echo ============================================
echo   JL-Agent offline wheels preparation
echo ============================================
echo.

python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python was not found. Install the same Python version used on company PCs.
    goto fail
)

if not exist wheels mkdir wheels

echo [1/1] Downloading wheels into .\wheels ...
python -m pip download -d wheels pyinstaller rich prompt_toolkit requests openpyxl pymupdf
if errorlevel 1 (
    echo [ERROR] Download failed. Check network or pip source.
    goto fail
)

echo.
echo Done. Copy this IVBD folder to the company PC, then run build_xjlagent_exe.bat.
goto ok

:fail
call :pause_if_needed
exit /b 1

:ok
call :pause_if_needed
exit /b 0

:pause_if_needed
if "%NO_PAUSE%"=="0" pause
exit /b 0
