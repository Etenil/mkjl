mkjl
====

mkjl is a (very bad) script to create FreeBSD, Debian GNU/kFreeBSD and ArchBSD jail inside a FreeBSD host. Ezjail is more powerfull and flexible, so if you want to use FreeBSD jails only, you definitely should use ezjail. If you want to manage Debian GNU/kFreeBSD or ArchBSD jails, please try mkjl.

How does it works ? 
===================

mkjl will create a local template for FreeBSD, ArchBSD and Debian GNU/kFreeBSD according to the jail type. Then the template will be duplicated with rsync to provision the jail. Finally, mkjl will write the jail configuration in /etc/jail.conf. You just have to add jail_enable="YES" into /etc/rc.conf.local then the jail daemon. 

Requirements 
=============

- Tested on FreeBSD 10 i386 and amd64. 
- a working internet connection 
- perl5, debootstrap, rsync, pacman (use pkg or ports) 
- git (optionnal, to fetch mkjl) 
- Enable fdescfs, linprocfs, tmpfs.
- mkjl is not (yet) compatible with ezjail or jail.conf so be careful
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

Available templates: freebsd10.0, arch, jessie (wheezy is not included because of blocking bugs)

Exemple :

./mkjl.sh www jessie

Then start the jail daemon.

Bugs
====

- jessie template does not working, because of a broken deboostrap package. I hope this will be fixed soon.
- kfreebsd jails won't start, you need to fix it manually (see "kfreebsd jail fix")

kfreebsd jail fix ('www' is the name of the jail):
cp /etc/master.passwd /usr/jails/www/etc/
pwd_mkdb -d /usr/jails/www/etc -p /usr/jails/www/etc/master.passwd
Then, start your jail, and run :
jexec www bash
dpkg-reconfigure base-passwd

TODO
====

- Better coding skills (pebkac)
- Better english
- Template cleaning function
- Error detection
- Deleting a jail
- Updating a jail
- Flavour support
- Manpage
- Fix the Jessie template
- More templates
- ZFS support
- IPv6 support
