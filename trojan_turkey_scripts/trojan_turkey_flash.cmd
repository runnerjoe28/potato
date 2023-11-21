REM This assumes that the user has cloned or otherwise downloaded the files in \dist

REM Save the working directory
set "WORKING_DIR=%~dp0"

REM Change the working directory to the folder where this file is located
cd %WORKING_DIR%

REM Run program as a background process
wscript.exe run.vbs

REM Setup program to start upon computer turning on
REM This adds a registry entry to run the script on startup
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /V "one_microphone" /t REG_SZ /F /D "cmd /c cd /d %WORKING_DIR% && wscript.exe run.vbs"
REM To delete the result: REG DELETE "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /V "one_microphone" /F
