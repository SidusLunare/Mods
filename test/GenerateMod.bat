@echo off
set GAME_NAME=WARNO

for %%* in (.) do set CurrDirName=%%~nx*
python3 ..\Utils\Scripts\GenerateMod.py "%GAME_NAME%" "%CurrDirName%"
PAUSE
