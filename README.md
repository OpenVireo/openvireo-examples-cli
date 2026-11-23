# OpenVireo examples: ov CLI

Shell scripts for [`ov`](https://developer.openvireo.com/cli/), the [OpenVireo](https://openvireo.com)
command line for reading, injecting and rotating secrets from scripts and CI. One script per guide on
[developer.openvireo.com](https://developer.openvireo.com) that has an **ov CLI** tab, plus templates
and a GitHub Actions workflow for CI.

Examples in other languages: [TypeScript](https://github.com/openvireo/openvireo-examples-typescript) · [Python](https://github.com/openvireo/openvireo-examples-python) · [Kotlin](https://github.com/openvireo/openvireo-examples-kotlin) · [Java](https://github.com/openvireo/openvireo-examples-java) · [Swift](https://github.com/openvireo/openvireo-examples-swift) · [C++](https://github.com/openvireo/openvireo-examples-cpp)

## Install ov

`ov` is a single signed binary on the [core release](https://github.com/openvireo/openvireo-core/releases/tag/v1.1.0)
(macOS binaries are notarized, the Windows one is signed). `scripts/install-ov.sh` downloads the one for
your machine, checks it against `SHA256SUMS` and installs it:

```sh
git clone https://github.com/openvireo/openvireo-examples-cli
cd openvireo-examples-cli
scripts/install-ov.sh ~/.local/bin      # or /usr/local/bin
ov version
```

To check the signature on `SHA256SUMS` as well, see [Install](https://developer.openvireo.com/cli/#install).

## The examples

| Script | What it does | Guide |
|---|---|---|
| [`first-program.sh`](examples/first-program.sh) | Sign in, list the vaults, read one field, sign out | [A first program](https://developer.openvireo.com/sdk/#a-first-program) |
| [`hosted-account.sh`](examples/hosted-account.sh) | Sign in and out, `whoami`, account deletion | [Hosted accounts](https://developer.openvireo.com/sdk/guides/hosted-account/) |
| [`vaults-and-sharing.sh`](examples/vaults-and-sharing.sh) | List vaults and items; create, edit and read an entry | [Vaults and sharing](https://developer.openvireo.com/sdk/guides/vaults-and-sharing/) |
| [`service-accounts.sh`](examples/service-accounts.sh) | Read, `inject` and `run` with a service account token | [Service accounts](https://developer.openvireo.com/sdk/guides/service-accounts/) |
| [`share-links.sh`](examples/share-links.sh) | Share an item or text by link, list and revoke links | [Share links](https://developer.openvireo.com/sdk/guides/share-links/) |
| [`rotate.sh`](examples/rotate.sh) | Generate and store a new value for a field | [CLI](https://developer.openvireo.com/cli/) |
| [`ci/`](examples/ci/) | `config.yml.tpl` for `ov inject`, `.env.tpl` for `ov run`, a GitHub Actions workflow | [Service accounts](https://developer.openvireo.com/sdk/guides/service-accounts/) |

`ov` takes its credentials from `OPENVIREO_SERVICE_ACCOUNT_TOKEN` (or `OPENVIREO_SERVICE_ACCOUNT_TOKEN_FILE`)
when it's set, else from the session `ov login` saved, unlocked with `OPENVIREO_PASSWORD` or a prompt.
The scripts only write when you ask them to (`vaults-and-sharing.sh <vault> --write`, `rotate.sh`). Try
those on a test vault.

In GitHub Actions, the [OpenVireo GitHub Action](https://developer.openvireo.com/cli/github-action/) loads
secrets into a workflow in one step; [`ci/github-actions.yml`](examples/ci/github-actions.yml) shows
the same with `ov` directly.

## Checks

CI runs shellcheck on every script and installs `ov` with `scripts/install-ov.sh` on Linux and macOS,
on every push and weekly.

## License

MIT. Copy the scripts into your own projects.
