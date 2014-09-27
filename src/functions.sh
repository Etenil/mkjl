# Break on error
error_exit ()
{
    echo "$1" 1>&2

    if [ $# -lt 2 ]; then
	exit 1
    else
	exit $2
    fi
}
