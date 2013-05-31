GENCCODE_ASSEMBLY_TYPE=-a gcc-cygwin
SO=dll
SOBJ=dll
A=a
LIBPREFIX=lib
LIB_EXT_ORDER=48.dll
COMPILE=gcc-4 -D_REENTRANT -DU_ATTRIBUTE_DEPRECATED= -g -O2 -pipe  -Wall -ansi -pedantic -Wshadow -Wpointer-arith -Wmissing-prototypes -Wwrite-strings -Wno-long-long  -c
LIBFLAGS=-I/usr/include -DPIC 
GENLIB=gcc-4 -g -O2 -pipe  -Wall -ansi -pedantic -Wshadow -Wpointer-arith -Wmissing-prototypes -Wwrite-strings -Wno-long-long   -shared -Wl,-Bsymbolic -Wl,--enable-auto-import -Wl,--out-implib=all.a
LDICUDTFLAGS=
LD_SONAME=
RPATH_FLAGS=
BIR_LDFLAGS=-Wl,-Bsymbolic
AR=ar
ARFLAGS=r
RANLIB=ranlib
INSTALL_CMD=/usr/bin/install -c
