@echo off
setlocal

set "command=%1"
shift

rem Process the command to its function
if /i "%command%"=="audio" (
    call :audio %*
) else if /i "%command%"=="build" (
    call :build %*
) else if /i "%command%"=="git" (
    call :git
) else if /i "%command%"=="help" (
    call :help
)else if /i "%command%"=="run" (
    call :run %*
) else (
    echo Unknown command: %command%
    echo Usage: potato.cmd [command] [subcommand] [FILE]
    echo Run 'potato.cmd help' for more information
    exit /b 1
)

rem End of script
:end
exit /b 0

rem Functions
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:audio
echo Listing all audio files
echo -----------------------
dir /b /a-d .\audio
exit /b 0

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:build
rem Build elements of the program
if "%2"=="all" (
    call :build_all %3
) else if "%2"=="clean" (
    call :clean
) else if "%2"=="exe" (
    call :build_exe
) else if "%2"=="req" (
    call :regen_requirements
) else if "%2"=="venv" (
    call :build_venv
) else (
    echo Unknown build subcommand: %2
    echo Run 'potato.cmd help' for more information
    exit /b 1
)
exit /b 0


:build_all
if "%1"=="" (
    echo Error: no audio file specified
    exit /b 1
)
echo Building the entire package with audio file: %1
del /s /q dist
if exist "audio\%1" (
    copy "audio\%1" "dist\audio\"
) else (
    echo Error: File '%1' not found in '\audio'.
    exit /b 1
)
call :build_exe
copy trojan_turkey_scripts\run.vbs dist
copy trojan_turkey_scripts\trojan_turkey_flash.cmd dist

exit /b 0


:clean
echo Cleaning up the build
rem Deletes the run on startup configuration
REG DELETE "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /V "one_microphone" /F
exit /b 0


:build_exe
echo Building the Python executable
pyinstaller -F one_microphone.py
del one_microphone.spec
exit /b 0


:regen_requirements
echo Regenerating requirements.txt
pip freeze --all > requirements.txt
exit /b 0


:build_venv
echo Building/rebuilding Python venv and updating terminal session
python -m venv potato_env
potato_env\Scripts\activate
py -m pip install -r requirements.txt
exit /b 0

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:git
rem Regenerate requirements.txt and perform a full build before commits
echo Performing Git-related tasks
call :regen_requirements
call :build_all song_opening.wav
exit /b 0

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:help
rem Displays information about the program and how to run it
type trojan_turkey_scripts\potato_help.txt
exit /b 0

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:run
rem Run some set of functionalities
if "%2"=="all" (
    call :run_all
) else if "%2"=="exe" (
    call :run_exe
) else if "%2"=="py" (
    call :run_py    
) else (
    echo Unknown run subcommand: %2
    echo Run 'potato.cmd help' for more information
    exit /b 1
)
exit /b 0


:run_all
echo Running fully packaged software
cd dist
trojan_turkey_flash.cmd
exit /b 0


:run_exe
echo Running Python executable of fully packaged software
dist\one_microphone.exe
exit /b 0


:run_py
echo Running Python file
python one_microphone.py
exit /b 0