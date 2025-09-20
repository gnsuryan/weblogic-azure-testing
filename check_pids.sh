#!/bin/bash

function hardCodePIDs()
{
	gitWorkDirectory=$1
	cd ${gitWorkDirectory}
	pwd
	pidKeys=`cat resources/pid.properties | cut -f1 -d"=" | grep -v '#' | grep -v "^$"`
	for pidKey in $pidKeys
	do
		value=`cat resources/pid.properties | grep -w "^$pidKey" | cut -f2 -d"="`
		pidString='${'${pidKey}'}'
		jsonFiles=`find . -name *.json`
		for jsonFile in $jsonFiles
		do
			echo "Replacing $pidString with $value in $jsonFile"
			sed -i "s|$pidString|$value|g" $jsonFile
		done
	done
	pidKeys=`cat resources/azure-common.properties | cut -f1 -d"=" | grep -v '#' | grep -v "^$"`
	for pidKey in $pidKeys
	do
		value=`cat resources/azure-common.properties | grep -w "^$pidKey" | cut -f2 -d"="`
		pidString='${'${pidKey}'}'
		jsonFiles=`find . -name *.json`
		for jsonFile in $jsonFiles
		do
			echo "Replacing $pidString with $value in $jsonFile"
			sed -i "s|$pidString|$value|g" $jsonFile
		done
	done
}

if [ ! -d "$1" ];
then
  echo "Directory $1 does not exist"
  exit 1
fi

hardCodePIDs "$1"
