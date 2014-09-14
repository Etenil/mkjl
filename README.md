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
- perl5, debootstrap, rsync, pacman (from pkg or ports) 
- git
- Enable fdescfs, linprocfs, tmpfs (add fdescfs_load="YES", linprocfs_load="YES" and tmpfs_load="YES" in /boot/loader.conf).
- a sonic screwdriver (ok, it's optional)

Installation
============
 
```
git clone https://github.com/src386/mkjl
```

Usage 
=====

```
./mkjl.sh $jailname $template 
```

Available templates :
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

Bugs
====

- t_archbsd is to verbose, pacman output should be hidden
- t_archbsd will leave a devfs mountpoint
- t_debian8 template may fail to install because the debootstrap package is broken

TODO
====

- Better coding skills (pebkac)
- Better English
- Error handling
- Automatic parameters for localtime
- Add support for more templates

THANKS
======

- Etenil (english correction)
- Ezjail (periodic.conf and rc.conf)
- ArchBSD irc (@Amzo)
