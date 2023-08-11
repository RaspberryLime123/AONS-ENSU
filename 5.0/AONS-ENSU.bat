@echo off

::This code is just for housekeeping. just leave it alone.
SETLOCAL ENABLEEXTENSIONS


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
	for /f %%a in (zipname.txt) do set zipname=%%a
	echo %zipname%
)

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
	echo -zipchoice- 
	set "onsen-old-sdl-zip=0"
	set "onsen-old-zip=0"
	set "no-zip-err-msg=Neither the ONScipter-EN nor the ONScripter-insani zip is present in the zip directory. Please add at least one of the two .zip files to the script directory."
	echo vars set
:: 	look for the 20110628 onscripter builds
	if exist onscripter-en-win32_dsound-20110628.zip (set onsen-old-sdl-zip=1 && echo onsen found) else (echo onsen-old-sdl-zip not found)
	if exist onscripter-en-win32-20110628.zip (set onsen-old-zip=1 && echo onsen-dsound found) else (echo onsen-old-zip not found)
:: 	if neither the sdl build is found nor the no-sdl build is found, echo err msg and exit
	if %onsen-old-zip% EQU 0 ( echo onsen EQU 0  passed  
		if %onsen-old-sdl-zip% EQU 0 (echo EQU 0 passed && set "no-zip=1" ) 
	) 
	::if %no-zip% EQU 1 ( echo %no-zip-err-msg% && echo: && echo continue to exit && pause && exit)

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
