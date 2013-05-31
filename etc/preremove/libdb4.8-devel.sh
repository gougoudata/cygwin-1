incdir=/usr/include
slot=4.8

/usr/sbin/update-alternatives --remove db.h ${incdir}/db${slot}/db.h
/usr/sbin/update-alternatives --remove db4 ${incdir}/db${slot}
