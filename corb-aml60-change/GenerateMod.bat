@echo off
set GAME_NAME=WARNO

for %%* in (.) do set CurrDirName=%%~nx*
..\Utils\Python\python.exe ..\Utils\Scripts\GenerateMod.py "%GAME_NAME%" "%CurrDirName%"
PAUSE
