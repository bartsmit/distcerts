#!/bin/sh
cd /root
tar xzf pems.tgz
php opnsense-import-certificate.php /root/fullchain.pem /root/privkey.pem my.domain
