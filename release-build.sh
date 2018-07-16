#!/bin/sh

set -o nounset # (set -u) No unset variables
set -o errexit # (set -e) Exit if any statement returns non-true value

BOARD="teensylc"

# Change to directory script resides in
cd "$(dirname -- "${0}")"

# Build firmware
platformio run
echo

# Grab version string from Git
VERSION="$(git describe --tags --dirty)"

# Remove the string "version-" from the beginning of the $VERSION variable
VERSION=${VERSION#"version-"}

# Copy compiled firmware files to current directory
cp -v ".pioenvs/$BOARD/firmware.elf" "./firmware_${VERSION}_${BOARD}.elf"
cp -v ".pioenvs/$BOARD/firmware.hex" "./firmware_${VERSION}_${BOARD}.hex"
