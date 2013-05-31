#!/bin/sh

prefix=/usr
bindir=${prefix}/bin
sbindir=${prefix}/sbin

${sbindir}/update-alternatives \
	--remove emacs ${bindir}/emacs-nox.exe
${sbindir}/update-alternatives \
	--remove emacsclient ${bindir}/emacsclient-nox.exe
if [ -f /var/games/emacs/snake-scores ] && cmp -s /etc/defaults/var/games/emacs/snake-scores /var/games/emacs/snake-scores
then
    rm /var/games/emacs/snake-scores
fi

if [ -f /var/games/emacs/tetris-scores ] && cmp -s /etc/defaults/var/games/emacs/tetris-scores /var/games/emacs/tetris-scores
then
    rm /var/games/emacs/tetris-scores
fi

