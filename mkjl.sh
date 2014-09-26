#!/bin/sh
#

# Define variables
hostname=$1
template=$2

# Functions
error_exit ()
{
echo "$1" 1>&2
exit 1
}

# Create /usr/jails if needed
if [ ! -d "/usr/jails" ]; then
mkdir /usr/jails || error_exit "Cannot create /usr/jails"
fi

# If the jail already exists, abort the provisioning with an error.
if [ -d "/usr/jails/$hostname" ]; then
error_exit "$hostname already exists. Aborting..."
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
