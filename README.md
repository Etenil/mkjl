mkjl
====

mkjl is a (very bad) script to create FreeBSD, Debian GNU/kFreeBSD and ArchBSD jail inside a FreeBSD host. Ezjail is more powerfull and flexible, so if you want to use FreeBSD jails only, you definitely should use ezjail. If you want to manage Debian GNU/kFreeBSD or ArchBSD jails, please try mkjl.

How does it works ? 
===================

mkjl will create a local template for FreeBSD, ArchBSD and Debian GNU/kFreeBSD according to the jail type. Then the template will be duplicated with rsync to provision the jail. 

Requirements 
=============

- Tested on FreeBSD 10 i386 and amd64. 
- a working internet connection 
- perl5, debootstrap, rsync, pacman (from pkg or ports) 
- git (optionnal) 
- Enable fdescfs, linprocfs, tmpfs (add fdescfs_load="YES", linprocfs_load="YES" and tmpfs_load="YES" in /boot/loader.conf).
- a sonic screwdriver (ok, it's optionnal)

Installation
============
 
With git:

git clone https://github.com/src386/mkjl

Without git:

Simply copy the content of mkjl.sh from the github repository, then paste it somewhere in an executable .sh script.

Usage 
=====

./mkjl.sh $jailname $template 

Available templates :
- jessie (Debian GNU/kFreeBSD Jessie)
- arch (ArchBSD current)
- freebsd10.0 (FreeBSD 10.0-RELEASE)

Exemple :

./mkjl.sh www jessie 

mkjl does not parse (yet) /etc/jail.conf so you have to do it manually. Take a look at the jail.conf.example file. Do not forget to add jail_enable="YES" in /etc/rc.conf.local.

Bugs
====

- jessie template may fail to install because the debootstrap package is broken
- jessie jails won't start. You have to fix them with the following procedure :

(Execute on your FreeBSD host, this implies "www" is the hostname of the jail)
cp /etc/master.passwd /usr/jails/www/etc/
pwd_mkdb -d /usr/jails/www/etc -p /usr/jails/www/etc/master.passwd
jexec www bash
dpkg-reconfigure base-passwd

TODO
====

- Better coding skills (pebkac)
- Better english
- Error detection
- Deleting a jail
- Updating a jail
- Flavour support
- Automatic parse of jail.conf
- Manpage
- Fix the Jessie template
- More templates
- ZFS support
- IPv6 support
