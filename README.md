# distcerts
Distribute Letsencrypt certificates to hosts

A single host configured with dehydrated downloads a wildcard certificate for one or more domains.

The distcerts perl script runs nightly and compares the dehydrated SAN or wildcard certificate against the one returned by each internal host.
If they are different, the script will upload the PEM files and run a script on the host to install the new certificate.

Hosts are specified in a YAML file and can have settings for:
- name
- user
- TLS port for the service using the certificate
- SSH port
- location for PEM files
- script for certificate installation

Each host must be configured with SSH keys to allow the user to log in without a password.
To do this, the public key of the user running the distcerts script must be imported into
~/.ssh/authorized_keys for the user running the implementation script on the host. 

These perl modules are required:
- Sys::Syslog
- Net::SCP
- Net::OpenSSH
- Crypt::OpenSSL::PKCS12
- YAML::Tiny

The script runs an implementation script on each host which is responsible for installing the certificate. Sample scripts for:


lighttpd (e.g. Pi-Hole)

see /root/lighttpd.setcerts.sh

see /etc/lighttpd/external.conf


opnsense (relies on the php script from: https://github.com/pluspol-interactive/opnsense-import-certificate)

see /root/opnsense.setcerts.sh


Unifi controller on Ubuntu

see /root/unifi.setcerts.sh
