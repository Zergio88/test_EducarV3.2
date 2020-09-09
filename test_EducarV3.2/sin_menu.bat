@echo off
@title PRINCIPAL
@mode con cols=80 lines=35
color a

REM PRUEBA DE TECLADO
java -version >nul 2>&1
if %ERRORLEVEL% == 0 (
java -jar %CD%/support/test-teclado2runa.jar
cls
) else (
start /wait %CD%/support/teclado.exe
cls
)

if %ERRORLEVEL%==0 (
set tec=realizado
) else (
if %ERRORLEVEL%==1069 (
set tec=realizado
) else (
set tec=
)
)

REM prueba de Camara
@del /f /q version.txt >nul 2>&1
@for /f "tokens=1,2* skip=1" %%a in ('wmic os get version') do (@echo %%a>>version.txt 2>&1)
@set /p version=<version.txt
@del /f /q version.txt >nul 2>&1

if %version%==6.3.9600 (
set cam=:La camara se debe probar manualmente en windows 8
) else (
if %version%==10.0.15063 (
set cam=:La camara se debe probar manualmente en windows 10
) else (
REM valido directorio; Uso un acceso directo de soporte para acceder al programa
if exist "C:\Program Files\Intel Learning Series\ArcSoft WebCam Companion 3" (
REM con este "bat" consigo que la ventana se ejecute secuencialmente
start /B /WAIT %CD%/support/ventanaNueva.bat "%CD%/acc_dir/WebCam Companion 3.lnk" camara
set cam=:realizado
cls
) else (
REM Valido directorio; Uso un acceso directo de soporte para acceder al programa
if exist "C:\Program Files\Intel(R) Learning Series\ArcSoft WebCam Companion 4" (
REM con este "bat" consigo que la ventana se ejecute secuencialmente
start /B /WAIT %CD%/support/ventanaNueva.bat "%CD%/acc_dir/uWebCam.lnk" camara
set cam=:realizado
cls
) else (
REM para las primeras samsung
if exist "C:\Program Files\CyberLink\YouCam" (
REM con este "bat" consigo que la ventana se ejecute secuencialmente
start /B /WAIT %CD%/support/ventanaNueva.bat "%CD%/acc_dir/YouCam.lnk" camara
set cam=:realizado
cls	
) else (
REM para las conig 2010 con XP
if exist "C:\Archivos de programa\ArcSoft\WebCam Companion 3" (
start /B /WAIT %CD%/support/ventanaNueva.bat "%CD%/acc_dir/WebCam Companion_3.lnk" camara
set cam=:realizado
cls
) else (
set cam=:No se encontro programa de camara
)
)		
) 
)
)
)	

REM PRUEBA DE RED
@del /f /q version.txt >nul 2>&1
@for /f "tokens=1,2* skip=1" %%a in ('wmic os get version') do (@echo %%a>>version.txt 2>&1)
@set /p version=<version.txt
@del /f /q version.txt >nul 2>&1

if %version%==5.1.2600 (
start /B /WAIT %CD%/support/ventanaNueva.bat "%CD%/acc_dir/wifiEXO352.lnk" red
cls
) else (
echo escaneo de redes wifi
start /WAIT /MAX %CD%/support/buscarRedes.bat
cls
)
if %ERRORLEVEL%==0 (
set red=realizado
) else (
set red=
)

REM PRUEBA DE TPM
@del /f /q version.txt >nul 2>&1
@for /f "tokens=1,2* skip=1" %%a in ('wmic os get version') do (@echo %%a>>version.txt 2>&1)
@set /p version=<version.txt
@del /f /q version.txt >nul 2>&1

if %version%==10.0.15063 (
ssdoctor.lnk
REM start /B /WAIT %CD%/support/ventanaNueva.bat "%CD%/acc_dir/tpm_win10.lnk" tpm
) else (
start /B /WAIT tpmtool.bat
cls
)
if %ERRORLEVEL% == 0 (
set tpm=:REALIZADO
) else (
set tpm=:realizado
)

REM PRUEBA DE MICROFONO
java -version >nul 2>&1
if %ERRORLEVEL% == 0 (
echo Prueba de microfono
java -jar %CD%/support/pruebamicv1.jar
echo listo
pause>nul
cls
) else (
if exist "C:\Program Files (x86)\Java\jre6\bin" (
"C:\Program Files (x86)\Java\jre6\bin\java.exe" -jar %CD%/support/pruebamicv1.jar
echo listo
pause>nul
cls
) else (
start taskmgr.exe
start /HIGH /WAIT %CD%/support/sndrec32.exe
echo listo
pause>nul
)
)
if %ERRORLEVEL%==0 (
set mcr=realizado
) else (
set mcr=
)

