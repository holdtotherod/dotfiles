#!/usr/bin/env ruby

# Globals
$dotfiles_repo_url = "https://github.com/holdtotherod/dotfiles.git"
$git_repos_dir = "~/repos"
$filepaths = [
  "~/.profile",
  "~/.vimrc",
  "~/.gitconfig",
  "~/.git-completion.bash",
  "~/.gitignore_global",
  "~/.ssh/lottermoser_key.pub"
]

# Script commands

def install
  print "Installing dotfiles..."
  if already_installed?
    puts "already installed."
    sync
  else
    puts
    checkout_repo
    remove_existing_files
    symlink_files
    use_repo_ssh_url
    decrypt_ssh_config
    puts "done."
  end
end

def sync
  print "Syncing dotfiles..."
  pwd = Dir.pwd
  Dir.chdir dotfiles_repo_path
  `git stash`
  `git pull --rebase`
  `git stash pop`
  decrypt_ssh_config
  Dir.chdir pwd
  puts "done."
end

# Helper methods

def already_installed?
  file_or_symlink_exists? dotfiles_repo_path
end

def checkout_repo
  `mkdir #{git_repos_dir}` unless file_or_symlink_exists? git_repos_dir 
  `git clone #{dotfiles_repo_url} #{dotfiles_repo_path}`
end

def remove_existing_files
  $filepaths.each do |filepath|
    `rm #{filepath}` if file_or_symlink_exists? filepath
  end
end

def symlink_files
  $filepaths.each do |filepath|
    basename = File.basename filepath
    `ln -s #{dotfiles_repo_path}/#{basename} #{filepath}`
  end
end

def decrypt_ssh_config
  # Don't symlink the ssh config to make sure to encrypt it before committing it
  # Encrypt ssh config file: `openssl enc -aes-256-cbc -salt -in ~/.ssh/config -out ssh_config.enc`
  config_source_path = File.expand_path "#{dotfiles_repo_path}/ssh_config.enc"
  config_target_path = File.expand_path "~/.ssh/config"
  `openssl enc -d -aes-256-cbc -in #{config_source_path} -out #{config_target_path}`
end

def use_repo_ssh_url
  pwd = Dir.pwd
  Dir.chdir dotfiles_repo_path
  `git remote set-url origin #{dotfiles_repo_ssh_url}`
  Dir.chdir pwd
end

def file_or_symlink_exists?(filepath)
  filepath = File.expand_path filepath
  File.exists?(filepath) || File.symlink?(filepath)
end

def dotfiles_repo_path
  repo_foldername = File.basename dotfiles_repo_url, ".git"
  File.expand_path "#{git_repos_dir}/#{repo_foldername}"
end

def dotfiles_repo_url
  $dotfiles_repo_url
end

def dotfiles_repo_ssh_url
  ssh_url = dotfiles_repo_url.sub "https://", "git@"
  ssh_url.sub! "/", ":"
end

def git_repos_dir
  $git_repos_dir
end

# Main

case ARGV[0]
when "sync"
  sync
else
  install
end
