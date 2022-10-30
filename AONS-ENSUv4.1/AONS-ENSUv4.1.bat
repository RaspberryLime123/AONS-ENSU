@echo off

::This code is just for housekeeping. just leave it alone.
SETLOCAL ENABLEEXTENSIONS


::sets "parent" as the directory of AONS-ENSU.bat
SET parent=%~dp0

::This line sets the title of the command prompt that pops up. purely cosmetic.
TITLE Automated ONScripter-EN Set Up v4.1 (A ONS-EN S U)


call :SubDependencyCheck
::checks for dependencies, prints error message if all four are not present. Doesn't stop you from continuing.


set ONS_N=unset
set dsoundCheck=0
set nonDsoundCheck=0
goto :dsoundCheck

::only executed if no dsound.zip or nondsound.zip is detected.
:setONS_Nmanually
set /p ONS_N=Neither onscripter-en-win32_dsound-20110628.zip nor onscripter-en-win32-20110628.zip is present in the batch folder. Please input the file name (including extension) of the zip file you would like to use to update ONScripter-EN.
goto :unzip

:dsoundCheck
::checks for the the Dsound and nonDsound versions of the update.zip
If EXIST onscripter-en-win32_dsound-20110628.zip ( 
set dsoundCheck=1 & goto :nonDsoundCheck
) else echo dsoundCheck Failed & goto :nonDsoundCheck 

:nonDsoundCheck
if EXIST onscripter-en-win32-20110628.zip (
set nonDsoundCheck=1
) else echo nonDsoundCheck failed

:zipChoiceIFANDIF
::if both update.zip are present, goto zip chioce. If both are not present, will skip to next line
if %dsoundCheck% EQU 1 if %nonDsoundCheck% EQU 1 goto :zipChoice 

if %dsoundCheck% EQU 1 (
    goto :WD
) else if %nonDsoundCheck% EQU 1 (
    goto :WD 
) else echo no ONS-EN.zip detected & goto :setONS_Nmanually


:zipChoice
CHOICE /C DN /M "Select [D] to use DirectSound or [N] to use non DirectSound"

:errorLevelCheck
::only executed after zipChoice is executed.
if %ERRORLEVEL% EQU 1 set ONS_N=onscripter-en-win32_dsound-20110628.zip
if %ERRORLEVEL% EQU 2 set ONS_N=onscripter-en-win32-20110628.zip
goto :WD


:WD
cls
set /p WD=Enter the *FULL* path of the game directory This is the directory where we will create the savedata folder, update onscripter, and create a game.id file 

:WD_CHK
::checks to see if WD ends in a backslash. 
Set WD_CHK=%WD:~-1%
set checkAgainst=\

::this if is all one line because it just wouldn't cooperate otherwise. sorry future me and others.
if %WD_CHK%==%checkAgainst% echo the path you entered as the game directory ends in a backslash (\). This generates errors in the ons.cfg file. Next time, enter a new Game Directory path, that does not end in a trailing backslash (\). & pause & cls & goto :WD else goto :GI

echo.


call :GI
::asks the user to input the name of the game, to set the game.id file.

::checks the GI for 'umineko', case insensitive. if umineko is present, makes sub and dir txt add a png-nsc-mask line to ons.cfg

Set umi=%GI:umineko=%

set umiFound=false
if /I "%umi%" == "%GI%" set umiCheck=a & set umiFound=true 
IF umiFound==false set umiCheck=b



:next
call :SubDirAndTxt
::SubDirAndTXT enters the game directory, creates ons.cfg, a savedata folder in the game directory, 
::and changes the savedata location set in the ons.cfg file
::also creates a game.id file with the game name inside.


call :SubCopy
::Copies %ONS_N% and unzip.exe to %WD%

call :Unzip
::unzips %ONS_N% with unzip.exe


call :CleanUp
::deletes update.zip and unzip.exe

cls
echo A ONS-EN SU v1.0 is now done!
pause
goto :end


::Subroutines (basically functions? maybe?)


::Subroutine "GI"
:GI
set /p GI=Enter the name of the game 
goto :EOF

::Subroutine "CleanUp"
:CleanUp
erase %ONS_N%
if exist onscripter-en-win32-20110628.zip erase onscripter-en-win32-20110628.zip
if exist onscripter-en-win32_dsound-20110628.zip erase onscripter-en-win32_dsound-20110628.zip
erase unzip.exe
goto :EOF

::Subroutine "unzip"
:Unzip
cd %WD%
unzip -o %ONS_N%
goto :EOF

::Subroutine "SubDirAndTxt"
:SubDirAndTxt
cd %WD%

mkdir savedata

cd %WD%

type nul > ons.cfg

echo save=%WD%\savedata > ons.cfg

if "%umiCheck%" == "a" echo png-nsc-mask>>ons.cfg 

type nul > game.id

echo %GI% > game.id
goto :EOF

::Subroutine 'SubCopy'
:SubCopy
cd %parent%

copy "%parent%\%ONS_N%" "%WD%"

copy "%parent%\unzip.exe" "%WD%"
goto :EOF


::Subroutine 'SubDependencyCheck'
:SubDependencyCheck
set /a dependencyCheckSuccess=0+0

if EXIST GPL.txt (
set /a dependencyCheckSuccess=%dependencyCheckSuccess%+1
) else echo GPL.txt not detected

if EXIST README.txt (
set /a dependencyCheckSuccess=%dependencyCheckSuccess%+1
) else echo README.txt not detected

if EXIST unzip license.txt (
set /a dependencyCheckSuccess=%dependencyCheckSuccess%+1
) else echo unzip license not detected

if EXIST unzip.exe (
set /a dependencyCheckSuccess=%dependencyCheckSuccess%+1
) else echo unzip.exe not detected


if %dependencyCheckSuccess% LSS 4 (
    echo not all dependencies are present. please refer to the list above to see what dependencies are missing, and place them in the script folder
    pause
    exit
    )

:end