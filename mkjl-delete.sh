#!/bin/sh
#

# Deleting the jail
# Creating /etc/jail.conf
echo "$1 will be deleted. Are you sure ? (y/n)"
while read proceed
do
 case $proceed in
        y) rm -rf /usr/jails/$1 && rm /usr/local/etc/mkjl/$1.conf && echo "Done." ;;
        n) break ;;
        *) echo "invalid"
           continue ;;
 esac
 break
done

