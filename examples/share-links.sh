#!/bin/sh
# Share links: share an item or some text through a link that needs no account; list and revoke links.
#
# Guide: https://developer.openvireo.com/sdk/guides/share-links/
#
#   ./examples/share-links.sh list
#   ./examples/share-links.sh item "ov://Private/Wi-Fi"
#   ./examples/share-links.sh text "The alarm code is 4321"
#   ./examples/share-links.sh revoke <id>
#
# Share links are for signed-in users (`ov login`), not service accounts.
set -eu
case "${1:-}" in
  list)
    ov share list            # add --json for everything
    ;;
  item)
    # username, password and website; the link works for 7 days
    ov share "${2:?usage: share-links.sh item <ov://vault/entry>}"
    # one field, one open, one day:
    #   ov share ov://Private/Bank --field Password --once --expires 1d
    # with a passcode (asked for, or OPENVIREO_SHARE_PASSCODE):
    #   ov share ov://Private/Bank --field otp --passcode
    ;;
  text)
    printf '%s' "${2:?usage: share-links.sh text <text>}" | ov share --text --title "Front door" --expires 1h --once
    ;;
  revoke)
    ov share revoke "${2:?usage: share-links.sh revoke <id>}"
    ;;
  *)
    sed -n '2,12p' "$0" >&2
    exit 2
    ;;
esac
