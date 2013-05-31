if [ -f /usr/lib/logging.properties ] && cmp -s /etc/defaults/usr/lib/logging.properties /usr/lib/logging.properties
then
    rm /usr/lib/logging.properties
fi

if [ -f /usr/lib/security/classpath.security ] && cmp -s /etc/defaults/usr/lib/security/classpath.security /usr/lib/security/classpath.security
then
    rm /usr/lib/security/classpath.security
fi

