:: set up
@echo off

SET "zipD=%cd%"
SET "gameD=%~1"

:: Read .zip name from file

:: detect zip.txt
if NOT EXIST zip.txt (echo "AONS-ENSU couldn't detect a zip.txt file in %cd%. Please create a zip.txt file with the name of the .zip file that contains the updated onscripter-en executable." && goto EOF)

:: read from zip.txt
FOR /F "tokens=* delims=" %%x in (zip.txt) DO SET "zipFile=%%x"
echo %zipFile%

:: detect .zip file
if NOT EXIST %zipFile% (echo "%zipfile% does not exist, please either: a) fix the file name in zip.txt, or, b) move the file named in zip.txt to the same folder as AONS-ENSU" && goto EOF)

:: unzip and copy contents of .zip file

:: make a tmp directory and unzip the .zip file into tmp
mkdir tmp && copy %zipFile% tmp && cd tmp && set "tmpDir=%zipD%\tmp" && tar -xf %zipFile% && del *.zip

:: detected and deal with nested directory

:: chop off the ".zip" from the %zipFile% variable. This should be the name of the nested folder, if it exists.
set "_zipFile=%zipFile%"
SET "_zipDir=%_zipFile:~0,-4%"
set "zipDir=%_zipDir%"

:: deal with the nested folder by cd-ing in, copy all the files to the directory one step up, cd-ding out, and finally deleting the directory
if EXIST %zipDir% (cd %_zipDir% && copy *.* %tmpDir% && cd %tmpDir% && rmdir /s /q %zipDir%)

:: copy updated executable and other files into game directory
copy *.* %gameD% && cd %zipD% && rmdir /s /q tmp

:: You *cannot* copy the .zip file into the game directory, and then use tar to unzip it there. It just doesn't work from a batch file, onscripter-en.exe just gives strange errors.

:: create a game.id file containing the name of the game
cd %gameD%
SET "gameName=%~2"
REN onscripter-en.exe %gameName%.exe
echo %gameName%>game.id

::create a savedata folder in the game directory and create an ons.cfg that sets that folder as the save location
cd %gameD% && mkdir "savedata" && echo save=%gameD%\savedata>ons.cfg

:: cd into AONS-ENSU directory, for my own sanity testing the goddamn thing
cd %zipD%
