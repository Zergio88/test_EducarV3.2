@title test con tpmtool
@echo off
cls
color a
cd tpmtool
tpmtool.exe -data
tpm >nul 2>&1
echo Listo
pause
exit -B