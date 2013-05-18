#!/usr/bin/env ruby

# Globals
$dotfiles_repo_url = "git@github.com:holdtotherod/dotfiles.git"
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
  else
    checkout_repo
    remove_existing_files
    symlink_files
    puts "done."
  end
end

def sync
  print "Syncing dotfiles..."
  `pushd #{dotfiles_repo_path}`
  `git stash`
  `git pull --rebase`
  `git push`
  `git stash pop`
  `popd`
  `source ~/.profile`
  puts "done."
end

# Helper methods

def already_installed?
  File.exists?( File.expand_path repo_path )
end

def checkout_repo
  `mkdir #{git_repos_dir}` unless File.exists?( File.expand_path git_repos_dir )
  `git clone #{dotfiles_repo_url} #{dotfiles_repo_path}`
end

def remove_existing_files
  $filepaths.each do |filepath|
    `rm #{filepath}` if File.exists?( File.expand_path filepath )
  end
end

def symlink_files
  $filepaths.each do |filepath|
    basename = File.basename filepath
    `ln -s #{dotfiles_repo_path}/{basename} #{filepath}`
  end
end

def dotfiles_repo_path
  repo_foldername = File.basename $repo_url, ".git"
  "#{git_repos_dir}/#{repo_foldername}"
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
