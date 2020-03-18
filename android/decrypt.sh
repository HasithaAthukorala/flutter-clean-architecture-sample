#!/usr/bin/env bash

# Decrypt Files
rm android/key.jks || true
rm android/key.properties || true
gpg --quiet --batch --yes --decrypt --passphrase="$KEY_STORE" --output android/key.jks android/key.jks.gpg
gpg --quiet --batch --yes --decrypt --passphrase="$KEY_STORE" --output android/key.properties android/key.properties.gpg
echo storeFile=`pwd`/android/key.jks >> android/key.properties
