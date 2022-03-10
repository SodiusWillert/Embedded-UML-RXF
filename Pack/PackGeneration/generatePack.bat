@rem $Id: generatePack.bat 65990 2020-02-27 09:54:45Z jtrageser $
@rem $URL: https://svn.willert.de/V7/trunk/Component/Product/RXF_Rpy_CPP/RXF/Pack/NotForRelease/generatePack.bat $

@echo off

rem **** Set name of PDSC file to be packed
dir /b ..\*.pdsc > PDSCName.txt
set /p PDSCName=<PDSCName.txt
del /q PDSCName.txt

rem ****  Copy PDSC file to Files directory
mkdir ..\PackSource
copy /y ..\%PDSCName% ..\PackSource

rem **** Execute a Pack Check
.\PackChk.exe ..\PackSource\%PDSCName% -n PackName.txt

rem **** Check if PackChk.exe has completed successfully
if %errorlevel% neq 0 goto ErrPackChk >PackChkLog.txt

rem **** Pipe Pack's Name into Variable
set /p PackName=<PackName.txt
del /q PackName.txt

rem **** Packing
pushd ..\PackSource
"C:\Program Files\7-Zip\7z.exe" a ..\%PackName% -tzip
popd

goto End

:ErrPackChk
echo PackChk.exe has encountered an error! >> gen_pack_err.log
pause
exit /b

:End
echo generate of CMSIS Pack completed