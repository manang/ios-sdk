#!/bin/sh
set -eox pipefail

gpg --quiet --batch --yes --decrypt --passphrase="$IOS_KEYS" --output ./.github/secrets/YOUR_PROFILE.mobileprovision ./.github/secrets/YOUR_PROFILE.mobileprovision.gpg
gpg --quiet --batch --yes --decrypt --passphrase="$IOS_KEYS" --output ./.github/secrets/Certificates.p12 ./.github/secrets/YOUR_CERTIFICATE.p12.gpg

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles

cp ./.github/secrets/YOUR_PROFILE.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/YOUR_PROFILE.mobileprovision


security create-keychain -p "$IOS_KEYS" build.keychain
security import ./.github/secrets/Certificates.p12 -t agg -k ~/Library/Keychains/build.keychain -P "$IOS_KEYS" -A

security list-keychains -s ~/Library/Keychains/build.keychain
security default-keychain -s ~/Library/Keychains/build.keychain
security unlock-keychain -p "$IOS_KEYS" ~/Library/Keychains/build.keychain

security set-key-partition-list -S apple-tool:,apple: -s -k "$IOS_KEYS" ~/Library/Keychains/build.keychain
