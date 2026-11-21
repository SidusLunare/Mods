@echo off
set GAME_NAME=WARNO

for %%* in (.) do set CurrDirName=%%~nx*
..\..\%GAME_NAME%.exe -headless -uploadmod "%CurrDirName%" CommonData:Clusters/Bootstrap/ClusterBootstrapUploadMod.ndf
python3 ..\Utils\Scripts\CreateModBackup.py -autoname
pause
