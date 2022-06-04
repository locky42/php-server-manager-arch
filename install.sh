#!/bin/bash
[ -d /var/log/sites ] || mkdir /var/log/sites
[ -d /etc/httpd/conf/extra/sites ] || mkdir /etc/httpd/conf/extra/sites
[ -d /etc/httpd/conf/extra/psm ] || mkdir /etc/httpd/conf/extra/psm

cp ./example.com.conf /etc/httpd/conf/extra/sites/example.com.conf
cp ./addhost /usr/bin/addhost
cp ./server /usr/bin/server
cp ./phpswitch /usr/bin/phpswitch
cp -R ./versions /etc/httpd/conf/extra/psm/versions
cp -R ./psm ~/.config/psm

chmod +x /usr/bin/addhost
chmod +x /usr/bin/server
chmod +x /usr/bin/phpswitch

[ -s /etc/httpd/conf/extra/psm/sites.conf ] || echo -n >> /etc/httpd/conf/extra/psm/sites.conf
echo "Include conf/extra/psm/versions/php.conf" > /etc/httpd/conf/extra/psm/version.conf

sites_include=$(grep -c "Include conf/extra/psm/sites.conf" /etc/httpd/conf/httpd.conf)
version_include=$(grep -c "Include conf/extra/psm/version.conf" /etc/httpd/conf/httpd.conf)

if [[ $sites_include == "0" ]]; then
  echo "Include conf/extra/psm/sites.conf" >> /etc/httpd/conf/httpd.conf
fi
if [[ $version_include == "0" ]]; then
  echo "Include conf/extra/psm/version.conf" >> /etc/httpd/conf/httpd.conf
fi
