#!/bin/bash

KEY_PATH="$HOME/.kube/$USER.key"
CSR_PATH="$HOME/.kube/$USER.csr"

echo "Creating directory '$HOME/.kube'"
mkdir -p "$HOME/.kube"

echo "Generating your private key..."
openssl genpkey -algorithm ed25519 -out "$KEY_PATH"

echo "Generating your Certificate Signing Request..."
openssl req -new -key "$KEY_PATH" -out "$CSR_PATH" -subj "/C=FR/CN=$USER"

echo "You can share the file $CSR_PATH with your cluster administrator"
echo "Don't forget to add your manager in the mail"
