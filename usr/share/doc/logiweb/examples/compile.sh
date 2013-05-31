#!/bin/bash
DIR=`mktemp -d /tmp/lgc.compile.XXXXXXXXXX` || exit 1
echo Temporary directory: $DIR
cp * $DIR
cd $DIR
find * -name "*.gz" -exec gunzip '{}' \;
lgc base
lgc lgc
lgc combinations
lgc check
lgc test
lgc Peano
lgc multzero
lgc testmachine
