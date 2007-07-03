#!/bin/sh
#
# FIXME: check for correct versions of autotools

if test "x$LIBTOOLIZE" = x; then
  export LIBTOOLIZE=libtoolize
  # Determine if this is Mac OS X and react appropriately...
  if test -x /usr/bin/glibtoolize; then
    export LIBTOOLIZE=glibtoolize
  fi
fi

$LIBTOOLIZE --copy --force
aclocal
#autoheader
autoconf
automake --add-missing --copy
