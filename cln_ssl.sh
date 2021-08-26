#!/bin/bash

name=${1}
our_name=${name}
our_crt=${our_name}.crt
our_key=${our_name}.key
our_passkey=${our_name}.pass.key
our_csr=${our_name}.csr

canon_name=k0s.local

sudo security find-certificate \
  -c ${canon_name} \
  -a \
  -Z 

sudo security delete-certificate \
  -c ${canon_name}

rm \
  ${our_crt} \
  ${our_passkey} \
  ${our_csr} \
  ${our_key}
