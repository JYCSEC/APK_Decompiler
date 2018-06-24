#!/bin/bash
#JYC
#Mini script to run some commands to decomiple APKs.
#Should run natively on kali besides needing to
#install procyon

#Dependecies: apktool, dex2jar, procyon

#arg1= file name
#arg2= procyon installed? Flags: 'n'

echo File Name: $1
a=${1:: -4}

echo Outputting as: $a
if [$2 = '']; then
	echo You already have procyon eh?
elif [$2 = 'n']; then
	sudo apt-get install procyon-decompiler
fi

if [$1 = '']; then
	echo You didn\'t give me a file idiot
else
	echo *************USING APKTOOL*************
	apktool d $1
	echo ***************UNZIPPING***************
	unzip -p $1 classes.dex > $a/classes.dex
	cd $a
	echo ***************JAR-ING*****************
	d2j-dex2jar classes.dex
	echo ***************JAR2SRC*****************
	procyon -o src -ss classes-dex2jar.jar
	echo Done decompiling $a
fi
