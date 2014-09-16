#!/bin/sh
#

# Define variables
hostname=$1
template=$2

# At first run, and if it doesn't exist yet, /usr/jails is created.
if [ ! -d "/usr/jails" ]; then
echo "Creating /usr/jails..."
mkdir /usr/jails
fi

# If the jail already exists, abort the provisioning with an error.
if [ -d "/usr/jails/$hostname" ]; then
echo "$hostname already exists. Aborting..."
break
fi

## Debian 7
if [ $template = t_debian7 ]; then
. ./templates/t_debian7
fi

## Debian 8
if [ $template = t_debian8 ]; then
. ./templates/t_debian8
fi

## FreeBSD 10
if [ $template = t_freebsd10 ]; then
. ./templates/t_freebsd10
fi

## ArchBSD
if [ $template = t_archbsd ]; then
. ./templates/t_archbsd
fi
