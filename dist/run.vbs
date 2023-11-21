Dim WShell
Set WShell = CreateObject("WScript.Shell")
WShell.Run "one_microphone.exe", 0
Set WShell = Nothing
'Run with wscript run.vbs