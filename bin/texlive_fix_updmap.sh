#! /bin/bash

# Users who installed texlive-collection-*-20120628-1 when
# /usr/share/texmf-site didn't exist found that the updmap-sys
# commands in the postinstall scripts failed
# (http://cygwin.com/ml/cygwin-apps/2012-08/msg00009.html).  This
# script runs those commands.

confdir=/etc/texmf/web2c
if [ ! -f ${confdir}/.updmapfix ]
then
    mkdir -pv ${confdir}
    touch ${confdir}/.updmapfix
    rm -fv /etc/postinstall/texlive-collection-basic.sh.done
    map_cmds=$(sed -n -e 's|^/usr/bin/updmap-sys --nohash --nomkmap \(--enable .*\)$|\1|p' /etc/postinstall/texlive-collection-*.sh.done)
    if [ -n "$map_cmds" ]
    then
	/usr/bin/mktexlsr
	/usr/bin/updmap-sys --nohash --nomkmap $map_cmds
	/usr/bin/updmap-sys --nohash --syncwithtrees
	/usr/bin/updmap-sys
    fi
fi
