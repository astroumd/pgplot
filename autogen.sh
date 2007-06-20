#!/bin/sh
#
# FIXME: check for correct versions of autotools

libtoolize --copy --force
aclocal
#autoheader
autoconf
automake --add-missing --copy
