mkjl
====

mkjl is an attempt at a script to create FreeBSD, Debian GNU/kFreeBSD and ArchBSD jail inside a FreeBSD host. 

How does it works ? 
===================

`mkjl` creates a local template for FreeBSD, ArchBSD and Debian GNU/kFreeBSD according to the jail type. The template is then duplicated with rsync to provision the jail.

Requirements 
=============

- Tested on FreeBSD 10 i386 and amd64. 
- a working internet connection 
- git, perl5, debootstrap, rsync, pacman (from pkg or ports) 
- Enable fdescfs, linprocfs, (add fdescfs_load="YES" and linprocfs_load="YES" in /boot/loader.conf).
- a sonic screwdriver (ok, it's optional)

Install requirements
====================

```
pkg update && pkg install git perl5 debootstrap rsync pacman
```

Load modules for Debian
=======================

```
kldload fdescfs
kldload linprocfs
```

Or, persistent configuration :

```
echo fdescfs_load="YES" >> /boot/loader.conf
echo linprocfs_load="YES" >> /boot/loader.conf
```

Get mkjl
========

With git :
 
```
git clone https://github.com/src386/mkjl
```

Without git :

```
fetch --no-verify-peer https://github.com/src386/mkjl/archive/master.zip
unzip master.zip
```

Usage 
=====

```
./mkjl.sh $jailname $template 
```

Available templates :
- t_debian7 (Debian GNU/kFreeBSD Wheezy)
- t_debian8 (Debian GNU/kFreeBSD Jessie)
- t_archbsd (ArchBSD current)
- t_freebsd10 (FreeBSD 10.0-RELEASE)

Exemple :

```
./mkjl.sh www t_debian8
```

mkjl does not parse (yet) /etc/jail.conf so you have to do it manually. Take a look at the `jail.conf.example` file. Do not forget to add `jail_enable="YES"` in `/etc/rc.conf.local`.

Delete a jail :

```
chflags -R noschg /usr/jails/www && rm -rf /usr/jails/www
```

Delete everything (templates and jails) :

```
./mkclean.sh
```

Bugs
====

- t_debian7 needs to be prompted Yes manually
- openssh-server does not working on t_debian7. This is an debian Wheezy issue and probably won't be fixed. Use t_debian8 instead

TODO
====

- Better coding skills (pebkac)
- Better English
- Auto parse /etc/jail.conf

THANKS
======

- Etenil (english correction)
- Ezjail project (I took periodic.conf and rc.conf)
- ArchBSD irc
