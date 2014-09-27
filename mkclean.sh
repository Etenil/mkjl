#!/bin/sh

while true; do
 echo -n "Warning! All jails and templates will be lost! Proceed? (y/n)"
 read go
 case $go in
  y) chflags -R noschg /usr/jails && rm -rf /usr/jails && break ;;
  n) break ;;
  *) echo "Please type y or n" ;;
 esac
done

echo "All jails cleaned."
