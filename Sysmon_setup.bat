@echo off
echo ************************************************
echo *****   Sysmon Install Script   *****
echo ************************************************
echo ####################PRECHECK####################

:: directory of the install script, has a trailing \
set SCRIPT_DIR=%~dp0

set SYSMON_DIR=C:\ProgramData\sysmon
set SYSMON_CONF=sysmonconfig.xml
set SYSMON_BIN=%SCRIPT_DIR%sysmon_bin

echo.
echo [+] Checking powershell version...
@powershell if ($PSVersionTable.PSVersion.Major -ge 5) { Write-Host " [+] You are running Powershell version $PSVersionTable.PSVersion.Major"} else { Write-Host " [-] Powershell version $PSVersionTable.PSVersion.Major detected, please update to version 5 or above."; exit(1) }
if %errorlevel% NEQ 0 (
	goto end
	)

:: make sure script is ran with admin privileges.
echo.
echo [+] Checking for administrative privileges...

net session >nul 2>&1
if %errorLevel% NEQ 0 (
	echo [-] Please run script with administrative privileges. Script will exit.
	goto end
)

echo.
echo ####################SYSMON####################

sc query sysmon64 >nul
if "%errorlevel%" EQU "0" (
	echo.
	echo [+] Sysmon installed, removing...
	sysmon64.exe -nobanner -u force
	)

echo.
echo [+] Copying sysmon and config...
if not exist %SYSMON_DIR% (
	mkdir %SYSMON_DIR%
	)
pushd %SYSMON_DIR%
xcopy /q/y %SYSMON_BIN%\sysmon64.exe %SYSMON_DIR%
xcopy /q/y %SYSMON_BIN%\%SYSMON_CONF% %SYSMON_DIR%
echo [+] Installing sysmon and applying config...
sysmon64.exe -nobanner -accepteula -i %SYSMON_CONF%
sc failure Sysmon64 actions= restart/10000/restart/10000// reset= 120
echo.

:: ---------------------------------------------------------------------
:: ENABLE The TaskScheduler log
:: ---------------------------------------------------------------------
::
wevtutil sl "Microsoft-Windows-TaskScheduler/Operational" /e:true
::