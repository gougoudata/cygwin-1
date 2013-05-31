#!/bin/sh
# This script will create symbolic links in the toplevel include
# directory, pointing to files 'hidden' in the ncurses subdirectory.
prefix=/usr
bindir=${prefix}/bin
incdir=${prefix}/include
libdir=${prefix}/lib

(cd ${incdir}/ncurses;
  ln -fs curses.h ncurses.h
)
(cd ${libdir}; 
  rm -f libcurses.dll.a ; ln -fs libncurses.dll.a libcurses.dll.a ;
  rm -f libcurses.a     ; ln -fs libncurses.a libcurses.a ;
  mkdir -p ncurses
  cd ncurses
  mkdir -p pkgconfig
  for f in form menu ncurses++ ncurses panel tic
  do
    ln -fs ../lib$f.a .
    ln -fs ../lib$f.la .
    ln -fs ../lib$f.dll.a .
    ln -fs ../../pkgconfig/$f.pc pkgconfig/
  done
  ln -fs ../libncurses.dll.a libcurses.dll.a
  ln -fs ../libncurses.a     libcurses.a
)
(cd ${bindir}; ln -fs ncurses6-config ncurses5-config)
