#!/bin/bash
# Usage: apply-cert.sh [Cert_Name] [filename.[cer|der|pkcs|...]]
certutil -d sql:$HOME/.pki/nssdb -A -t TC -n "$1" -i $2
