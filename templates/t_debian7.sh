mkjl_arch=""
debian_release="wheezy"

mkjl_prepare_env ()
{
    # Debian doesn't use the same arch names as FreeBSD. Translating here.
    if [ `uname -m` = "amd64" ]; then
	mkjl_arch="kfreebsd-amd64"
    elif [ `uname -m` = i386 ]; then
	mkjl_arch="kfreebsd-i386"
    fi
}

mkjl_prepare_fs ()
{
    debootstrap \
	--arch $mkjl_arch \
	$debian_release \
	/usr/jails/$template \
	http://ftp.debian.org/debian || error_exit "Failed to debootstrap wheezy"
}

mkjl_provision ()
{
    rsync -Ha /usr/jails/$template/ /usr/jails/$hostname || error_exit "Failed to provision the jail"
    cp /etc/resolv.conf /usr/jails/$hostname/etc/
}

mkjl_configure ()
{
    echo \
"proc	/usr/jails/$hostname/proc	linprocfs	rw	0 0
sys	/usr/jails/$hostname/sys	linsysfs	rw 	0 0
fdescfs	/usr/jails/$hostname/dev/fd	fdescfs		rw	0 0" \
    >> /usr/jails/$hostname/etc/fstab.$hostname
    mkdir /usr/jails/$hostname/dev/fd

    # Fix base-passwd
    cp /etc/master.passwd /usr/jails/$hostname/etc/
    pwd_mkdb -d /usr/jails/$hostname/etc -p /usr/jails/$hostname/etc/master.passwd
    jail -c path=/usr/jails/$hostname command=/usr/sbin/dpkg-reconfigure -f noninteractive base-passwd
}
