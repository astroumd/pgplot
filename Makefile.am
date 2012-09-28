# Process this file with 'automake' to generate 'Makefile.in'

ACLOCAL_AMFLAGS = -I .

# Might include pgdisp in SUBDIRS, but it doesn't build trivially,
# and I bet no one uses the xdisp driver anyway.

SUBDIRS = fonts drivers sys src . cpg examples applications

EXTRA_DIST = \
 copyright.notice grexec.awk rgb.txt \
 pgplot-config.sh.in pgplot-config.csh.in \
 README.carma readme_fix_eps.txt \
 ver500.txt ver501.txt ver502.txt ver503.txt \
 ver510.txt ver511.txt ver520.txt ver521.txt \
 ver522.txt

lib_LTLIBRARIES = libpgplot.la

libexec_PROGRAMS = $(XWDRIV_SERVER)

pkgdata_DATA = \
 rgb.txt pgplot-routines.tex pgplot.html pgplot.doc \
 autofix_eps.pl

# Our generated version of fix_eps.pl is called autofix_eps.pl,
# to not overwrite the CVS-stored file that's used in the 
# classic build system. On installation, however, we link 
# autofix_eps.pl to fix_eps.pl, to maintain compatibility.
# The scripts are textual and platform-independent so the
# correct hook is install-data-hook, not install-exec-hook.

install-data-hook:
	cd $(DESTDIR)$(pkgdatadir) && rm -f fix_eps.pl && \
	  $(LN_S) autofix_eps.pl fix_eps.pl

uninstall-hook:
	rm -f $(DESTDIR)$(pkgdatadir)/fix_eps.pl

# These go into pkglibdir since they point to the directory
# that pgxwin_server lives in, and hence these scripts are *not*
# arch-independent.

# Automake >~ 1.11.3 doesn't like DATA in pkglibdir (??)
mypkglibdir = $(pkglibdir)
mypkglib_DATA = \
 pgplot-config.sh pgplot-config.csh

CLEANFILES = \
 grexec.f pgplot-routines.tex pgplot.html pgplot.doc \
 pgplot-config.sh pgplot-config.csh \
 autodrivers.list.cur

# Driver dispatcher file. We perform some convolutions here to
# not unneccessarily update grexec.f, since doing so will
# force us to rebuild everything. (An unneccessary update might
# be cause by config.status being executed.)

grexec.f: grexec.awk autodrivers.list.cur
	$(AM_V_GEN)$(AWK) -f $< autodrivers.list.cur >$@

autodrivers.list.cur: autodrivers.list
	$(AM_V_at)if test ! -f autodrivers.list.cur ; then \
		cp $< autodrivers.list.cur ; \
	elif cmp -s $< autodrivers.list.cur ; then \
		: ; \
	else \
		cp $< autodrivers.list.cur ; \
	fi

# Conditional driver sources.

if TTDRIV_ENABLED
TTDRIV_SOURCES = drivers/ttdriv.f
else
TTDRIV_SOURCES = 
endif

if GIDRIV_ENABLED
GIDRIV_SOURCES = drivers/gidriv.f
else
GIDRIV_SOURCES = 
endif

if XWDRIV_ENABLED
XWDRIV_SOURCES = drivers/xwdriv.c
XWDRIV_CFLAGS = $(X_CFLAGS)
XWDRIV_SERVER = pgxwin_server
else
XWDRIV_SOURCES = 
XWDRIV_CFLAGS = 
XWDRIV_SERVER = 
endif

if PNDRIV_ENABLED
PNDRIV_SOURCES = drivers/pndriv.c
else
PNDRIV_SOURCES = 
endif

if PSDRIV_ENABLED
PSDRIV_SOURCES = drivers/psdriv.f
else
PSDRIV_SOURCES = 
endif

# The main event.

libpgplot_la_CFLAGS = $(XWDRIV_CFLAGS)
libpgplot_la_LIBADD = $(MAYBE_XWDRIV_LIBS)

