#! /bin/csh -f
#
#  this script converts 3 essential INTEGER*4 pointers in the use
#  of the non-ANSI style use of %ref(integer-pointer) to INTEGER*8
#  needed on 64 bit machines.
#  The code of the 3 routines was slightly modified from the original
#  PGPLOT distribution to make the sed command a little more robust.
#
#  Notice these files cannot be compiled with gfortran, only with g77.
#
#  26-sep-2006    Created                                 Peter Teuben
#
#

foreach file (gidriv.f ppdriv.f wddriv.f)
  echo "Fixing $file from INTEGER*4 PIXMAP to INTEGER*8 PIXMAP for 64 bit"
  set o=$file.orig
  mv $file $o
  sed s/'INTEGER\*4 PIXMAP'/'INTEGER*8 PIXMAP'/ $o > $file
end
