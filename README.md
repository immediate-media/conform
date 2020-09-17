# Reformation

A tool for setting up a Mac for development, inspired by [formation](https://github.com/minamarkham/formation).

## What you get

- Installs [Xcode](https://developer.apple.com/xcode/)
- Installs [Homebrew](https://brew.sh/) (see [./reform.sh](./reform.sh) for list of brews)
- Installs [NVM](https://github.com/nvm-sh/nvm) for managing node versions
- Sets [Node](https://nodejs.org/en/) to the department's supported (as defined in [./reform.sh](./reform.sh))
- Configures SSH for GitHub
- Installs various Node packages globally (see [./reform.sh](./reform.sh) for the list)

## Issues

While hopefully rare, here are some issues that you may encounter while running
this script.

### Locked Homebrew process

When running the script repeatedly it is possible for Homebrew to get locked up
with an unfinished process. If you see a message like the following:

> Error: Another active Homebrew update process is already in progress.
> Please wait for it to finish or terminate it to continue.

You can try clearing any Homebrew locks:

```
rm -rf /usr/local/var/homebrew/locks
```
