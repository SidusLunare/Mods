@echo off
set GAME_NAME=WARNO
for %%I in ("%CD%") do set CurrDirName=%%~nxI

..\..\%GAME_NAME%.exe -headless -uploadmod "%CurrDirName%" CommonData:Clusters/Bootstrap/ClusterBootstrapUploadMod.ndf
..\Utils\Python\python.exe ..\Utils\Scripts\CreateModBackup.py -autoname
