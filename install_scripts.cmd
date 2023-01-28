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

copy enable.cmd c:\Windows\System32\GroupPolicy\Machine\Scripts\Startup\
copy disable.cmd c:\Windows\System32\GroupPolicy\Machine\Scripts\Shutdown\
echo Now go to Computer Configuration\Windows Settings\Scripts(Startup/Shutdown).
echo Double click on Startup, Add, select enable.cmd file.
echo Do the same for Shutdown.
gpedit
echo Done. Try to shutdown your VM

