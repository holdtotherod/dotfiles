#!/usr/bin/env ruby

# Globals
$dotfiles_repo_url = "https://github.com/holdtotherod/dotfiles.git"
$git_repos_dir = "~/repos"
$filepaths = [
  "~/.profile",
  "~/.vimrc",
  "~/.gitconfig",
  "~/.git-completion.bash",
  "~/.gitignore_global"
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
