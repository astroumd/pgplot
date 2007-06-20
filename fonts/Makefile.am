# Process this file with 'automake' to generate 'Makefile.in'

pkgdata_DATA = grfont.dat
noinst_PROGRAMS = pgpack

pgpack_SOURCES = pgpack.f

grfont.dat: grfont.txt pgpack
	rm -f $@
	./pgpack <$<

EXTRA_DIST = aaaread.me grfont.txt pgdchar.f pgunpack.f
CLEANFILES = grfont.dat