REM PRUEBA DE AUDIO
@del /f /q version.txt >nul 2>&1
@for /f "tokens=1,2* skip=1" %%a in ('wmic os get version') do (@echo %%a>>version.txt 2>&1)
@set /p version=<version.txt
@del /f /q version.txt >nul 2>&1

if %version%==5.1.2600 (
start /B /WAIT %CD%/support/ventanaNueva.bat "%CD%/acc_dir/sonidoEXO352.lnk" audio
cls
) else (
if exist "C:\Program Files\Realtek\Audio\HDA\RtHDVCpl.exe" (
start /B /WAIT %CD%/support/ventanaNueva.bat "%CD%/acc_dir/RtHDVCpl.lnk" audio
cls
) else (
if exist "C:\Program Files\Realtek\Audio\HDA\RAVCpl64.exe" (
start /B /WAIT %CD%/support/ventanaNueva.bat "%CD%/acc_dir/RAVCpl64.lnk" audio
cls
) else (
mmsys.cpl
pause
set /a ERRORLEVEL=0
)
)
)
if %ERRORLEVEL%==0 (
set son=realizado
) else (
set son=
)

REM PRUEBA DE VIDEO
if exist "D:\Videos\Cuida-tu-net.flv" (
cls
echo Prueba de video
start /B /WAIT D:\Videos\Cuida-tu-net.flv
cls
) else (
if exist "D:\Contenidos\La Seguridad Social y Vos" (
cls
echo prueba de video
start /B /WAIT %CD%/support/ventanaNueva.bat "%CD%/acc_dir/ANSES con Vos.lnk" video 
cls
) else ( 
if exist "D:\Contenidos\Con vos en la web.mp4" (
cls
echo prueba de video
start /B /WAIT %CD%/support/ventanaNueva.bat "%CD%/acc_dir/Con vos en la web.lnk" video
cls
) else (
if exist "D:\Colecci¢n BCRA\CONDOR.mp4" (
cls
"%CD%/acc_dir/CONDOR.lnk"
cls
) else (
echo prueba de video
set /a ERRORLEVEL=1234
cls
)
)
)
)
)

if %ERRORLEVEL%==0 (
set vid=realizado
) else (
if %ERRORLEVEL%==1234 (
set vid=No se encontraron videos
) else (
set vid=
)
)

REM PRUEBA DE TDA
if exist "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\HiDTV" (
REM con este "bat" consigo que la ventana se ejecute secuencialmente
start /B /WAIT %CD%/support/ventanaNueva.bat "%CD%/acc_dir/HiDTV.lnk" TDA
set tda=realizado
cls
) else (
if exist "C:\Program Files\SATVD-T" (
start /B /WAIT %CD%/support/ventanaNueva.bat "%CD%/acc_dir/SATVD-T.lnk" TDA
set tda=realizado
cls
) else (
if exist "C:\Program Files (x86)\nplayer 2.2.1330\bin\nplayer.exe" (
start /B /WAIT %CD%/support/ventanaNueva.bat "%CD%/acc_dir/NPlayer.lnk" TDA
set tda=realizado
cls
)  else (
set tda=No se encontraron programas para TDA
)
)
)

echo teclado: %tec%
echo camara: %cam%
echo red: %red%
echo tpm: %tpm%
echo microfono: %mcr%
echo sonido: %son%
echo video: %vid%
echo tda: %tda%

REM configuro la extension de variables para permitir usar "defined"
setlocal enabledelayedexpansion

REM ELIMINA FORM
set /p variable="desea borrar el formulario? S/N: "
if not defined variable (
REM para que no rompa el script si no ingreso nada
goto fin
pause
) else (
if !variable!==s (
goto borrar_form
) else (
if !variable!==S (
goto borrar_form
) else (
REM para cualquier otro caracter
goto fin
)
)
)

 
endlocal 

:borrar_form
@taskkill /f /im "conigform-windows.exe" >nul 2>&1
msconfig
@rmdir /q /s D:\.cache >nul 2>&1
@rmdir /q /s D:\.upgrade >nul 2>&1

:fin
REM ELIMINA TEST
cd..
rmdir /s /q test_EducarV3.2 >nul 2>&1

REM FIN