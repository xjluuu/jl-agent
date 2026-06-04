@echo off
setlocal EnableExtensions
cd /d "%~dp0"

set "NO_PAUSE=0"
if /I "%~1"=="--no-pause" set "NO_PAUSE=1"

echo ============================================
echo   JL-Agent company EXE build
echo ============================================
echo.

python --version >nul 2>&1
if errorlevel 1 goto no_python

echo [1/5] Checking core build dependencies...
python -c "import PyInstaller, requests, rich, prompt_toolkit, openpyxl" >nul 2>&1
if errorlevel 1 (
    if exist wheels (
        echo [INFO] Installing core dependencies from local wheels...
        python -m pip install --no-index --find-links=wheels pyinstaller rich prompt_toolkit requests openpyxl
    ) else (
        echo [ERROR] Missing core dependencies and no local wheels folder was found.
        echo         Prepare wheels on an online PC, or install these packages first:
        echo         pyinstaller rich prompt_toolkit requests openpyxl
        goto fail
    )
)
python -c "import PyInstaller, requests, rich, prompt_toolkit, openpyxl" >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Core dependency check failed.
    goto fail
)

python -c "import fitz" >nul 2>&1
if errorlevel 1 (
    if exist wheels (
        echo [INFO] Optional PDF dependency PyMuPDF is missing; trying local wheels...
        python -m pip install --no-index --find-links=wheels pymupdf
    ) else (
        echo [WARN] Optional PDF dependency PyMuPDF is missing. PDF parsing will warn in self-check.
    )
)

echo [2/5] Running source self-check...
python xjlagent.py --self-check
if errorlevel 1 (
    echo [ERROR] Source self-check failed.
    goto fail
)

echo [3/5] Building EXE. This may take several minutes...
python -m PyInstaller --clean --noconfirm xjlagent.spec
if errorlevel 1 (
    echo [ERROR] PyInstaller build failed.
    goto fail
)

echo [4/5] Running EXE self-check...
if not exist dist\xjlagent.exe (
    echo [ERROR] dist\xjlagent.exe was not created.
    goto fail
)
dist\xjlagent.exe --self-check
if errorlevel 1 (
    echo [ERROR] EXE self-check failed.
    goto fail
)

echo [5/5] Done.
echo.
echo ============================================
echo   EXE:
echo   %cd%\dist\xjlagent.exe
echo.
echo   Default company config:
echo   D:\jlagent\myagent_config.json
echo.
echo   If D: is unavailable, self-check shows the fallback config path.
echo   API URL, model, and key can be changed in JSON without rebuilding.
echo ============================================
goto ok

:no_python
echo [ERROR] Python 3.9+ was not found. Install Python and retry.
goto fail

:fail
call :pause_if_needed
exit /b 1

:ok
call :pause_if_needed
exit /b 0

:pause_if_needed
if "%NO_PAUSE%"=="0" pause
exit /b 0
