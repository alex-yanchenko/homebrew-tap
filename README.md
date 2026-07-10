# homebrew-tap

A personal [Homebrew](https://brew.sh) tap for my command-line tools, so they install and
update the same way on any machine:

```bash
brew install alex-yanchenko/tap/<tool>   # the tap is added automatically on first use
brew upgrade                             # updates every installed tool
```

## Tools

| Tool | What it is | Status |
|---|---|---|
| **ccsearch** | Search your Claude Code sessions by content | ✅ `brew install alex-yanchenko/tap/ccsearch` |
| **skaldr** | Render a YAML content file into a self-contained HTML report | ✅ `brew install alex-yanchenko/tap/skaldr` |

**kvasir is deliberately not here.** It's a multi-part system (channel binary + Chrome
extension + `/kvasir` skill) whose parts must stay on the same version; installing only the
channel binary via brew would let `brew upgrade` bump one part out of lockstep. kvasir
updates itself instead — run `kvasir upgrade`.

> For the Python tools, `uvx <tool>` or `pipx install <tool>` (once each is on PyPI) is an
> equivalent install path. The tap additionally pulls in the external binaries a tool needs
> (e.g. ripgrep + fzf for ccsearch) and fits the `brew upgrade` habit.

## How updates flow

1. Each tool uses **release-please**: merging its release PR publishes a release.
2. The release job then **pushes the formula update to this tap** using the release app's
   token.
   - **ccsearch** is zero-dependency, so it rewrites the formula's `url` + `sha256`.
   - **skaldr** has compiled, per-platform dependencies (`pydantic-core`, `pyyaml`,
     `markupsafe`), so it regenerates `Formula/skaldr.rb` via `scripts/gen-skaldr-formula.py`,
     which re-pins skaldr's wheel + every dependency wheel (one per platform) from PyPI.
3. `brew upgrade` picks up the new version.

## Layout

```
Formula/                       # one <tool>.rb per formula
scripts/gen-skaldr-formula.py  # regenerates skaldr's per-platform formula from PyPI
.github/workflows/
  update-formulae.yml          # manual fallback: re-sync a formula on demand
  tests.yml                    # brew style (rubocop) on push/PR
```
