@echo off
title System Optimizer
color 0a
:menu
cls
echo ==============================
echo      System Optimizer Menu
echo ==============================
echo 1. Clean Temporary Files
echo 2. Disable Startup Programs
echo 3. Defragment Disk
echo 4. Scan and Fix DLL Issues
echo 5. Optimize Visual Effects
echo 6. Scan for Malware
echo 7. Clean Registry (with Backup)
echo 8. Show System Status
echo 9. Exit
echo ==============================
set /p choice=Enter your choice (1-9): 

if %choice%==1 goto clean_temp
if %choice%==2 goto disable_startup
if %choice%==3 goto defrag_disk
if %choice%==4 goto fix_dll
if %choice%==5 goto optimize_visuals
if %choice%==6 goto scan_malware
if %choice%==7 goto clean_registry
if %choice%==8 goto system_status
if %choice%==9 exit
goto menu

:clean_temp
echo Cleaning temporary files...
del /s /q "%temp%\*.*"
del /s /q "C:\Windows\Temp\*.*"
echo Done!
pause
goto menu

:disable_startup
echo Opening startup settings...
start msconfig
echo Please disable unnecessary startup programs manually.
pause
goto menu

:defrag_disk
echo Defragmenting disk...
defrag C: /O
echo Done!
pause
goto menu

:fix_dll
echo Running SFC /scannow...
sfc /scannow
echo Running DISM...
DISM /Online /Cleanup-Image /RestoreHealth
echo Done!
pause
goto menu

:optimize_visuals
echo Optimizing visual effects...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f
echo Done!
pause
goto menu

:scan_malware
echo Starting Windows Defender scan...
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 2
echo Done!
pause
goto menu

:clean_registry
echo Backing up registry...
set backup_file=registry_backup_%date:~-4,4%%date:~-10,2%%date:~-7,2%.reg
reg export "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" %backup_file%
echo Cleaning registry...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /f
echo Done! Backup saved as %backup_file%
pause
goto menu

:system_status
echo Showing system status...
systeminfo | findstr /C:"Total Physical Memory" /C:"Available Physical Memory" /C:"OS Name"
wmic cpu get CurrentClockSpeed,Name
echo Done!
pause
goto menu