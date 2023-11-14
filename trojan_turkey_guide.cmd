@echo off

REM Step 0: Install choco
REM Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

REM Step 1: Clone git repository as zip file and unzip
choco install wget -y
wget https://github.com/runnerjoe28/potato/archive/main.zip
tar -xf main.zip

REM Step 2: Navigate to the cloned directory
cd potato-main

REM Step 4: Save the working directory
set "WORKING_DIR=%CD%"

REM Step 5: Run program as a background process
wscript.exe run.vbs

REM Optional Step: Setup program to start upon computer turning on
REM This adds a registry entry to run the script on startup
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /V "one_microphone" /t REG_SZ /F /D "cmd /c cd /d %WORKING_DIR% && wscript.exe run.vbs"
echo Installation complete