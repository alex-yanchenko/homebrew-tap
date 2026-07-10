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

1. Each tool uses **release-please**: conventional commits accumulate into a release PR;
   merging it cuts a published release automatically (no manual step).
2. That release's job then **pushes the formula bump straight to this tap** (via the
   release app's token) — the instant the release publishes, not on a schedule.
   - **ccsearch** is zero-dependency, so its bump is a one-line `url` + `sha256` rewrite.
   - **skaldr** has compiled, per-platform dependencies (`pydantic-core`, `pyyaml`,
     `markupsafe`), so its release regenerates `Formula/skaldr.rb` via
     `scripts/gen-skaldr-formula.py`, which re-pins skaldr's wheel + every dependency wheel
     (one per platform) from PyPI.
3. `brew upgrade` on any machine then picks up the new version.

## Layout

```
Formula/                       # one <tool>.rb per formula
scripts/gen-skaldr-formula.py  # regenerates skaldr's per-platform formula from PyPI
.github/workflows/
  update-formulae.yml          # manual fallback: re-sync a formula on demand
  tests.yml                    # brew style (rubocop) on push/PR
```