PG_SOURCES = \
 src/pgadvance.f src/pgarro.f src/pgask.f src/pgaxis.f src/pgaxlg.f \
 src/pgband.f src/pgbbuf.f src/pgbeg.f src/pgbegin.f src/pgbin.f \
 src/pgbox.f src/pgbox1.f src/pgcirc.f src/pgcl.f src/pgclos.f \
 src/pgcn01.f src/pgcnsc.f src/pgconb.f src/pgconf.f src/pgconl.f \
 src/pgcons.f src/pgcont.f src/pgconx.f src/pgcp.f src/pgctab.f \
 src/pgcurs.f src/pgcurse.f src/pgdraw.f src/pgebuf.f src/pgend.f \
 src/pgenv.f src/pgeras.f src/pgerr1.f src/pgerrb.f src/pgerrx.f \
 src/pgerry.f src/pgetxt.f src/pgfunt.f src/pgfunx.f src/pgfuny.f \
 src/pggray.f src/pghi2d.f src/pghis1.f src/pghist.f src/pghtch.f \
 src/pgiden.f src/pgimag.f src/pginit.f src/pglab.f src/pglabel.f \
 src/pglcur.f src/pgldev.f src/pglen.f src/pgline.f src/pgmove.f \
 src/pgmtext.f src/pgmtxt.f src/pgncur.f src/pgncurse.f src/pgnoto.f \
 src/pgnpl.f src/pgnumb.f src/pgolin.f src/pgopen.f src/pgpage.f \
 src/pgpanl.f src/pgpap.f src/pgpaper.f src/pgpixl.f src/pgplot.inc \
 src/pgpnts.f src/pgpoint.f src/pgpoly.f src/pgpt.f src/pgpt1.f \
 src/pgptext.f src/pgptxt.f src/pgqah.f src/pgqcf.f src/pgqch.f \
 src/pgqci.f src/pgqcir.f src/pgqclp.f src/pgqcol.f src/pgqcr.f \
 src/pgqcs.f src/pgqdt.f src/pgqfs.f src/pgqhs.f src/pgqid.f \
 src/pgqinf.f src/pgqitf.f src/pgqls.f src/pgqlw.f src/pgqndt.f \
 src/pgqpos.f src/pgqtbg.f src/pgqtxt.f src/pgqvp.f src/pgqvsz.f \
 src/pgqwin.f src/pgrect.f src/pgrnd.f src/pgrnge.f src/pgsah.f \
 src/pgsave.f src/pgscf.f src/pgsch.f src/pgsci.f src/pgscir.f \
 src/pgsclp.f src/pgscr.f src/pgscrl.f src/pgscrn.f src/pgsetc.f \
 src/pgsfs.f src/pgshls.f src/pgshs.f src/pgsitf.f src/pgsize.f \
 src/pgslct.f src/pgsls.f src/pgslw.f src/pgstbg.f src/pgsubp.f \
 src/pgsvp.f src/pgswin.f src/pgtbox.f src/pgtext.f src/pgtick.f \
 src/pgtikl.f src/pgupdt.f src/pgvect.f src/pgvport.f src/pgvsiz.f \
 src/pgvsize.f src/pgvstand.f src/pgvstd.f src/pgvw.f src/pgwedg.f \
 src/pgwindow.f src/pgwnad.f

