@echo off
cd test
if EXIST ons.cfg erase ons.cfg
if EXIST savedata erase savedata & rmdir savedata
if EXIST game.id erase game.id
if EXIST onscripter-en.exe erase onscripter-en.exe
:end