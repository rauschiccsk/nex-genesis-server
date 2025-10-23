@echo off
REM Quick cleanup script pre __pycache__ a .pyc subory
REM Pouzi Python script cleanup_pycache.py

echo.
echo ================================================
echo   NEX Genesis Server - Cache Cleanup
echo ================================================
echo.

REM Check if Python script exists
if not exist "scripts\cleanup_pycache.py" (
    echo CHYBA: scripts\cleanup_pycache.py neexistuje!
    echo.
    pause
    exit /b 1
)

REM Activate venv32 if exists
if exist "venv32\Scripts\activate.bat" (
    echo Aktivujem venv32...
    call venv32\Scripts\activate.bat
) else (
    echo Pozor: venv32 nenajdeny, pouzivam system Python
)

echo.
echo Cistim cache subory...
echo.

REM Run cleanup script
python scripts\cleanup_pycache.py

echo.
echo ================================================
echo   Hotovo!
echo ================================================
echo.

pause