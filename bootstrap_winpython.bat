@ECHO OFF
: If WinPython URL is not defined (set through Jenkins, etc)
IF "%WINPYTHON_URL%"=="" (
: Use a known default
set URL=https://github.com/winpython/winpython/releases/download/1.10.20180827/WinPython64-3.6.6.2Qt5.exe
) ELSE (
: Otherwise use the given URL.
set URL=%WINPYTHON_URL%
)
: Generate the package name based on URL. 
FOR %%i IN ("%URL%") DO (
set PKG=%~dp0%%~ni%%~xi
)

: If the package doesn't exist locally, download it.
if not exist %PKG% %~dp0curl.exe -L -o %PKG% %URL%
: If the package has not been 'installed' install it.
if not exist %~dp0WinPython %PKG% /S /D=%~dp0WinPython

call %~dp0WinPython\scripts\upgrade_pip.bat

attrib +r %~dp0WinPython
attrib +h %~dp0.