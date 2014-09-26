# t_gentoobsd must exist; if it doesn't, download and install it.
if [ ! -d "/usr/jails/t_gentoobsd" ]; then
mkdir /usr/jails/t_gentoobsd
	if [ `uname -m` = i386 ]; then
	fetch http://dev.gentoo.org/~aballier/fbsd9.0/x86/stage3-i686-freebsd-9.0.tar.bz2 \
	-o /tmp/ || error_exit "Failed to download stage3"
	tar xjpf /tmp/stage3-i686-freebsd-9.0.tar.bz2 -C /usr/jails/t_gentoobsd/ || error_exit "Failed to extract stage3"
	rm /tmp/stage3-i686-freebsd-9.0.tar.bz2
	elif [ `uname -m` = amd64 ]; then
	fetch http://distfiles.gentoo.org/experimental/bsd/freebsd/stages/amd64-fbsd-9.1/stage3-amd64-freebsd-9.1.tar.bz2 \
	-o /tmp/ || error_exit "Failed to download stage3"
	tar xjpf /tmp/stage3-amd64-freebsd-9.1.tar.bz2 -C /usr/jails/t_gentoobsd/ || error_exit "Failed to extract stage3"
	rm /tmp/stage3-amd64-freebsd-9.1.tar.bz2
	fi
fi

# Provision the jail
rsync -Ha /usr/jails/t_gentoobsd/ /usr/jails/$hostname || error_exit "Cannot provision the jail"

# Configure the jail
cp /etc/resolv.conf /usr/jails/$hostname/etc/
cp /etc/localtime /usr/jails/$hostname/etc/

# Confirm
echo "$hostname is ready"
echo "Don't forget to get portage"
