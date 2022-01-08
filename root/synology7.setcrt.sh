#! /bin/bash
tar xzf pems.tgz
cp /root/*.pem /usr/syno/etc/certificate/system/default/
cd /usr/syno/etc/certificate/_archive
DEST=`ls -d -- */`
cp /root/*.pem /usr/syno/etc/certificate/_archive/$DEST
systemctl restart nginx
