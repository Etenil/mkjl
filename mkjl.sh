#!/bin/sh
#

hostname=$1
template=$2

# Check if first run
if [ ! -d "/usr/jails" ]; then
echo "Creating /usr/jails..."
mkdir /usr/jails
fi

# If Jessie template 
if [ $template = jessie ]; then

	# Checking if Jessie template is present.
	# If not, debootstrap it.
	if [ ! -d "/usr/jails/t_jessie" ]; then
	echo "Jessie template is missing. Downloading..."
	debootstrap jessie /usr/jails/t_jessie http://cdn.debian.net/debian
	fi
	if [ -d "/usr/jails/t_jessie" ]; then
	echo "Jessie template is present."
	fi

	# Provision the Jessie jail
	echo "Creating and provision the $hostname jail..."
	rsync -Ha /usr/jails/t_jessie/ /usr/jails/$hostname

	# Configure the Jessie jail
	echo \
	"linprocfs	/proc	linprocfs	rw	0 0\
	fdescfs		/dev/fd	fdescfs		rw	0 0\
	tmpfs		/run	tmpfs		rw,noexec,nosuid	0 0\
	tmpfs		/run/lock	tmpfs	rw,noexec,nosuid	0 0\
	tmpfs		/run/shm	tmpfs	rw,noexec,nosuid	0 0"\
	>> /usr/jails/$hostname/etc/fstab.$hostname
	echo "Your jail is ready, don't forget to fix base-passwd"

fi

# If FreeBSD10.0 template
if [ $template = freebsd10.0 ]; then

	# Checking if FreeBSD10.0 template is present.
	# If not, fetch and extract it.
	if [ ! -d "/usr/jails/t_freebsd10.0" ]; then
	echo "FreeBSD10.0 template is missing. Downloading..."
	fetch ftp://ftp.freebsd.org/pub/FreeBSD/releases/amd64/10.0-RELEASE/base.txz -o /tmp/ 
	mkdir /usr/jails/t_freebsd10.0
	tar -xvzf /tmp/base.txz -C /usr/jails/t_freebsd10.0
	rm /tmp/base.txz 
	fi
	if [ -d "/usr/jails/t_freebsd10.0" ]; then
	echo "FreeBSD10.0 template is present."
	fi

	# Provision the FreeBSD10.0 jail
	echo "Creating and provision the $hostname jail..."
	rsync -Ha /usr/jails/t_freebsd10.0/ /usr/jails/$hostname

fi
