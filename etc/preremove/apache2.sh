cygrunsrv -E httpd2

cd /etc/apache2/original
for cf in httpd.conf extra/httpd-*.conf; do
  if [ -f ../$cf ] && cmp -s $cf ../$cf; then
    rm ../$cf
  fi
done
