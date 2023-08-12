@echo off

::This code is just for housekeeping. just leave it alone.
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION


::sets "parent" as the directory of AONS-ENSU.bat
SET parent=%~dp0

:: purely cosmetic
TITLE Automated ONScripter-EN Set Up v4.1 (A ONS-EN S U)

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
echo  && echo continue to exit && pause )
::exit


:: zip check
:: 	as of this writing, the old kaisernet.org link is down, and the builds we used to use are listed as "historical builds." Now, this program will check for the most recent builds of onani and ONSEN (from GP_park32 and Galladtie27 respectively)
:: 		if there is no zip.txt, throw an exception, with a message to the user

:: Didn't want to "call :zipchoice" but I didn't have a choice. the if statement kept throwing '(' not expected errors. It must've beens something about the complexity 
::	and length of the block inside the if statement. It just did not want to work.
set zipname=0
echo zipname = %zipname%
if not exist zipname.txt  (echo zipname.txt DNE && call :zipchoice1) else (
	for /f "tokens=1,2 delims=" %%G in (zipname.txt) do (echo g=%%G && set zipname=%%G && echo zipname=%zipname% )
)
for /f "tokens=1,2 delims=" %%G in (zipname.txt) do (echo g=%%G && set zipname=%%G && echo zipname=%zipname%)
if not exist %zipname% echo %zipname% not found, please add %zipname% to the script directory, or if you've changed or renamed the .zip file, edit the zipname.txt to reflect your changes && echo continue to exit && pause && exit
:: set game ID
:: 	check for umineko

:: set game directory path

:: copy onsen.zip into game directory
:: 	if onsen.zip cannot be found, throw an excpetion, with a user message

:: CD into game directory
:: 	make a savedata folder
:: 	create game.id 
:: 	create an ons.cfg
:: 	unzip onsen.zip
::	delete onsen.zip

:: Echo 'AONSEN-SU executed succesfully!'
:: exit cmd window
echo continue to exit && pause && goto :eof

:zipchoice1
	echo:
	echo -zipchoice1-
	set "onsen-old-sdl-zip=0"
	set "onsen-old-zip=0"
	set "no-zip-err-msg1=Neither onscripter-en-win32_dsound-20110628.zip nor onscripter-en-win32-20110628.zip are present in the zip directory. Please add at least one of the two .zip files to the script directory."
	set "no-zip-err-msg2=If the .zip file you want to use to update your ONScritper-EN games is not one one of the two listed above, please create a file named zipname.txt, and add the *exact* name of the .zip file, with the .zip extension to it. The file must be one line, and the .zip file must have no spaces in it's name for this to work"
	echo vars set
:: 	look for the 20110628 onscripter builds
	if exist onscripter-en-win32_dsound-20110628.zip (set onsen-old-sdl-zip=1 && echo onsen found) else (echo onsen-old-sdl-zip not found)
	if exist onscripter-en-win32-20110628.zip (set onsen-old-zip=1 && echo onsen-dsound found) else (echo onsen-old-zip not found)

	if %onsen-old-zip% EQU 0 ( echo onsen-old EQU 0  passed  
		if %onsen-old-sdl-zip% EQU 0 (echo onsen-old-sdl EQU 0 passed && set "no-zip=1" ) else (echo exiting -zipchoice1- && set zipname=onscripter-en-win32_dsound-20110628.zip && echo %zipname% > zipname.txt && exit /b) 
	) else (echo exiting -zipchoice1- && set zipname=onscripter-en-win32-20110628.zip && echo %zipname% > zipname.txt && exit /b) 
	if %onsen-old-sld-zip% EQU 0 ( echo echo onsen-old-sdl EQU passed, second if 
		if %onsen-old% EQU 1 (echo exiting -zipchoice1- && set zipname=onscripter-en-win32-20110628.zip && echo %zipname% > zipname.txt && exit /b)
	)
	if %no-zip% EQU 1 ( echo %no-zip-err-msg1% &&  echo %no-zip-err-msg2% && echo: && echo continue to exit && pause && exit)

::	if both builds are found, ask user to choose between the two
	if %onsen-old-sdl-zip% EQU 1 (call :zipchoice2)
	exit /b
:zipchoice2
		echo:
		echo -zipchoice2-
		echo onsen-old-zip = %onsen-old-zip%
		if %onsen-old-zip%==1 ( echo onsen-old-zip if passed. && call :zipchoice3)
		exit /b
:zipchoice3
	echo:
	echo -zipchoice3-
			set /p choice="Select [1] to use onscripter-en-win32_dsound-20110628.zip or [2] to use onscripter-en-win32-20110628.zip to update the target game."
			if %choice%==1 set "zipname=onscripter-en-win32_dsound-20110628.zip" 
			if %choice%==2 set "zipname=onscripter-en-win32-20110628.zip" 
	echo %zipname% > zipname.txt 
exit /b
