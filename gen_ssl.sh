#!/bin/bash

name=server
our_name=server-$(date +%s)
our_crt=${our_name}.crt
our_key=${our_name}.key
our_passkey=${our_name}.pass.key
our_csr=${our_name}.csr

openssl genrsa \
  -des3 \
  -passout pass:x \
  -out ${our_passkey} \
  2048 \
  &> /dev/null

openssl rsa \
  -passin pass:x \
  -in ${our_passkey}\
  -out ${our_key} \
  &> /dev/null

openssl req \
  -new \
  -key ${our_key} \
  -out ${our_csr} \
  -subj "/C=US/ST=Texas/L=Austin/O=Out Systems/OU=IT/CN=k0s.local" \
  &> /dev/null

openssl x509 \
  -req \
  -sha256 \
  -days 365 \
  -in ${our_csr} \
  -signkey ${our_key} \
  -out ${our_crt} \
  &> /dev/null

sudo security add-trusted-cert \
  -d \
  -r trustRoot \
  -k /Library/Keychains/System.keychain \
  ./${our_crt}

sudo security find-certificate \
  -c k0s.local \
  -a \
  -Z 

sudo security delete-certificate \
  -c k0s.local

rm \
  ${our_crt} \
  ${our_passkey} \
  ${our_csr} \
  ${our_key}
