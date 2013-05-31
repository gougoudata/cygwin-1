#!/bin/sh
# This script will remove the symbolic links in the toplevel include
# directory, pointing to files 'hidden' in the ncursesw subdirectory.
prefix=/usr
bindir=${prefix}/bin
incdir=${prefix}/include
libdir=${prefix}/lib

(cd ${incdir}/ncursesw;
  rm -f curses.h
)
(cd ${libdir}; 
  cd ncursesw
  for f in form menu ncurses++ ncurses panel tic
  do
    rm -f lib${f}w.a
    rm -f lib${f}w.la
    rm -f lib${f}w.dll.a
    rm -f lib$f.a
    rm -f lib$f.la
    rm -f lib$f.dll.a
    rm -f pkgconfig/${f}w.pc
    rm -f pkgconfig/$f.pc
  done
  rm -f libcurses.dll.a
  rm -f libcurses.a
)
(cd ${bindir};rm -f ncursesw5-config)
#!/bin/sh
# This script will remove the symbolic links in the toplevel include
# directory, pointing to files 'hidden' in the ncursesw subdirectory.
prefix=/usr
bindir=${prefix}/bin
incdir=${prefix}/include
libdir=${prefix}/lib

(cd ${incdir}/ncursesw;
  rm -f curses.h
)
(cd ${libdir}; 
  cd ncursesw
  for f in form menu ncurses++ ncurses panel tic
  do
    rm -f lib${f}w.a
    rm -f lib${f}w.la
    rm -f lib${f}w.dll.a
    rm -f lib$f.a
    rm -f lib$f.la
    rm -f lib$f.dll.a
    rm -f pkgconfig/${f}w.pc
    rm -f pkgconfig/$f.pc
  done
  rm -f libcurses.dll.a
  rm -f libcurses.a
)
(cd ${bindir};rm -f ncursesw5-config)
