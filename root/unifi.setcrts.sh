#!/bin/bash
cd /root
tar xzf pems.tgz
/usr/bin/openssl pkcs12 -export -in /root/cert.pem -inkey /root/privkey.pem -certfile /root/fullchain.pem -out /root/unifi.p12 -name unifi -password pass:aircontrolenterprise
/bin/echo yes | /usr/bin/keytool -importkeystore \-deststorepass aircontrolenterprise -destkeypass aircontrolenterprise -destkeystore /usr/lib/unifi/data/keystore \-srckeystore unifi.p12 -srcstoretype PKCS12 -srcstorepass aircontrolenterprise \-alias unifi
/bin/systemctl restart unifi
