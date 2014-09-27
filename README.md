mkjl
====

mkjl is an attempt at a script to create FreeBSD, Debian GNU/kFreeBSD and ArchBSD jail inside a FreeBSD host. 

How does it work? 
=================

`mkjl` creates a local template for FreeBSD, ArchBSD and Debian GNU/kFreeBSD according to the jail type. The template is then duplicated with rsync to provision the jail.

Requirements 
=============

- Tested on FreeBSD10, FreeBSD10.1 i386 and amd64. 
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
- t_gentoobsd (GentooBSD)
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

How to write a template
=======================
Templates extend the base template that can be found in `src/base_template.sh`. Mkjl proceeds to call on the following functions during jail creation:

* `mkjl_prepare_env()` is called to probe the environment and prepare variables for provisioning
* `mkjl_prepare_fs()` prepares the template's filesystem that will be cached prior to provisioning
* `mkjl_provision()` is used to do the actual provisioning of the jail from the cached template files
* `mkjl_configure()` is run after the provisioning, to configure the newly deployed jail and cleaning it up

Templates can also inherit from other templates, thus making the task of extending a template very easy. Look a the `t_debian8.sh` template for an example of this.

Bugs
====

- t_debian7 requires you to answer 'Yes' at the prompt
- openssh-server does not working on t_debian7. This is an debian Wheezy issue and probably won't be fixed. Use t_debian8 instead

TODO
====

- Better coding skills (pebkac)
- Better English
- Auto parse /etc/jail.conf

THANKS
======

- Etenil
- Ezjail project (I took periodic.conf and rc.conf)
- ArchBSD irc
