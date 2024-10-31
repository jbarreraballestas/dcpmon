@echo off
REM This script creates the deployable dcpmon.war file by overlaying
REM your customized files on the files from the distribution.

REM BASEDIR -- we assume you are in the directory containing this script.
set BASEDIR=%cd%

REM Remove staging area and save old war if there is one.
if exist war-stage (
  rmdir /s /q war-stage
)
if exist dcpmon.war (
  echo Saving previous dcpmon.war as dcpmon.war.old
  move dcpmon.war dcpmon.war.old
)

REM Copy the stock distro into a new staging area
echo Copying the distro files into war-stage...
cd %BASEDIR%
mkdir war-stage
cd war-distro
xcopy * ..\war-stage /s /e /y

REM Copy any custom files into the staging area, overwriting distro files
echo Overlaying files from war-custom...
cd %BASEDIR%\war-custom
xcopy * ..\war-stage /s /e /y

REM Make the war
echo Building new dcpmon.war...
cd %BASEDIR%\war-stage
jar cf ..\dcpmon.war *

echo To deploy, copy dcpmon.war from this directory into the webapps directory under your Tomcat installation.
cd %BASEDIR%