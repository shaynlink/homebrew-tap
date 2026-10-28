# Homebrew Tap for LiliaDB

Official Homebrew tap for [LiliaDB](https://liliadb.org) - the local-first multimodel embedded & daemon database.

## Installation

```bash
brew tap shaynlink/tap
brew install lilia
```

Or with custom tap alias:
```bash
brew tap liliadb/tap https://github.com/shaynlink/homebrew-tap
brew install lilia
```

You can also install via the `liliadb` formula alias:
```bash
brew install liliadb
```

## Running the daemon as a service

```bash
brew services start lilia
```

## Verification

```bash
lilia --help
lilia-daemon --help
lilia-mcp --help
```
