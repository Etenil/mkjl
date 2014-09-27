mkjl_gentoo_url=""

mkjl_prepare_env ()
{
    if [ `uname -m` = i386 ]; then
	mkjl_gentoo_url="http://dev.gentoo.org/~aballier/fbsd9.0/x86/stage3-i686-freebsd-9.0.tar.bz2"
    elif [ `uname -m` = amd64 ]; then
	mkjl_gentoo_url="http://distfiles.gentoo.org/experimental/bsd/freebsd/stages/amd64-fbsd-9.1/stage3-amd64-freebsd-9.1.tar.bz2"
    fi
}

mkjl_prepare_fs ()
{
    mkdir /usr/jails/t_gentoobsd
    fetch "${mkjl_gentoo_url}" -o /tmp/gentoo_stage3.tar.bz2 || error_exit "Failed to download stage3"
    tar xjpf /tmp/gentoo_stage3.tar.bz2 -C "/usr/jails/${template}/" || error_exit "Failed to extract stage3"
    rm /tmp/gentoo_stage3.tar.bz2
}

# Provision the jail
mkjl_provision ()
{
    rsync -Ha "/usr/jails/${template}/" "/usr/jails/${hostname}" || error_exit "Cannot provision the jail"
}

mkjl_configure ()
{
    cp /etc/resolv.conf /etc/localtime "/usr/jails/${hostname}/etc/"
    echo "Don't forget to get portage"
}
