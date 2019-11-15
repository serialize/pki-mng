#!/bin/bash

mkdir -p certs

echo '{
    "CN": "Serialize Root CA",
    "key": {
        "algo": "rsa",
        "size": 4096
    },
    "names": [{
        "C": "DE",
        "ST": "BaWue",
        "L": "Stuttgart",
        "O": "Serialize",
        "OU": "IT"
    }],
    "ca": {
        "expiry": "87600h"
    }

}' | cfssl gencert -initca - | cfssljson -bare certs/ca-root

rm certs/ca-root.csr

echo '{
    "CN": "Serialize Intermediate CA",
    "key": {
        "algo": "rsa",
        "size": 4096
    },
    "names": [{
        "C": "DE",
        "ST": "BaWue",
        "L": "Stuttgart",
        "O": "Serialize",
        "OU": "IT"
    }],
    "ca": {
        "expiry": "87600h"
    }

}' | cfssl gencert -initca - | cfssljson -bare certs/ca-int

cfssl sign -ca certs/ca-root.pem -ca-key certs/ca-root-key.pem -config config.json -profile intermediate certs/ca-int.csr | cfssljson -bare certs/ca-int

rm certs/ca-int.csr

cp certs/ca-root.pem certs/ca-bundle.crt