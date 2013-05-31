#!/bin/sh

/usr/sbin/update-alternatives \
	--install /usr/bin/emacs emacs /usr/bin/emacs-nox.exe 10
/usr/sbin/update-alternatives \
	--install /usr/bin/emacsclient emacsclient /usr/bin/emacsclient-nox.exe 10
if [ -x /usr/bin/gtk-update-icon-cache.exe ]
then
    /usr/bin/gtk-update-icon-cache --force /usr/share/icons/hicolor
fi

/usr/bin/update-desktop-database
/usr/bin/update-mime-database /usr/share/mime

if [ ! -f /var/games/emacs/snake-scores ]
then
    /usr/bin/mkdir -p /var/games/emacs
    /usr/bin/cp /etc/defaults/var/games/emacs/snake-scores /var/games/emacs/snake-scores
fi

if [ ! -f /var/games/emacs/tetris-scores ]
then
    /usr/bin/mkdir -p /var/games/emacs
    /usr/bin/cp /etc/defaults/var/games/emacs/tetris-scores /var/games/emacs/tetris-scores
fi

