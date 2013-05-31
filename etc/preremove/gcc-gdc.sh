#!/bin/bash

prefix=/usr
bindir=${prefix}/bin
sbindir=${prefix}/sbin
infodir=${prefix}/share/info

/usr/sbin/update-alternatives \
    --remove "gdc" "${bindir}/gdc-3.exe"


