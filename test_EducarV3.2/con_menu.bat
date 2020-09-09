@echo off 

REM variables que las utilizo como bandera, para saber si una prueba se realizó
set tec=
set cam=
set red=
set tpm=
set mcr=
set son=
set vid=
set tda=
set eli=

REM seccion inicio-MENU
:inicio 
title MENU - test Educar
color a
cls
echo ******************** 
echo *****-=[MENU]=-***** 
echo ******************** 
echo 1) teclado %tec%
echo 2) camara %cam%
echo 3) red %red%
echo 4) tpm %tpm%
echo 5) microfono %mcr%
echo 6) sonido %son%
echo 7) video %vid%
echo 8) TDA %tda%
echo 9) elimina formulario %eli%
echo ******************** 
echo 0) Salir 
echo ******************** 
echo. 

REM redirijo a otra seccion de acuerdo a la opcion seleccionada
set /p var=Seleccione una opcion [0-9]: 
if "%var%"=="1" goto op1_tec
if "%var%"=="2" goto op2_cam
if "%var%"=="3" goto op3_red
if "%var%"=="4" goto op4_tpm
if "%var%"=="5" goto op5_mcr
if "%var%"=="6" goto op6_son
if "%var%"=="7" goto op7_vid
if "%var%"=="8" goto op8_tda
if "%var%"=="9" goto op9_eli
if "%var%"=="0" goto salir 

::Mensaje de error de validación, cuando se selecciona una opción fuera de rango 
echo. El numero "%var%" no es una opcion valida, por favor intente de nuevo. 
echo. 
pause 
echo. 
goto inicio 

:op1_tec
REM si java esta instalado, ejecuto test-teclado en java
java -version >nul 2>&1
if %ERRORLEVEL% == 0 (
java -jar %CD%/support/test-teclado2runa.jar
) else (
start /wait %CD%/support/teclado.exe
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

REM limpio la variable de "opciones" que seleccioné antes
set var=

echo termino 
pause 
goto inicio 

:op2_cam
REM PRUEBA DE CAMARA
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
REM limpio la variable de "opciones" que seleccioné antes
set var=
goto inicio 

:op3_red
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

if %ERRORLEVEL% == 0 (
set red=:REALIZADO
) else (
set red=:realizado
)

REM limpio la variable de "opciones" que seleccioné antes
set var=
echo.  
goto inicio 

:op4_tpm
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

REM limpio la variable de "opciones" que seleccioné antes
set var=
echo. 
goto inicio 

:op5_mcr
REM PRUEBA DE MICROFONO
java -version >nul 2>&1
if %ERRORLEVEL% == 0 (
echo prueba de microfono
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

if %ERRORLEVEL% == 0 (
set mcr=:REALIZADO
) else (
set mcr=:realizado
)

REM limpio la variable de "opciones" que seleccioné antes
set var=
echo.
goto inicio 

:op6_son
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
set /a ERRORLEVEL=0
)
)
)

if %ERRORLEVEL% == 0 (
set son=:REALIZADO
) else (
set son=:realizado
)

REM limpio la variable de "opciones" que seleccioné antes
set var=
echo termino 
goto inicio 

:op7_vid
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

REM limpio la variable que seleccione antes
set var=
echo termino 
goto inicio 

:op8_tda
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


REM limpio la variable de "opciones" que seleccioné antes
set var=
echo termino 
goto inicio 

:op9_eli
REM ELIMINA FORM

@taskkill /f /im "conigform-windows.exe" >nul 2>&1
msconfig
@rmdir /q /s D:\.cache >nul 2>&1
@rmdir /q /s D:\.upgrade >nul 2>&1


if %ERRORLEVEL% == 0 (
set eli=:REALIZADO
) else (
set eli=:realizado
)

REM limpio la variable de "opciones" que seleccioné antes
set var=
echo termino 
pause s
goto inicio 


:salir 
REM ELIMINA TEST
cd.. 
rmdir /s /q test_EducarV3.2 >nul 2>&1

REM FIN