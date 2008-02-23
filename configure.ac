dnl Configure script retroactively applied to pgplot 5.2.2,
dnl with the patches from MIRIAD applied.

AC_INIT(pgplot-miriad-remix, 5.2.2.1, miriad-dev@astro.berkeley.edu)
AC_CONFIG_SRCDIR([src/pgwnad.f])
AM_INIT_AUTOMAKE([-Wall foreign])
dnl AM_CONFIG_HEADER([config.h])

AM_MAINTAINER_MODE
AC_PROG_AWK
AC_PROG_FC
AM_PROG_LIBTOOL

dnl This should be deprecated in favor of AC_F77_WRAPPERS, but I
dnl want to touch the source code as little as possible.
dnl There are also AC_F77_DUMMY_MAIN and AC_F77_LIBRARY_LDFLAGS
dnl that at the moment do not appear to be necessary, but should
dnl be kept in mind.

AC_DEFINE([PG_PPU], [1], [Append underscores to C symbol names])

dnl Libtool treats gfortran as an F77 implementation even though
dnl it isn't. So we have to set FFLAGS to get the -Wall to appear
dnl even though by the way autoconf works we should only need to
dnl use FCFLAGS.

AM_CFLAGS="-Wall"
AM_FCFLAGS="-Wall"
AM_FFLAGS="-Wall"

AC_SUBST(AM_CFLAGS)
AC_SUBST(AM_FCFLAGS)
AC_SUBST(AM_FFLAGS)

dnl If using G77, use this flag

if test x"$G77" = xyes ; then
   AM_FFLAGS="$AM_FFLAGS -fno-backslash"
fi

dnl Some extra flag futzing that is apparently needed for OS X.

case $host_os in
  darwin*)
    SHLIB_LDFLAGS="-dynamic -Wl,-single_module"
    ;;
  solaris2.10*)
    AC_CHECK_LIB([m],[cos])
    ;;
  *)
    SHLIB_LDFLAGS=""
    ;;
esac

AC_SUBST(SHLIB_LDFLAGS)

dnl Check for Perl, needed for makehtml and maketex and fix_eps.pl

AC_PATH_PROG([PERL], [perl], [])

if test x"$PERL" = x ; then
   AC_MSG_ERROR([Perl is required to build the pgplot documentation.
If you really don't have Perl installed, contact the bug reporting
address about making the documentation optional.])
fi

AC_SUBST(PERL)

dnl Driver checks. TTDRIV, the Tektronix terminal driver.

AC_ARG_ENABLE(tektronix,
[  --disable-tektronix     Do not use the Tektronix output driver.],
[],[enableval=yes])

AC_MSG_CHECKING([whether to use the Tektronix output driver])
if test x"$enableval" = xyes ; then
   AC_MSG_RESULT([yes])
   AM_CONDITIONAL([TTDRIV_ENABLED], true)
   TTDRIV_MESSAGE="enabled"
   TTDRIV_DRVFLAG=" "
else
   AC_MSG_RESULT([no; disabled by user])
   AM_CONDITIONAL([TTDRIV_ENABLED], false)
   TTDRIV_MESSAGE="disabled"
   TTDRIV_DRVFLAG="!"
fi

AC_SUBST(TTDRIV_DRVFLAG)

dnl X Windows client and server driver.

AC_ARG_ENABLE(xwindows,
[  --disable-xwindows      Do not use the X Windows output driver, even
                          if X Windows libraries are detected. ],
[],[enableval=yes])

if test x"$enableval" = xyes ; then
   AC_PATH_XTRA

   if test x"$no_x" = xyes ; then
       use_x=false
       no_x_msg="no; X Windows libraries not detected"
   else
       use_x=true
   fi
else
   use_x=false
   no_x_msg="no; disabled by user"
fi

AC_MSG_CHECKING([whether to use the X Windows output driver])

if $use_x ; then
   AC_MSG_RESULT([yes])
   AM_CONDITIONAL([XWDRIV_ENABLED], true)
   XWDRIV_MESSAGE="enabled"
   XWDRIV_DRVFLAG=" "
   MAYBE_XWDRIV_LIBS="$X_PRE_LIBS $X_LIBS -lX11 $X_EXTRA_LIBS"
else
   AC_MSG_RESULT([$no_x_msg])
   AM_CONDITIONAL([XWDRIV_ENABLED], false)
   XWDRIV_MESSAGE="disabled"
   XWDRIV_DRVFLAG="!"
   MAYBE_XWDRIV_LIBS=
fi

dnl AC_PATH_XTRA defines: X_CFLAGS, X_LIBS, X_EXTRA_LIBS,
dnl X_PRE_LIBS

AC_SUBST(XWDRIV_DRVFLAG)
AC_SUBST(MAYBE_XWDRIV_LIBS)

dnl PNDRIV, the Portable Network Graphics driver.

AC_ARG_ENABLE(png,
[  --disable-png    Do not use the Portable Network Graphics output driver.],
[],[enableval=yes])

AC_MSG_CHECKING([whether to use the Portable Network Graphics output driver])
if test x"$enableval" = xyes ; then
   AC_MSG_RESULT([yes])
   AC_CHECK_LIB([png],[png_init_io],[
      AM_CONDITIONAL([PNDRIV_ENABLED], true)
      PNDRIV_MESSAGE="enabled"
      PNDRIV_DRVFLAG=" "
      LIBS="-lpng ${LIBS}"
   ],[
      AM_CONDITIONAL([PNDRIV_ENABLED], false)
      PNDRIV_MESSAGE="disabled (libpng not found)"
      PNDRIV_DRVFLAG="!"
   ])
else
   AC_MSG_RESULT([no; disabled by user])
   AM_CONDITIONAL([PNDRIV_ENABLED], false)
   PNDRIV_MESSAGE="disabled (by user)"
   PNDRIV_DRVFLAG="!"
fi

AC_SUBST(PNDRIV_DRVFLAG)

dnl PSDRIV, the Postscript driver.

AC_ARG_ENABLE(postscript,
[  --disable-postscript    Do not use the Postscript output driver.],
[],[enableval=yes])

AC_MSG_CHECKING([whether to use the Postscript output driver])
if test x"$enableval" = xyes ; then
   AC_MSG_RESULT([yes])
   AM_CONDITIONAL([PSDRIV_ENABLED], true)
   PSDRIV_MESSAGE="enabled"
   PSDRIV_DRVFLAG=" "
else
   AC_MSG_RESULT([no; disabled by user])
   AM_CONDITIONAL([PSDRIV_ENABLED], false)
   PSDRIV_MESSAGE="disabled"
   PSDRIV_DRVFLAG="!"
fi

AC_SUBST(PSDRIV_DRVFLAG)

dnl Done checking for drivers.

AC_CONFIG_FILES([
drivers.list
fix_eps.pl
makedoc
makehtml
maketex
Makefile
applications/Makefile
cpg/Makefile
drivers/Makefile
examples/Makefile
fonts/Makefile
src/Makefile
sys/Makefile
])

AC_CONFIG_COMMANDS([fix_eps],[chmod +x fix_eps.pl])

AC_OUTPUT

dnl Done. Summarize.

echo
echo "PGPLOT Output driver configuration summary:"
echo
echo "         Tektronix terminal: $TTDRIV_MESSAGE"
echo "                  X Windows: $XWDRIV_MESSAGE"
echo "  Portable Network Graphics: $PNDRIV_MESSAGE"
echo "                 Postscript: $PSDRIV_MESSAGE"
echo "   All other legacy drivers: disabled"
echo
