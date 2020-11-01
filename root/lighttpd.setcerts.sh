#!/usr/bin/bash
cd /root
tar xzf pems.tgz
cat privkey.pem cert.pem > combined.pem
cp fullchain.pem /etc/pki/tls
cp combined.pem /etc/pki/tls
systemctl restart lighttpd
