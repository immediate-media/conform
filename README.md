# Conform

A tool for setting up macOS for development, inspired by [formation](https://github.com/minamarkham/formation).

## Usage

Download and unzip [master](https://github.com/immediate-media/conform/archive/master.zip)

```sh
./conform/run.sh
```

## What you get

- Installs the following core dependencies:
  - [Xcode](https://developer.apple.com/xcode/)
  - [Homebrew](https://brew.sh/)
  - [NVM](https://github.com/nvm-sh/nvm)
- Installs the following applications:
  - [Docker](https://www.docker.com/)
  - [Firefox](https://www.mozilla.org/firefox/)
  - [Chrome](https://www.google.com/chrome/)
  - [iTerm2](https://iterm2.com/)
  - [Slack](https://slack.com/)
  - [VSCode](https://code.visualstudio.com/)
  - [PHPStorm](https://www.jetbrains.com/phpstorm/)
- Installs the following global Node packages:
  - [newman](https://www.npmjs.com/package/newman)
  - [webpack](https://www.npmjs.com/package/webpack)
  - [webpack-cli](https://www.npmjs.com/package/webpack-cli)
  - [yalc](https://www.npmjs.com/package/yalc)
- Installs the following via Homebrew:
  - [autojump](https://formulae.brew.sh/formula/autojump)
  - [awscli](https://formulae.brew.sh/formula/awscli)
  - [bash](https://formulae.brew.sh/formula/bash)
  - [composer](https://formulae.brew.sh/formula/composer)
  - [coreutils](https://formulae.brew.sh/formula/coreutils)
  - [docker-compose](https://formulae.brew.sh/formula/docker-compose)
  - [gh](https://formulae.brew.sh/formula/gh)
  - [grep](https://formulae.brew.sh/formula/grep)
  - [jq](https://formulae.brew.sh/formula/jq)
  - [moreutils](https://formulae.brew.sh/formula/moreutils)
  - [php](https://formulae.brew.sh/formula/php)
  - [python](https://formulae.brew.sh/formula/python)
  - [wget](https://formulae.brew.sh/formula/wget)
  - [yarn](https://formulae.brew.sh/formula/yarn)
- Sets [Node](https://nodejs.org/en/) to the department's supported version
- Configures SSH for GitHub

## Issues

Here are some issues that you may encounter while running this script.

### Casks already installed

Unfortunately, `brew cask` does not recognise applications installed outside
of it. In the case that the script fails with an error similar to the following:

> Error: It seems there is already an App at '/Applications/Docker.app'.

you can either remove the application from the install list locally, or
uninstall the application causing the failure and try again.

### Locked Homebrew process

When running the script repeatedly it is possible for Homebrew to get locked up
with an unfinished process. If you see a message like the following:

> Error: Another active Homebrew update process is already in progress.
> Please wait for it to finish or terminate it to continue.

you can try clearing any Homebrew locks:

```sh
rm -rf /usr/local/var/homebrew/locks
```

## TODO

- Add as a global CLI command, then advise how to run as a cron job and keep things up-to-date?
- See how much more of the stuff in [Developer machine set up](https://immediateco.atlassian.net/wiki/spaces/WCPP/pages/5181018/Developer+machine+set-up) we can do
