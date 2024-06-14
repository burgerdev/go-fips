#!/bin/bash

SERVER="localhost"
PORT="8443"

echo "Probing TLS 1.3 cipher suites for $SERVER:$PORT"

# List of all TLS 1.3 cipher suites
CIPHERS=(
    "TLS_AES_256_GCM_SHA384"
    "TLS_CHACHA20_POLY1305_SHA256"
    "TLS_AES_128_GCM_SHA256"
    "TLS_AES_128_CCM_8_SHA256"
    "TLS_AES_128_CCM_SHA256"
)

for CIPHER in "${CIPHERS[@]}"; do
    echo -n "Testing $CIPHER... "
    
    # Use OpenSSL to test the connection with the specified cipher
    result=$(openssl s_client -connect "$SERVER:$PORT" -ciphersuites "$CIPHER" -tls1_3 2>&1 </dev/null)
    
    if echo "$result" | grep -q "Cipher is $CIPHER"; then
        echo "supported"
    else
        echo "not supported"
    fi
done