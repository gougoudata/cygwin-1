#!/bin/bash

prefix=/usr
bindir=${prefix}/bin
sbindir=${prefix}/sbin
infodir=${prefix}/share/info

/usr/sbin/update-alternatives \
    --remove "g++" "${bindir}/g++-3.exe"


