@echo off
set freePort=
set startPort=20000

:SEARCHPORT
netstat -o -n -a | find "LISTENING" | find ":%startPort% " > NUL
if "%ERRORLEVEL%" equ "0" (
  echo "port unavailable %startPort%"
  set /a startPort +=1
  GOTO :SEARCHPORT
) ELSE (
  
  set freePort=%startPort%
  GOTO :FOUNDPORT
)

:FOUNDPORT

