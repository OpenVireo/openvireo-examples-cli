#!/bin/sh
# Service accounts: read, inject and run with secrets in CI, with no one signed in.
#
# Guide: https://developer.openvireo.com/sdk/guides/service-accounts/
#
#   export OPENVIREO_SERVICE_ACCOUNT_TOKEN=ov_sa_…
#   ./examples/service-accounts.sh "Team Infra"
#
# Uses the templates in examples/ci/: config.yml.tpl and .env.tpl reference the vault as "Team Infra";
# pass another vault name to rewrite them on the fly.
set -eu
: "${OPENVIREO_SERVICE_ACCOUNT_TOKEN:?set OPENVIREO_SERVICE_ACCOUNT_TOKEN (or OPENVIREO_SERVICE_ACCOUNT_TOKEN_FILE)}"
vault=${1:-Team Infra}
dir=$(dirname "$0")/ci
encoded=$(printf '%s' "$vault" | sed 's/ /%20/g')

ov vault list   # the vaults this service account can open

# One value
ov read "ov://$vault/GitHub deploy key/password" -n > /dev/null && echo "read: ok"

# A config file from a template: {{ ov://… }} and bare references are replaced
sed "s/Team%20Infra/$encoded/g; s/Team Infra/$vault/g" "$dir/config.yml.tpl" | ov inject -o "$dir/config.yml"
echo "wrote $dir/config.yml"

# A command with secrets in its environment; resolved values are masked in its output
tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT
sed "s/Team%20Infra/$encoded/g" "$dir/.env.tpl" > "$tmp"
ov run --env-file "$tmp" -- "$dir/deploy.sh"
