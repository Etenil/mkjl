# t_freebsd10 must exist; if it doesn't, download and install it.

mkjl_prepare_fs ()
{
    fetch ftp://ftp.freebsd.org/pub/FreeBSD/releases/`uname -m`/10.0-RELEASE/base.txz \
	-o /tmp/ || error_exit "Cannot download base.txz"
    mkdir /usr/jails/t_freebsd10
    tar -xvzf /tmp/base.txz -C /usr/jails/t_freebsd10
    rm /tmp/base.txz
}

# Provision the jail
mkjl_provision ()
{
    rsync -Ha /usr/jails/t_freebsd10/ /usr/jails/$hostname || error_exit "Cannot provision the jail"
}

# Configure the jail
mkjl_configure ()
{
    cp /etc/resolv.conf /usr/jails/$hostname/etc/
    cp /etc/localtime /usr/jails/$hostname/etc/
    cp examples/rc.conf /usr/jails/$hostname/etc/
    cp examples/periodic.conf /usr/jails/$hostname/etc/
}

