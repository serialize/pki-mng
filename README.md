## generate certificates

```

cd cfssl-api

mkdir certs
chmod 777 certs

docker run -it --rm \
    -v ${PWD}:/etc/cfssl \
    -v ${PWD}/generate-certificates.sh:/generate-certificates.sh \
    -v ${PWD}/config.json:/etc/cfssl/config.json \
    -v ${PWD}/certs:/etc/cfssl/certs \
    --entrypoint="/generate-certificates.sh" \
    serialize/cfssl:base

```