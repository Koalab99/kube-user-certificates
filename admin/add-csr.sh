#!/bin/bash

# Relative Working directory
RWD=$(dirname "$0")

if [[ $# -ne 1 ]]
then
    echo "Usage: $0 <CSRFILE>"
    exit 0
fi

CSR_FILE="$1"
# Print the CSR data
openssl req -in "$CSR_FILE" -text -noout

if [[ $? -ne 0 ]]
then
    echo "There is a problem with the CSR"
    exit 0
fi

# Retrieve username
USERNAME=$(openssl req -in "$CSR_FILE" -text -noout | grep "^\s\+Subject:.*CN = " | sed -s 's/.*CN = \([^,$]\+\)/\1/g')

echo -n "We managed to find the user is '$USERNAME', is it ok ? [Yn] "
read ans
if [[ "$ans" =~ ^[nN] ]]
then
    read -p "What name should be used ?" USERNAME
fi

# Retrieve CSR and base64 encode
CSR=$(cat "$CSR_FILE" | base64 | tr -d "\n")

CSR_MANIFEST=$(mktemp)
sed "s/---USER---/$USERNAME/g;s/---CSRB64---/$CSR/g" "$RWD/template/csr.yaml" >"$CSR_MANIFEST"

if [ "x$EDITOR" == "x" ]
then
    EDITOR=vim
fi

$EDITOR "$CSR_MANIFEST"

echo -n "Save in csr/$USERNAME.yaml ? [Yn] "
read ans
if [[ ! "$ans" =~ ^[nN] ]]
then
    cp "$CSR_MANIFEST" "$RWD/csr/$USERNAME.yaml"
fi
