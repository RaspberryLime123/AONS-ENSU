:: set up
:: @echo off
SET "DsoundZip=onscripter-en-win32_dsound-20110628.zip"
SET "noDsoundZip=onscripter-en-win32-20110628.zip"

SET "zipD=%cd%"
SET "gameD=%~f1"

SET "Dsound=0"
SET "noDsound=0"

:: detect zip files
if EXIST "onscripter-en-win32_dsound-20110628.zip" (SET "Dsound=1") 
if EXIST  "onscripter-en-win32-20110628.zip" (SET "noDsound=1")

:: if both .zip files are present, throw error
if %Dsound%==1 (
	if %noDsound%==1 (
		echo "both %DsoundZip% and %noDsoundZip% were found in the same folder as AONS-ENSU. Please remove one of them from the folder and try agian." goto:eof
	)
)

:: if only Dsound.zip is present, make a new tmp directory, copy Dsound.zip into tmp, cd into tmp, unzip Dsound.zip, delete the original .zip file still in tmp, finally, copy all files from tmp to the game directory
if %Dsound%==1 (mkdir tmp && copy %DsoundZip% tmp && cd tmp && tar -xf %DsoundZip% && del *.zip && copy *.* %gameD% && cd %zipD% && rmdir /s /q tmp)
:: You *cannot* copy Dsound.zip into the game directory, and then use tar to unzip it there. It just doesn't work from a batch file, onscripter just gives strange errors.

:: see above
if %noDsound%==1 (mkdir tmp && copy %noDsoundZip% tmp && cd tmp && tar -xf %noDsoundZip% && del *.zip && copy *.* %gameD% && cd %zipD% && rmdir /s /q tmp)


:: if neither .zip file is present, throw error
if %noDsound%==0 (
	if %Dsound%==0 (
		echo "Neither %noDsoundZip% nor %DsoundZip% were found in the same folder as AON-ENSU. Please move one of these two into the same folder as AON-ENSU and try again." && goto:eof
	)
)

:: create a game.id file containing the name of the game
cd %gameD%
SET "gameName=%~2"
REN onscripter-en.exe %gameName%.exe
echo %gameName%>game.id

::create a savedata folder in the game directory and create an ons.cfg that sets that folder as the save location
cd %gameD% && mkdir "savedata" && echo save=%gameD%\savedata>ons.cfg

:: cd into AONS-ENSU directory, for my own sanity testing the goddamn thing
cd %zipD%
