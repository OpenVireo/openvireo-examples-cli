#!/bin/sh
# A first program: sign in, list the vaults, read one field and sign out.
#
# Guide: https://developer.openvireo.com/sdk/#a-first-program
#
#   ./examples/first-program.sh you@example.com "ov://Personal/GitHub/username"
set -eu
email=${1:?usage: first-program.sh <email> [ov://reference]}

ov login --email "$email"   # master password, then the Secret Key the first time
ov vault list
if [ -n "${2:-}" ]; then
  ov read "$2"
fi
ov logout
