#!/bin/sh
# Vaults and items: listing, reading and writing fields, creating entries.
#
# Guide: https://developer.openvireo.com/sdk/guides/vaults-and-sharing/
#
#   ./examples/vaults-and-sharing.sh "Team Infra"            # list the vault's items
#   ./examples/vaults-and-sharing.sh "Team Infra" --write    # also create and edit an example entry
#
# Run `ov login` first (or set OPENVIREO_SERVICE_ACCOUNT_TOKEN).
set -eu
vault=${1:?usage: vaults-and-sharing.sh <vault name> [--write]}

# Listing and opening
ov vault list
ov item list "$vault"

[ "${2:-}" = "--write" ] || exit 0

# Creating an entry with fields, then editing one from stdin (the value never shows in `ps`)
ov item create "ov://$vault/OpenVireo example" username=app url=https://example.com --generate --length 24
printf '%s' "a new value" | ov item edit "ov://$vault/OpenVireo example" --stdin-field token

# Reading fields back
ov read "ov://$vault/OpenVireo example/username"
ov item get "ov://$vault/OpenVireo example" --json
