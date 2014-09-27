#!/bin/sh

while true; do
 echo -n "Warning! All jails and templates will be lost! Proceed? (y/n)"
 read go
 case $go in
  y) chflags -R noschg /usr/jails && rm -rf /usr/jails && break
     echo "All jails cleaned."
     ;;
  n) break
     echo "Leaving jails untouched."
  *) echo "Please type y or n" ;;
 esac
done
