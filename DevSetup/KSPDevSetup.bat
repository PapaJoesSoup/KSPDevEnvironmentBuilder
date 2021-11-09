@echo off
rem  This file sets up a fresh Development mode install of KSP from a Steam installation
rem  Change Log:
rem  v1.0  add support for unity 2019.
cd %~dp0
set LCL_DIR=%~dp0

set VERSION=""
set space = " "

set /p GIT_DIR=<"%LCL_DIR%\git_dir.txt"
set /p STEAM_DIR=<"%GIT_DIR%\_LocalDev\steam_dir.txt"
set /p KSP_DIR=<"%GIT_DIR%\_LocalDev\ksp_dir.txt"

@echo: 
@echo     Path tokens:
@echo     - LCL_DIR: %LCL_DIR%
@echo     - STEAM_DIR: %STEAM_DIR%    
@echo     - GIT_DIR: %GIT_DIR%
@echo     - KSP_DIR: %KSP_DIR%
@echo:
@echo   Let's get the version of the existing game...

rem get_versions
set steamVer = ""
for /F "usebackq skip=13 delims=" %%V in ("%STEAM_DIR%\readme.txt") do set "steamVer=%%V" & goto Steamvalue

:Steamvalue
set thisVer = ""
for /F "usebackq skip=13 delims=" %%V in ("%KSP_DIR%\readme.txt") do set "thisVer=%%V" & goto Hasvalue

:Hasvalue
call set VERSION=%%thisVer:Version =%word%%%

@echo     - Steam Version found is:  %steamVer%
@echo     - Dev Version found is: %thisVer%
set /p quit= "  - Do you wish to continue? (Y/N):  "
if /i "%quit%" == "N" ( 
	@echo     - Terminating batch operation without executing Dev Setup...
	goto end 
)

:menu
@echo:
@echo:
@echo     ====================================================
@echo     Main Menu:
@echo:
@echo     1 - Perform all steps...
@echo     2 - Backup existing game folder...
@echo     3 - Remove existing game folder...
@echo     4 - Create new game folder...
@echo     5 - Copy Retail game folder...
@echo     6 - Copy new KSP/Unity assemblies to Dev...
@echo     7 - Copy Dev Debug files to Game folder...
@echo     8 - Copy Game Save and Ships to Game folder...
@echo     9 - Create linked folder...
@echo     X - Quit script  (Do nothing!)
@echo     ====================================================
@echo:
set /p optn= "---> Select option (1 - 9, X):  "
@echo:
@echo     Choice made:  "%optn%"
@echo:

if "%optn%" == "1" ( goto backupGame )
if "%optn%" == "2" ( goto backupGame )
if "%optn%" == "3" ( goto removeGame )
if "%optn%" == "4" ( goto createFolder )
if "%optn%" == "5" ( goto copyGame )
if "%optn%" == "6" ( goto copyAssemblies )
if "%optn%" == "7" ( goto copyDebugFiles )
if "%optn%" == "8" ( goto copyGameSaves )
if "%optn%" == "9" ( goto createLinkedFolder )
if /I "%optn%" == "X" ( goto end )

goto end

:backupGame
@echo: 
@echo     - Backup existing game folder...

@echo: 
pause
@echo: 

@echo     - Backup in progress, please wait...
xcopy /E /Y /Q "%KSP_DIR%\*.*" "%KSP_DIR%_%VERSION%_old\"

@echo     - Backup complete...
@echo: 

if not "%optn%" == "1" ( goto menu )

:removeGame
@echo     - Removing existing game folder...
pause
rmdir /s /q "%KSP_DIR%"
@echo     - Removal complete...
@echo: 
if not "%optn%" == "1" ( goto menu )

:createFolder
@echo     - Creating new game folder...
pause
if not exist "%KSP_DIR%" ( 
	mkdir "%KSP_DIR%" 
	@echo     - Game folder created...
) else (
	@echo     - Game folder exists.  Skipping...
)
@echo:
if not "%optn%" == "1" ( goto menu )

:copyGame
@echo     - Ready to Copy Steam Game to local Game folder...
@echo       from: "%STEAM_DIR%" 
@echo         to: "%KSP_DIR%"
pause
xcopy /E /Y "%STEAM_DIR%\*.*" "%KSP_DIR%\"
@echo     - Copy complete...
@echo:
if not "%optn%" == "1" ( goto menu )

:copyAssemblies
@echo     - Ready to Copy KSP and unity assemblies 
@echo       from: "%KSP_DIR%\KSP_x64_Data\Managed" 
@echo         to: "%GIT_DIR%\_LocalDev\KSPRefs\" folder...
pause
xcopy /E /Y "%KSP_DIR%\KSP_x64_Data\Managed\Assembly-CSharp.dll" "%GIT_DIR%\_LocalDev\KSPRefs\"
xcopy /E /Y "%KSP_DIR%\KSP_x64_Data\Managed\Assembly-CSharp-firstpass.dll" "%GIT_DIR%\_LocalDev\KSPRefs\"
xcopy /E /Y "%KSP_DIR%\KSP_x64_Data\Managed\KSPAssets.dll" "%GIT_DIR%\_LocalDev\KSPRefs\"
xcopy /E /Y "%KSP_DIR%\KSP_x64_Data\Managed\Unity*.dll" "%GIT_DIR%\_LocalDev\KSPRefs\"
xcopy /Y "%KSP_DIR%\readme.txt" "%GIT_DIR%\_LocalDev\KSPRefs\"
@echo     - Copy complete...
@echo:
if not "%optn%" == "1" ( goto menu )

:copyDebugFiles
@echo     - Ready to Copy unity debug files to game folder and set debug mode...
pause
@echo player-connection-debug=1 >> "%KSP_DIR%\KSP_x64_Data\boot.config
copy /Y "%LCL_DIR%\PlayerConnectionConfigFile" "%KSP_DIR%\KSP_x64_Data"
copy /Y "%LCL_DIR%\WindowsPlayer.exe" "%KSP_DIR%\ksp_x64_dbg.exe"
copy /Y "%LCL_DIR%\UnityPlayer.dll" "%KSP_DIR%"
copy /Y "%LCL_DIR%\WinPixEventRuntime.dll" "%KSP_DIR%"
@echo     - Copy complete...
@echo: 
if not "%optn%" == "1" ( goto menu )

:copyGameSaves
@echo     - Ready to Copy ships, Saves and mods to the new game folder.
pause
xcopy /E /Y /D "%KSP_DIR%_%VERSION%_old\GameData\*.*" "%KSP_DIR%\GameData\"
xcopy /E /Y /D "%KSP_DIR%_%VERSION%_old\ships\*.*" "%KSP_DIR%\Ships\"
xcopy /E /Y /D "%KSP_DIR%_%VERSION%_old\saves\*.*" "%KSP_DIR%\saves\"
@echo     - Copy complete...
@echo: 
if not "%optn%" == "1" ( goto menu )

:createLinkedFolder
@echo     - Ready to create the linked folder for debugging...
@echo: 
pause

REM cd /d "%KSP_DIR%"
REM @echo     - Curr Dir:  "%cd%"
REM @echo     - Game Directory:  "%KSP_DIR%"...
REM @echo: 
REM pause

mklink /J "%KSP_DIR%"\KSP_x64_Dbg_Data "%KSP_DIR%"\KSP_x64_Data
@echo     - Linked folder created...
@echo:

:end
cd %~dp0
@echo     - %~dp0
@echo:
@echo     - script complete...
@echo:
pause
