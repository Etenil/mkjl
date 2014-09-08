#!/bin/sh
#

# Define variables
hostname=$1
template=$2

# Check if first run
if [ ! -d "/usr/jails" ]; then
echo "Creating /usr/jails..."
mkdir /usr/jails
fi

# Check if jail already exists
if [ -d "/usr/jails/$hostname" ]; then
echo "$hostname already exists. Aborting..."
break
fi

# If t_debian8 
if [ $template = t_debian8 ]; then
. ./templates/t_debian8
fi

# If t_freebsd10
if [ $template = t_freebsd10 ]; then
. ./templates/t_freebsd10
fi

# If ArchBSD template
if [ $template = t_archbsd ]; then
. ./templates/t_archbsd
fi
