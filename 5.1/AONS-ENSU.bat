@echo off

::This code is just for housekeeping. just leave it alone.
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION


::sets "parent" as the directory of AONS-ENSU.bat
SET parent=%~dp0

:: purely cosmetic
TITLE Automated ONScripter-EN Set Up v5.1 EN S U)

:: Dependency check
:: 	unzip.exe
::		if unzip.exe is not found, throw an exception, with a message to the user
::	zip.txt
::		a file named zip.txt that holds the name of the .zip that the user wants to use.
:: 		the contents of zip.txt should be set whenever the user runs the program and a file named zip.txt does not exist in the script directory. 
:: 		This should cover the first time the user runs the program, and hopefully every execution after.

if exist unzip.exe ( 
	echo unzip.exe found && echo:
) else ( 
	echo 'unzip.exe not found, please add unzip.exe to the script directory and try again.'
	echo  && echo continue to exit && pause
)

if exist zipname.txt (
	echo zipname.txt found && echo:
) else (
::	call zipname.bat
	echo no zipname.txt was found in script directory, please exit and add a zipname.txt file to the script directory. This file should contain the name of the .zip file that you wish to use to update your ONScripter-EN games. The file name in zipname.txt CANNOT have spaces in it, and it MUST include the .zip extension.
	echo:
	echo continue to exit && pause && goto :eof
)

set zipname=0
for /f "tokens=1,2" %%G in (zipname.txt) do (set zipname=%%G)
echo %zipname%


:: set game ID
set /p gameID=Please enter the name of the game you wish to update. This name will be added to a game.id file
echo %gameID% > game.id
type game.id

:: set game directory path
set /p wd=Please enter the path to the game directory.

:: copy onsen.zip into game directory
:: 	if onsen.zip cannot be found, throw an excpetion, with a user message
xcopy *.zip %wd%
cd %wd%
mkdir savedata
echo save=%wd%\savedata > ons.cfg
unzip %zipname%
erase %zipname%
echo execution complete!
pause
goto :eof



:: CD into game directory
:: 	make a savedata folder
:: 	create game.id 
:: 	create an ons.cfg
:: 	unzip onsen.zip
::	delete onsen.zip

:: Echo 'AONSEN-SU executed succesfully!'
:: exit cmd window
echo continue to exit && pause && goto :eof
