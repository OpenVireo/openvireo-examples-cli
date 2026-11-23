#!/bin/sh
# Hosted accounts from the command line: signing in and out, who you are, and account deletion.
#
# Guide: https://developer.openvireo.com/sdk/guides/hosted-account/
#
#   ./examples/hosted-account.sh you@example.com
#
# Signs in, shows the account, and signs out. `ov account delete` and `ov account restore` are
# shown at the end but not run.
set -eu
email=${1:?usage: hosted-account.sh <email>}

# Signing in: the master password, the Secret Key the first time on this machine, then a TOTP code
# if two-step sign-in is on. --issuer picks another account server (default https://accounts.openvireo.com).
ov login --email "$email"
ov whoami

# Later commands unlock the session with OPENVIREO_PASSWORD, or ask for the password.

# Signing out
ov logout            # ends the session
# ov logout --forget # also removes the Secret Key from this machine

# Deleting the account (not run here)
# ov account delete    # lock the account now, erase it after 30 days
# ov account restore   # after `ov login`, keep an account scheduled for deletion
