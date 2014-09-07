#!/bin/sh
#

# Define variables
hostname=$1
template=$2

# Detect architecture
if [ `uname -m` = amd64 ]; then
arch1=x86_64
arch2=kfreebsd-amd64
elif [ `uname -m` = i386 ]; then
arch1=i686
arch2=kfreebsd-i386
fi

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
debootstrap --arch $arch2 jessie /usr/jails/t_jessie http://cdn.debian.net/debian
fi
if [ -d "/usr/jails/t_jessie" ]; then
echo "Jessie template is present."
fi

# Provision the Jessie jail
echo "Creating and provisioning the $hostname jail..."
rsync -Ha /usr/jails/t_jessie/ /usr/jails/$hostname

# Configure the Jessie jail
printf \
"linprocfs       /usr/jails/$hostname/proc           linprocfs       rw      0 0
fdescfs         /usr/jails/$hostname/dev/fd         fdescfs         rw      0 0
tmpfs           /usr/jails/$hostname/run            tmpfs           rw,noexec,nosuid    0 0
tmpfs           /usr/jails/$hostname/run/lock       tmpfs           rw,noexec,nosuid    0 0
tmpfs           /usr/jails/$hostname/run/shm        tmpfs           rw,noexec,nosuid    0 0"\
>> /usr/jails/$hostname/etc/fstab.$hostname
echo "Your jail is ready, don't forget to fix base-passwd"
fi

# If FreeBSD10.0 template
if [ $template = freebsd10.0 ]; then

# Checking if FreeBSD10.0 template is present.
# If not, fetch and extract it.
if [ ! -d "/usr/jails/t_freebsd10.0" ]; then
echo "FreeBSD10.0 template is missing. Downloading..."
fetch ftp://ftp.freebsd.org/pub/FreeBSD/releases/`uname -m`/10.0-RELEASE/base.txz -o /tmp/ 
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
echo "Your jail is ready"
fi

# If ArchBSD template
if [ $template = arch ]; then

# Checking if ArchBSD template is present.
# If not, download and install it.
if [ ! -d "/usr/jails/t_arch" ]; then
echo "Arch template is missing. Downloading..."
mkdir -p /usr/jails/t_arch/var/lib/pacman
mkdir -p /usr/jails/t_arch/var/cache/pacman/pkg
pacman-key --init
pacman -Sy base \
-r /usr/jails/t_arch \
--noconfirm \
--cachedir /usr/jails/t_arch/var/cache/pacman \
--arch x86_64 \
--config ./src/pacman.conf
fi
if [ -d "/usr/jails/t_arch" ]; then
echo "Arch template is present."
fi

# Provision the ArchBSD jail
echo "Creating and provisionning the $hostname jail..."
rsync -Ha /usr/jails/t_arch/ /usr/jails/$hostname
echo "Your jail is ready"
fi
