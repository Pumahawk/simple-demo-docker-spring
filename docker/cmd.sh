#!/bin/sh

DEBUG_PORT=${TOMCAT_DEBUG_PORT}

MAVEN_CLEAN=${APP_MAVEN_CLEAN:-"false"}
DEBUG=${APP_DEBUG:-"false"}
MAIN_CLASS=${APP_MAIN_CLASS:?"Undefined main class. Try to define environment variable MAIN_CLASS"}

mvn compile

echo DEBUG: $DEBUG
if [ $DEBUG = "true" ]; then
	JAVA_ARGS_DEBUG="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=$DEBUG_PORT"

fi

echo MAIN CLASS: $MAIN_CLASS
MAVEN_OPTS="${JAVA_ARGS_DEBUG:-""}" mvn exec:java -Dexec.mainClass=$MAIN_CLASS
