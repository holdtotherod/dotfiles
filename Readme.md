DotFiles
--------

All the files I need to make a new machine usable on the command-line.

### Installation

```bash
ruby -e "$(curl -fsSL https://raw.github.com/holdtotherod/dotfiles/master/dotfiles.rb)" && source ~/.profile
```

### What it does

Keeps everything in sync!

Install:
- Clones this repo to `~/repos/dotfiles`
- Symlinks all the files to their proper place, removing exiting files if necessary
- Prompts for password to decrypt ssh config file, and copies it to `~/.ssh`

Sync:
- Pulls in new changes
- Prompts for password to decrypt ssh config file, and copies it to `~/.ssh`

Feel free to fork and use yourself. Make sure to change the repo url, and use your ssh pub key instead.

 