# Declaring the templates variables. Good practice.
mkjl_arch=""

mkjl_prepare_env ()
{
    # ArchBSD doesn't use the same arch names as FreeBSD. Translating here.
    if [ `uname -m` = amd64 ]; then
	mkjl_arch="x86_64"
    elif [ `uname -m` = i386 ]; then
	mkjl_arch="i686"
    fi
}

mkjl_prepare_fs ()
{
    # Create pacman directories
    mkdir -p /usr/jails/t_archbsd/var/lib/pacman 
    mkdir -p /usr/jails/t_archbsd/var/cache/pacman/pkg
    
    # Generate a temporary pacman.conf
    rm /tmp/pacman.conf 2>/dev/null
    echo "[options]
SigLevel = Never
[core]
Server = ftp://ftp.archbsd.net/core/os/${mkjl_arch}" >> /tmp/pacman.conf

    # Pacstrap base system
    pacman -Sy base \
	-r /usr/jails/t_archbsd \
	--noconfirm \
	--cachedir /usr/jails/t_archbsd/var/cache/pacman \
	--arch $mkjl_arch \
	--config /tmp/pacman.conf || error_exit "pacman failed to install base"
    rm /tmp/pacman.conf
}

mkjl_provision ()
{
    # Provision the jail
    rsync -Ha /usr/jails/t_archbsd/ /usr/jails/$hostname || error_exit "failed to provision the jail"
    cp /etc/resolv.conf /usr/jails/$hostname/etc/
}

mkjl_configure ()
{
    # Configure the jail
    sed "s/auto/${mkjl_arch}/g" /usr/jails/$hostname/etc/pacman.conf > /tmp/pacman.tmp \
	&& mv /tmp/pacman.tmp /usr/jails/$hostname/etc/pacman.conf
    cp /etc/resolv.conf /usr/jails/$hostname/etc/
    cp /etc/localtime /usr/jails/$hostname/etc/
    cp examples/rc.conf /usr/jails/$hostname/etc/
    cp examples/periodic.conf /usr/jails/$hostname/etc/
    
    # Populate pacman keyring inside the jail
    jail -c path=/usr/jails/$hostname mount.devfs command=/usr/bin/pacman-key --init
    jail -c path=/usr/jails/$hostname command=/usr/bin/pacman-key --populate archbsd
    
    # Clean
    umount /usr/jails/$hostname/dev 
}

