REM Make sure JAVAPATH below is correct for your environment
@echo off
set JAVAPATH="C:\Program Files\Sumo Logic Collector\jre\bin"

if [%1]==[-s] (
        echo Setup mode
        set runMode=-s
) else (
        set runMode=-r
)
for /f %%i in ('dir /B /ON januscore*.jar') do set main_jar=%%i
echo "Found SumoJanus core jar file: %main_jar%"
%JAVAPATH%\java.exe -jar %main_jar% %runMode% OktaCollector-1.0.2.jar -e 1800