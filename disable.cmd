@echo off & setlocal

:: Check if the current session is already elevated.
:: `net session` only succeeds in elevated sessions.
net session >NUL 2>&1 && goto :ELEVATED

:: Getting here means that we must reinvoke with elevation.
:: Add -Wait before -Verb RunAs to wait for the reinvocation to exit.
set ELEVATE_CMDLINE=cd /d "%~dp0" ^& "%~f0" %*
powershell.exe -noprofile -c Start-Process -Verb RunAs cmd.exe \"/k $env:ELEVATE_CMDLINE\"
exit /b %ERRORLEVEL%

:: Getting here means that we are (now) running with elevation.
:ELEVATED

echo === Running in elevated session:
pnputil /disable-device "PCI\VEN_10DE&DEV_1C03&SUBSYS_85E11043&REV_A1\4&12829b10&0&0014"
pnputil /disable-device "HDAUDIO\FUNC_01&VEN_10DE&DEV_0084&SUBSYS_104385E1&REV_1001"
pnputil /disable-device "USB\VID_0955&PID_9000"
pnputil /disable-device "ROOT\NVVHCI"
timeout 1 >nul

