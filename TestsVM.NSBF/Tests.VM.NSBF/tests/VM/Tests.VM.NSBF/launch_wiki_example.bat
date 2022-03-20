@echo off
call get_free_port.bat 

::Needed for fitnesse :
set CURRENT_DIR=%~p0
set ROOT_DIR=%CURRENT_DIR%
set SERVICE_PORT=20000

::Port used for launch FitNesse server
set SERVICE_PORT= %freePort%

set TOOLS_DIR=%ROOT_DIR%..\\..\\..\\tools


set PROPERTIES_FILE=%ROOT_DIR%fitnesseRoot\\plugins.properties
set DIR_TESTS=%ROOT_DIR%


::Needed for hsac plugin :
set ENV_FITNESSE_DIR=.
set ENV_FITNESSE_ROOT=.\\FitNesseRoot

java -Dfile.encoding=UTF-8 -cp "%TOOLS_DIR%\\fitnesse-standalone.jar;%TOOLS_DIR%\\plugins\\h2-2.1.210.jar;%TOOLS_DIR%\\plugins\\csvjdbc-1.0.38.jar;%TOOLS_DIR%\\plugins\\fitnesse-git-plugin-1.2.0-all.jar;%TOOLS_DIR%\\plugins\\hsac-fitnesse-plugin-1.31.0.jar;%TOOLS_DIR%\\plugins\\toolchain-fitnesse-plugin-2.0.14-jar-with-dependencies.jar;%TOOLS_DIR%\\plugins\\ojdbc8.jar" fitnesseMain.FitNesseMain -f %PROPERTIES_FILE% -d  %DIR_TESTS%  -p %SERVICE_PORT%
pause