#!/bin/sh
# Rotating a secret: generate a new value and store it, printing it only if asked.
#
# Guide: https://developer.openvireo.com/cli/
#
#   ./examples/rotate.sh "ov://Team Infra/Database/password"
#
# Needs the write role on the vault (a signed-in user, or a service account with write).
set -eu
ref=${1:?usage: rotate.sh <ov://vault/entry/field>}

ov rotate "$ref" --generate --length 32 --charset letters,digits
# from a value you already have instead:  printf '%s' "$NEW" | ov rotate "$ref" --stdin
