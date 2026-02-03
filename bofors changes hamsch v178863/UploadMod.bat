@echo off
set GAME_NAME=WARNO

set BASEDIR=$(dirname $0)
..\..\%GAME_NAME%.exe -headless -uploadmod %BASEDIR% CommonData:Clusters/Bootstrap/ClusterBootstrapUploadMod.ndf
..\Utils\Python\python.exe ..\Utils\Scripts\CreateModBackup.py -autoname
