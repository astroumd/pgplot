# Process this file with 'automake' to generate 'Makefile.in'

EXTRA_DIST = pgbind.usage cpgplot.doc

noinst_PROGRAMS = pgbind cpgdemo
lib_LTLIBRARIES = libcpgplot.la
nodist_pkginclude_HEADERS = cpgplot.h
pkgdata_DATA = cpgplot.doc

# The binding files. Kind of lame to repeat the list of pg*.f 
# files, but whatever. Some of the input files do not generate outputs,
# for whatever reason. These are:
#
# pgadvance, pgaxlg, pgbegin, pgbox1, pgcl, pgcn01, pgcnsc, pgconx,
# pgcp, pgcurse, pgfunt, pgfunx, pgfuny, pghis1, pghtch, pginit,
# pglabel, pgmtext, pgncurse, pgnoto, pgnpl, pgpaper, pgpoint,
# pgptext, pgsetc, pgsize, pgtikl, pgvport, pgvsize, pgvstand,
# pgvw, pgwindow
#
# There is additionally one extra C file generated that does not
# correspond to any fortran input. This is:
#
# cpgunsa
#
# It would be nice to just be able to wildcard all the output files,
# but they won't be known at the time that the make variables are
# evaluated. (I also generally don't like wildcarding, but if you
# ran pgbind in a subdirectory, you could be sure to be not picking
# up any extra files.)
#
# Alternatively, the program could be modified to only generate a single
# output file.

bound_files = \
 ../src/pgarro.f ../src/pgask.f ../src/pgaxis.f \
 ../src/pgband.f ../src/pgbbuf.f ../src/pgbeg.f ../src/pgbin.f \
 ../src/pgbox.f ../src/pgcirc.f ../src/pgclos.f \
 ../src/pgconb.f ../src/pgconf.f ../src/pgconl.f \
 ../src/pgcons.f ../src/pgcont.f ../src/pgctab.f \
 ../src/pgcurs.f ../src/pgdraw.f ../src/pgebuf.f ../src/pgend.f \
 ../src/pgenv.f ../src/pgeras.f ../src/pgerr1.f ../src/pgerrb.f ../src/pgerrx.f \
 ../src/pgerry.f ../src/pgetxt.f \
 ../src/pggray.f ../src/pghi2d.f ../src/pghist.f \
 ../src/pgiden.f ../src/pgimag.f ../src/pglab.f \
 ../src/pglcur.f ../src/pgldev.f ../src/pglen.f ../src/pgline.f ../src/pgmove.f \
 ../src/pgmtxt.f ../src/pgncur.f \
 ../src/pgnumb.f ../src/pgolin.f ../src/pgopen.f ../src/pgpage.f \
 ../src/pgpanl.f ../src/pgpap.f ../src/pgpixl.f  \
 ../src/pgpnts.f ../src/pgpoly.f ../src/pgpt.f ../src/pgpt1.f \
 ../src/pgptxt.f ../src/pgqah.f ../src/pgqcf.f ../src/pgqch.f \
 ../src/pgqci.f ../src/pgqcir.f ../src/pgqclp.f ../src/pgqcol.f ../src/pgqcr.f \
 ../src/pgqcs.f ../src/pgqdt.f ../src/pgqfs.f ../src/pgqhs.f ../src/pgqid.f \
 ../src/pgqinf.f ../src/pgqitf.f ../src/pgqls.f ../src/pgqlw.f ../src/pgqndt.f \
 ../src/pgqpos.f ../src/pgqtbg.f ../src/pgqtxt.f ../src/pgqvp.f ../src/pgqvsz.f \
 ../src/pgqwin.f ../src/pgrect.f ../src/pgrnd.f ../src/pgrnge.f ../src/pgsah.f \
 ../src/pgsave.f ../src/pgscf.f ../src/pgsch.f ../src/pgsci.f ../src/pgscir.f \
 ../src/pgsclp.f ../src/pgscr.f ../src/pgscrl.f ../src/pgscrn.f \
 ../src/pgsfs.f ../src/pgshls.f ../src/pgshs.f ../src/pgsitf.f \
 ../src/pgslct.f ../src/pgsls.f ../src/pgslw.f ../src/pgstbg.f ../src/pgsubp.f \
 ../src/pgsvp.f ../src/pgswin.f ../src/pgtbox.f ../src/pgtext.f ../src/pgtick.f \
 ../src/pgupdt.f ../src/pgvect.f ../src/pgvsiz.f \
 ../src/pgvstd.f ../src/pgwedg.f \
 ../src/pgwnad.f

pgbind_outputs = cpgplot.h cpgunsa.c $(patsubst ../src/pg%.f,cpg%.c,$(bound_files))
pgbind_objects = $(patsubst ../src/pg%.f,cpg%.lo,$(bound_files))
BUILT_SOURCES = $(pgbind_outputs)

# pgbind helper

PGBIND_FLAGS = bsd

pgbind_SOURCES = pgbind.c

$(pgbind_outputs): pgbind.stamp

pgbind.stamp: pgbind $(bound_files)
	$(AM_V_GEN)./pgbind $(PGBIND_FLAGS) -h -w $(filter-out pgbind,$^) ; touch $@

CLEANFILES = pgbind.stamp $(pgbind_outputs)

# The C binding library. With automake-1.9 at least, the source
# files discovered by the patsubst in pgbind_outputs aren't picked
# up for some reason, so we explicitly add them via pgbind_objects

nodist_libcpgplot_la_SOURCES = $(pgbind_outputs)
libcpgplot_la_LIBADD = ../libpgplot.la $(pgbind_objects)

# Demo

cpgdemo_SOURCES = cpgdemo.c
cpgdemo_LDADD = ../libpgplot.la libcpgplot.la $(FLIBS) -lm
