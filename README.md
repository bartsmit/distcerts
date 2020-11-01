# distcerts
Distribute Letsencrypt certificates to hosts

A single host configured with dehydrated downloads a wildcard certificate for one or more domains.

The distcerts perl script runs nightly and compares the dehydrated SAN or wildcard certificate against the one returned by each internal host. If they are different, the script will upload the PEM files and run a script on the host to install the new certificate.

Hosts are specified in a YAML file and can have settings for:
- name
- TLS port for the service using the certificate
- SSH port
- location for PEM files
- script for certificate installation
