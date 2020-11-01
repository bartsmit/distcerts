# distcerts
Distribute Letsencrypt certificates to hosts

A single host configured with dehydrated downloads a wildcard certificate for one or more domains.

The distcerts perl script runs nightly and compares the dehydrated SAN or wildcard certificate against the one returned by each internal host. If they are different, the script will upload the PEM files and run a script on the host to install the new certificate.

Hosts are specified in a YAML file and can have settings for:
- name
- user
- TLS port for the service using the certificate
- SSH port
- location for PEM files
- script for certificate installation

Each host must be configured with SSH keys to allow the user to log in without a password. To do this, the public key of the user running the distcerts script must be imported into ~/.ssh/authorized_keys for the user running the implementation script on the host. 

These perl modules are required:
- Sys::Syslog
- Net::SCP
- Net::OpenSSH
- Crypt::OpenSSL::PKCS12
- YAML::Tiny

The script runs an implementation script on each host which is responsible for installing the certificate. Sample scripts for:

lighttpd (e.g. Pi-Hole) with the appropriate /etc/lighttpd/external.conf as per the file list
#!/usr/bin/bash
cd /root
tar xzf pems.tgz
cat privkey.pem cert.pem > combined.pem
cp fullchain.pem /etc/pki/tls
cp combined.pem /etc/pki/tls
systemctl restart lighttpd

opnsense (relies on the php script from: https://github.com/pluspol-interactive/opnsense-import-certificate)
#!/bin/sh
cd /root
tar xzf pems.tgz
php opnsense-import-certificate.php /root/fullchain.pem /root/privkey.pem my.domain

Unifi controller on Ubuntu
#!/bin/bash
cd /root
tar xzf pems.tgz
/usr/bin/openssl pkcs12 -export -in /root/cert.pem -inkey /root/privkey.pem -certfile /root/fullchain.pem -out /root/unifi.p12 -name unifi -password pass:aircontrolenterprise
/bin/echo yes | /usr/bin/keytool -importkeystore \-deststorepass aircontrolenterprise -destkeypass aircontrolenterprise -destkeystore /usr/lib/unifi/data/keystore \-srckeystore unifi.p12 -srcstoretype PKCS12 -srcstorepass aircontrolenterprise \-alias unifi
/bin/systemctl restart unifi
