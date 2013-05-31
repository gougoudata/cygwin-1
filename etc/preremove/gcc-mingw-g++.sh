#!/bin/sh
[ -f /etc/preremove/gcc-mingw-g++-manifest.lst ] || exit 0
echo "*** Removing gcc-mingw-g++ files.  Please wait. ***"
cd /usr
(while read LN
do
  if [ -e $LN -o -h $LN ]
  then
    if [ -f $LN -o -h $LN ]
    then
      echo rm -f ${LN}
      rm -f $LN 2>/dev/null
      if [ $? -ne 0 ]
      then
        echo "File or symbolic link ${LN} can't be removed."
      fi
    elif [ -d $LN ]
    then
      echo rmdir $LN
      rmdir $LN 2>/dev/null
      if [ $? -ne 0 ]
      then
        echo "Directory ${LN} is not empty; skipping."
      fi
    fi
  else
    echo "${LN} already removed."
  fi
done) < /etc/preremove/gcc-mingw-g++-manifest.lst
echo 'rm -f /etc/preremove/gcc-mingw-g++-manifest.lst' 
rm -f /etc/preremove/gcc-mingw-g++-manifest.lst 

