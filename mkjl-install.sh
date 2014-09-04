#!/bin/sh
#

# Creating /etc/jail.conf
echo "Warning! /etc/jail.conf will be overwritten. Proceed ? (y/n)"
while read proceed
do
 case $proceed in
	y) cp ./src/jail.conf /etc/ ;;
	n) break ;;
	*) echo "invalid" 
	   continue ;;
 esac
 break
done

# Creating /usr/local/etc/mkjl
mkdir -p /usr/local/etc/mkjl

echo "Installation complete"
