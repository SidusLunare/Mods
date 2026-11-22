@echo off
for %%* in (.) do set CurrDirName=%%~nx*
python3 ..\Utils\Scripts\CreateAssetDefinitionFiles.py "%CurrDirName%"
pause
