#!/bin/sh

IP="`ip addr show dev $IF |grep inet |cut -d/ -f1 |cut -d\  -f6`"

cd /usr/local/directadmin

echo "admin:$ADMIN_PASSWORD" |chpasswd
echo "lan_ip=$IP" >>conf/directadmin.conf
echo "$IP"        >>data/admin/ip.list
echo "$IP"        >>data/users/admin/ip.list
echo "ip=$IP"     >>data/users/admin/user.conf
echo "$IP"        >>data/users/admin/user_ip.list
echo "ip=$IP"     >>scripts/setup.txt

perl -pi -e "s/ethernet_dev=.*/ethernet_dev=$IF/" conf/directadmin.conf

wget -O./conf/license.key "https://www.directadmin.com/cgi-bin/licenseupdate?lid=$LID&uid=$UID"

./directadmin
