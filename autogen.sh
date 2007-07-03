#!/bin/sh
#
# FIXME: check for correct versions of autotools

export LIBTOOLIZE=libtoolize
if test -x /usr/bin/glibtoolize; then
  export LIBTOOLIZE=glibtoolize
fi

$LIBTOOLIZE --copy --force
aclocal
#autoheader
autoconf
automake --add-missing --copy
