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

echo [1/7] Checking core build dependencies...
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

echo [2/7] Running source self-check...
python xjlagent.py --self-check
if errorlevel 1 (
    echo [ERROR] Source self-check failed.
    goto fail
)

echo [3/7] Running permission and handoff checks...
python xjlagent.py --permission-check
if errorlevel 1 (
    echo [ERROR] Permission matrix check failed.
    goto fail
)
python xjlagent.py --exe-check
if errorlevel 1 (
    echo [ERROR] EXE readiness check failed.
    goto fail
)
if exist tests\offline_smoke.py (
    python tests\offline_smoke.py
    if errorlevel 1 (
        echo [ERROR] Offline smoke test failed.
        goto fail
    )
)

echo [4/7] Building EXE. This may take several minutes...
python -m PyInstaller --clean --noconfirm xjlagent.spec
if errorlevel 1 (
    echo [ERROR] PyInstaller build failed.
    goto fail
)

echo [5/7] Running EXE self-check...
if not exist dist\xjlagent.exe (
    echo [ERROR] dist\xjlagent.exe was not created.
    goto fail
)
dist\xjlagent.exe --self-check
if errorlevel 1 (
    echo [ERROR] EXE self-check failed.
    goto fail
)

echo [6/7] Running EXE permission and handoff checks...
dist\xjlagent.exe --permission-check
if errorlevel 1 (
    echo [ERROR] EXE permission check failed.
    goto fail
)
dist\xjlagent.exe --exe-check
if errorlevel 1 (
    echo [ERROR] EXE readiness check failed.
    goto fail
)
dist\xjlagent.exe --onboarding

echo [7/7] Done.
echo.
echo ============================================
echo   EXE:
echo   %cd%\dist\xjlagent.exe
echo.
echo   Runtime config path:
dist\xjlagent.exe --config-path
echo.
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
