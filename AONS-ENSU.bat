@echo off
SET "DsoundZip=onscripter-en-win32_dsound-20110628.zip"
SET "noDsoundZip=onscripter-en-win32-20110628.zip"

SET "zipD=%cd%"
SET "gameD=%~f1"

SET "Dsound=0"
SET "noDsound=0"
if EXIST "onscripter-en-win32_dsound-20110628.zip" (SET "Dsound=1") 
if EXIST  "onscripter-en-win32-20110628.zip" (SET "noDsound=1")

if %Dsound%==1 (
	if %noDsound%==1 (
		echo "both %DsoundZip% and %noDsoundZip% were found in the same folder as AONS-ENSU. Please remove one of them from the folder and try agian." goto:eof
	)
)

if %Dsound%==1 (COPY %DsoundZip% %gameD% && cd %gameD% && tar -xf %DsoundZip% && DEL %DsoundZip%)
if %noDsound%==1 (COPY %noDsoundZip% %gameD% && cd %gameD% && tar -xf %noDsoundZip% && DEL %noDsoundZip%)
if %noDsound%==0 (
	if %Dsound%==0 (
		echo "Neither %noDsoundZip% nor %DsoundZip% were found in the same folder as AON-ENSU. Please move one of these two into the same folder as AON-ENSU and try again." && goto:eof
	)
)
:: 3
SET "gameName=%~2"
REN onscripter-en.exe %gameName%.exe

:: 4
cd %gameD% && mkdir "savedata" && echo savedata='%gameD%\savedata'>ons.cfg
cd %zipD%
