#!/bin/sh
#
# FIXME: check for correct versions of autotools

echo "HINT: You should only be running this script if you know exactly what "
echo " it does. If that's not the case, you should download an official release "
echo " of this package and run its \`configure' script to build the software."
echo

set -e -x

libtoolize --copy --force
aclocal
#autoheader
autoconf
automake --add-missing --copy
