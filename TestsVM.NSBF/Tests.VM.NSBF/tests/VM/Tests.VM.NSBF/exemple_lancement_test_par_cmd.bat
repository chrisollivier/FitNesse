call get_free_port.bat

::Needed for fitnesse :
set CURRENT_DIR=%~p0
set ROOT_DIR=%CURRENT_DIR%
set SERVICE_PORT=%freePort%

set PROPERTIES_FILE=%ROOT_DIR%\\FitnesseRoot\\plugins.properties
set DIR_TESTS=%ROOT_DIR%


::Needed for hsac plugin :
set ENV_FITNESSE_DIR=.
set ENV_FITNESSE_ROOT=.\\FitNesseRoot

set LAUNCH_BASE=-Dfile.encoding=UTF-8 -cp "%ROOT_DIR%..\\..\\..\\tools\\fitnesse-standalone.jar;%ROOT_DIR%..\\..\\..\\tools\\plugins\\h2-2.1.210.jar;%ROOT_DIR%..\\..\\..\\tools\\plugins\\csvjdbc-1.0.38.jar;%ROOT_DIR%..\\..\\..\\tools\\plugins\\fitnesse-git-plugin-1.2.0-all.jar;%ROOT_DIR%..\\..\\..\\tools\\plugins\\hsac-fitnesse-plugin-1.31.0.jar;%ROOT_DIR%..\\..\\..\\tools\\plugins\\toolchain-fitnesse-plugin-2.0.14-jar-with-dependencies.jar" fitnesseMain.FitNesseMain -f %PROPERTIES_FILE% -d  %DIR_TESTS%  -p %SERVICE_PORT%

java %LAUNCH_BASE% -c "%1?responder=suite&format=junit&%2" > temp.xml

more +1 temp.xml > FitnesseRoot\tests_result\resultat.xml
del temp.xml
pause