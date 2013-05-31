#!/bin/bash

prefix=/usr
bindir=${prefix}/bin
sbindir=${prefix}/sbin
infodir=${prefix}/share/info

/usr/sbin/update-alternatives \
    --remove "gpc" "${bindir}/gpc-3.exe"


