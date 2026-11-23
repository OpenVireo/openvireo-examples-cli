#!/bin/sh
# Stands in for a deploy step. Anything that prints a secret shows it masked (`ov run` does that).
set -eu
echo "deploying with APP_ENV=$APP_ENV"
echo "the database password is $DATABASE_PASSWORD"   # masked in the output
test -n "$DEPLOY_KEY" && echo "deploy key: present"