libpgplot_la_SOURCES = \
 grexec.f \
 \
 src/grarea.f src/grbpic.f src/grchar.f src/grchr0.f src/grchsz.f \
 src/grclip.f src/grclos.f src/grclpl.f src/grctoi.f src/grcurs.f \
 src/grdat2.f src/grdot0.f src/grdot1.f src/grdtyp.f src/grepic.f \
 src/gresc.f src/gretxt.f src/grfa.f src/grfao.f src/grgfil.f \
 src/grgray.f src/grgtc0.f src/grimg0.f src/grimg1.f src/grimg2.f \
 src/grimg3.f src/grinit.f src/grinqfont.f src/grinqli.f src/grinqpen.f \
 src/gritoc.f src/grldev.f src/grlen.f src/grlin0.f src/grlin1.f \
 src/grlin2.f src/grlin3.f src/grlina.f src/grlinr.f src/grmark.f \
 src/grmcur.f src/grmker.f src/grmova.f src/grmovr.f src/grmsg.f \
 src/gropen.f src/grpage.f src/grpars.f src/grpckg1.inc src/grpixl.f \
 src/grpocl.f src/grprom.f src/grpxpo.f src/grpxps.f src/grpxpx.f \
 src/grpxre.f src/grqcap.f src/grqci.f src/grqcol.f src/grqcr.f \
 src/grqdev.f src/grqdt.f src/grqfnt.f src/grqls.f src/grqlw.f \
 src/grqpos.f src/grqtxt.f src/grqtyp.f src/grquit.f src/grrec0.f \
 src/grrect.f src/grsci.f src/grscr.f src/grscrl.f src/grsetc.f \
 src/grsetfont.f src/grsetli.f src/grsetpen.f src/grsets.f src/grsfnt.f \
 src/grsize.f src/grskpb.f src/grslct.f src/grsls.f src/grslw.f \
 src/grsyds.f src/grsymk.f src/grsyxd.f src/grterm.f src/grtext.f \
 src/grtoup.f src/grtran.f src/grtrim.f src/grtrn0.f src/grtxy0.f \
 src/grvct0.f src/grvect.f src/grwarn.f src/grxhls.f src/grxrgb.f \
 \
 $(PG_SOURCES) \
 \
 src/grpckg1.inc src/pgplot.inc \
 \
 sys/grdate.c sys/grfileio.c sys/grflun.f sys/grgcom.f sys/grgenv.f \
 sys/grgetc.c sys/grglun.f sys/grgmem.c sys/grgmsg.f sys/grlgtr.f \
 sys/groptx.f sys/grsy00.f sys/grtermio.c sys/grtrml.f sys/grtter.f \
 sys/gruser.c \
 \
 drivers/nudriv.f $(TTDRIV_SOURCES) $(GIDRIV_SOURCES) $(XWDRIV_SOURCES) \
 $(PNDRIV_SOURCES) $(PSDRIV_SOURCES)

# pgxwin_server

pgxwin_server_CFLAGS = $(X_CFLAGS)
pgxwin_server_LDADD = $(MAYBE_XWDRIV_LIBS)
pgxwin_server_SOURCES = drivers/pgxwin_server.c

# Data

pgplot-routines.tex: automaketex $(PG_SOURCES)
	$(AM_V_GEN)$(PERL) $< $(filter-out automaketex,$^) >$@

pgplot.html: automakehtml $(PG_SOURCES)
	$(AM_V_GEN)$(PERL) $< $(filter-out automakehtml,$^) >$@

pgplot.doc: automakedoc $(PG_SOURCES)
	$(AM_V_GEN)$(SHELL) $< $(filter-out automakedoc,$^) >$@

pgplot-config.sh: pgplot-config.sh.in config.status
	$(AM_V_GEN)sed -e "s,%libexecdir%,$(libexecdir)," \
	               -e "s,%pkgdatadir%,$(pkgdatadir)," \
	               <$< >$@

pgplot-config.csh: pgplot-config.csh.in config.status
	$(AM_V_GEN)sed -e "s,%libexecdir%,$(libexecdir)," \
	               -e "s,%pkgdatadir%,$(pkgdatadir)," \
	               <$< >$@

# MIRIAD documentation. Hackity hack. We need to override
# some variables because our top_srcdir and package variables
# are different than what mircommon expects.

include $(top_srcdir)/../../mircommon.mak

doc_catsrc = $(top_srcdir)/../../cat
doc_prog = $(top_builddir)/../../src/tools/doc
mirdocdir = $(datadir)/miriad/doc

DOCINPUTS = $(libpgplot_la_SOURCES)
include $(top_srcdir)/../../mirdoc_noprog.mak

$(doc_prog):
	$(MAKE) -C $(dir $@) $(notdir $@)
