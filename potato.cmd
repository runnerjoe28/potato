@echo off
setlocal

rem Ensure that the required arguments are provided
if "%1"=="" (
    echo Usage: potato.cmd [command] [subcommand] [FILE]
    exit /b 1
)

rem Parse the command
set "command=%1"
shift

rem Process the command
if /i "%command%"=="audio" (
    call :audio %*
) else if /i "%command%"=="build" (
    call :build %*
) else if /i "%command%"=="git" (
    call :git %*
) else if /i "%command%"=="run" (
    call :run %*
) else if /i "%command%"=="py" (
    call :py %*
) else (
    echo Unknown command: %command%
    exit /b 1
)

rem End of script
:end
exit /b 0

rem Functions

:audio
rem List all audio files in the /audio folder
dir /b /s /a-d .\audio\*.mp3
exit /b 0

:build
rem Build elements of the program
if "%1"=="all" (
    call :build_all %2
) else if "%1"=="clean" (
    call :clean
) else if "%1"=="exe" (
    call :build_exe
) else if "%1"=="req" (
    call :regen_requirements
) else if "%1"=="venv" (
    call :build_venv
) else (
    echo Unknown build subcommand: %1
    exit /b 1
)
exit /b 0

:build_all
rem Build the entire package
echo Building the entire package with audio file: %1
rem Add your build process here
exit /b 0

:clean
rem Undo the effects of running `build all`
echo Cleaning up the build
rem Add your cleanup process here
exit /b 0

:build_exe
rem Build just the python executable
echo Building the Python executable
rem Add your build process here
exit /b 0

:regen_requirements
rem Regenerate requirements.txt file for python venv
echo Regenerating requirements.txt
rem Add your requirements regeneration process here
exit /b 0

:build_venv
rem Build/rebuild python venv and update terminal session
echo Building/rebuilding Python venv and updating terminal session
rem Add your venv build process here
exit /b 0

:git
rem Regenerate requirements.txt and perform a full build before commits
echo Performing Git-related tasks
call :regen_requirements
call :build_all
rem Add your git-related tasks here
exit /b 0

:run
rem Run some set of functionalities
if "%1"=="all" (
    call :run_all
) else if "%1"=="exe" (
    call :run_exe
) else (
    echo Unknown run subcommand: %1
    exit /b 1
)
exit /b 0

:run_all
rem Run fully packaged software
echo Running fully packaged software
rem Add your run all process here
exit /b 0

:run_exe
rem Run only the python executable of fully packaged software
echo Running Python executable of fully packaged software
rem Add your run exe process here
exit /b 0

:py
rem Run only the python file
echo Running Python file
rem Add your run python file process here
exit /b 0