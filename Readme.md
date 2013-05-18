DotFiles
--------

All the files I need to make a new machine usable on the command-line.

## Installation

ruby -e "$(curl -fsSL https://raw.github.com/holdtotherod/dotfiles/master/dotfiles.rb)"

## What it does

Keeps everything in sync!

Install:
- Clones this repo to `~/repos/dotfiles`
- Symlinks all the files to their proper place, removing exiting files if necessary

Sync:
- Pulls in new changes
- `source ~/.profile`

## Coming soon
- Add my ssh pub key into `~/.ssh/authorized_keys`
- encrypted `~/.ssh/config` file?

 