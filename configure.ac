dnl Configure script retroactively applied to pgplot 5.2.2,
dnl with the patches from MIRIAD applied.

AC_PREREQ(2.59)
AC_INIT(pgplot-miriad-remix, 5.2.2.1, miriad-dev@astro.berkeley.edu)
AC_REVISION([$Revision$])

AC_CONFIG_SRCDIR([src/pgwnad.f])
AC_CONFIG_MACRO_DIR([.])
dnl As far as I can tell we don't need Automake newer than 1.9, and
dnl could probably even get away with earlier versions.
AM_INIT_AUTOMAKE([1.9 -Wobsolete -Wgnu -Wunsupported -Wno-syntax -Wno-portability
                  foreign subdir-objects])

AM_MAINTAINER_MODE
AC_PROG_AWK
AC_PROG_F77
AC_PROG_FC
AM_PROG_LIBTOOL

dnl PG_PPU should be deprecated in favor of AC_F77_WRAPPERS, but I want
dnl to touch the source code as little as possible.  There is also
dnl AC_F77_DUMMY_MAIN that at the moment does not appear to be
dnl necessary, but should be kept in mind.

AC_F77_LIBRARY_LDFLAGS
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

dnl Some compiler checks

AC_LANG_PUSH([Fortran 77])
AX_CHECK_COMPILE_FLAG([-fno-backslash], [AM_FFLAGS="$AM_FFLAGS -fno-backslash"])

dnl %val() needed for GIF driver
AC_MSG_CHECKING([Whether the fortran compiler handles %val()])
AC_COMPILE_IFELSE([AC_LANG_SOURCE([[
	subroutine foo
	integer map
	call bar(%val(map))
	end
]])],[val_ok="yes"],[val_ok="no"])
AC_MSG_RESULT([$val_ok])
AC_LANG_POP([Fortran 77])
AC_SUBST(val_ok)


dnl Platform-specific flag futzing.

case $host_os in
  solaris2.10*)
    AC_CHECK_LIB([m],[cos])
    ;;
esac

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

dnl Driver checks. GIDRIV, the GIF driver.

AC_ARG_ENABLE(gif,
[  --disable-gif           Do not use the GIF output driver.],
[],[enableval=$val_ok])

AC_MSG_CHECKING([whether to use the GIF output driver])
if test x"$enableval" = xyes ; then
   AC_MSG_RESULT([yes])
   AM_CONDITIONAL([GIDRIV_ENABLED], true)
   GIDRIV_MESSAGE="enabled"
   GIDRIV_DRVFLAG=" "
else
   AC_MSG_RESULT([no; disabled by user])
   AM_CONDITIONAL([GIDRIV_ENABLED], false)
   GIDRIV_MESSAGE="disabled"
   GIDRIV_DRVFLAG="!"
fi

AC_SUBST(GIDRIV_DRVFLAG)

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
[  --disable-png           Do not use the Portable Network Graphics output driver.],
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


EDIT_WARNING="Do not edit this file, it has been generated by configure"
AC_SUBST(EDIT_WARNING)

dnl Done checking for drivers.

AC_CONFIG_FILES([
autodrivers.list
autofix_eps.pl
automakedoc
automakehtml
automaketex
Makefile
applications/Makefile
cpg/Makefile
drivers/Makefile
examples/Makefile
fonts/Makefile
src/Makefile
sys/Makefile
])

AC_CONFIG_COMMANDS([fix_eps],[chmod +x autofix_eps.pl])

AC_OUTPUT

dnl Done. Summarize.

echo
echo "PGPLOT Output driver configuration summary:"
echo
echo "         Tektronix terminal: $TTDRIV_MESSAGE"
echo "                  X Windows: $XWDRIV_MESSAGE"
echo "  Portable Network Graphics: $PNDRIV_MESSAGE"
echo "                        GIF: $GIDRIV_MESSAGE"
echo "                 Postscript: $PSDRIV_MESSAGE"
echo "   All other legacy drivers: disabled"
echo
