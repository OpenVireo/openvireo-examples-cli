#!/bin/sh
# Installs ov from the core's GitHub release into ./bin (or $1), after checking it against SHA256SUMS.
#   scripts/install-ov.sh            # ./bin/ov
#   OV_VERSION=1.0.0 scripts/install-ov.sh /usr/local/bin
set -eu
version=${OV_VERSION:-1.0.0}
dest=${1:-bin}
case "$(uname -s)-$(uname -m)" in
  Darwin-arm64) platform=darwin-arm64 ;;
  Darwin-x86_64) platform=darwin-x64 ;;
  Linux-x86_64) platform=linux-x64 ;;
  Linux-aarch64 | Linux-arm64) platform=linux-arm64 ;;
  *) echo "No ov build for $(uname -s)-$(uname -m): see the release for Windows" >&2; exit 1 ;;
esac
base="https://github.com/openvireo/openvireo-core/releases/download/v$version"
name="ov-$version-$platform"
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
curl -fsSL "$base/$name.tar.gz" -o "$tmp/$name.tar.gz"
curl -fsSL "$base/SHA256SUMS" -o "$tmp/SHA256SUMS"
if command -v sha256sum >/dev/null; then sum="sha256sum"; else sum="shasum -a 256"; fi
(cd "$tmp" && grep " $name.tar.gz\$" SHA256SUMS | $sum -c -)
tar -xzf "$tmp/$name.tar.gz" -C "$tmp"
mkdir -p "$dest"
install "$tmp/$name/ov" "$dest/ov"
"$dest/ov" version
