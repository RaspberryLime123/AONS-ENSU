BEFORE YOU DO *ANYTHING* READ THIS!

This .bat file relies on all the contents of "AONS-ENSUv2.0" to work.
If you move anything, anything at all, it won't work. If you move something on accident and can't fix the problems it causes, 
just reinstall the whole thing.



This is a batch file meant for automatically updating ONScripter-EN executables to the (almost) most recent version, 
while also creating an ons.cfg and using it create a save folder.


DEPENDENCIES: (included in AONS-ENSUv2.0)
unzip.exe 
unzip license
GPL

NOTE: user-set variables are declared and initialized "set /p <VAR> = <VALUE>"





ONLY READ IF YOU WANT TO TINKER
For those new to cmd batch files, please use ss64.com and https://www.robvanderwoude.com/batchfiles.php.
ss64 is a command reference for cmd and other terminal emulators.
robvanderwoude is also a command reference, but it has a lot of extra tips and tricks.

VARIABLES AND THEIR PURPOSES

str checkAgainst
USED IN :WD_CHK
this is literally what WD_CHK is checked against.

int dependencyCheckSuccess
USED IN :dependencyCheck
This variable is incremented by the subrouting :dependencyCheck everytime a dependency is found in the installation folder.
NOTE this is and "arithmetic" int. the "/a" flag in it's "set" command makes cmd evaluate the expression on the other side of "=" 
and set that integer as the variable.

int dsoundCheck
USED IN :dsoundCheck, :errorLevelCheck, and :zipChoiceIFANDIF
dsoundCheck is updated if onscripter-en-win32_dsound-20110628.zip is detected by :dsoundCheck. It is used again in
:zipChoiceIFANDIF, to check if both onscripter-en-win32_dsound-20110628.zip and onscripter-en-win32-20110628.zip are present.

int ERRORLEVEL
USED IN :errorLevelCheck
This is an internal CMD global environment variable. It has a ton of uses, but I only use to to tell whether D or N was pressed in 
:zipChoice.

str GI
As the .bat tells you, this is name of the game.
It is printed to game.id, which is accessed by onscripter-en.exe. Look at kaisernet.org for more details.

int nonDsoundCheck
USED IN:nonDsoundCheck, :errorLevelCheck, and :zipChoiceIFANDIF
nonDsoundCheck is updated if onscripter-en-win32_dsound-20110628.zip is detected by :nonDsoundCheck. It is used again in
:zipChoiceIFANDIF, to check if both onscripter-en-win32_dsound-20110628.zip and onscripter-en-win32-20110628.zip are present.

str ONS_N 
corresponds to the exact file name, including extension, of the updated ONScripter-EN zip file. 
The value of ONS-N *MUST* be exactly the same as the .zip file that contains the updating resources.
This variable is name of the file that unzip.exe will unzip, and it is used in the command that calls unzip.exe.

str parent
corresponds to the folder in which the file AONS-ENSUv4.0.bat is located in. This variable, and the way it is used,
is what makes it impossible to move/rename any of the components of this installation.

str WD
As the .bat tells you, this is the full path of the game directory. 
Game directory means the folder where the set of ONS-EN files you want to update are. 
IT IS IMPORTANT TO NOTE: when entering a path for WD, do not add a trailing backslash.

str WD_CHK
USED IN :WD_CHK
this variable is equal to the last character of WD. It is used to check if WD ends in a backslash.


if you have problems you just can't figure out, have something to say, or want to talk visual novels, 
shoot me an email: raspberrylime345@gmail.com
