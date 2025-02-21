# 'brew tap'
# tap "homebrew/cask"
# 'brew tap' with custom Git URL
# tap "user/tap-repo", "https://user@bitbucket.org/user/homebrew-tap-repo.git"
# 'brew tap' with arguments
# tap "user/tap-repo", "https://user@bitbucket.org/user/homebrew-tap-repo.git", force_auto_update: true

# set arguments for all 'brew install --cask' commands
# cask_args appdir: "~/Applications", require_sha: true

# 'brew install'
# brew "imagemagick"
# 'brew install --with-rmtp', 'brew services restart' on version changes
# brew "denji/nginx/nginx-full", args: ["with-rmtp"], restart_service: :changed
# 'brew install', always 'brew services restart', 'brew link', 'brew unlink mysql' (if it is installed)
# brew "mysql@5.6", restart_service: true, link: true, conflicts_with: ["mysql"]
# install only on specified OS
# brew "gnupg" if OS.mac?
# brew "glibc" if OS.linux?

# 'brew install --cask'
# cask "google-chrome"
# 'brew install --cask --appdir=~/my-apps/Applications'
# cask "firefox", args: { appdir: "~/my-apps/Applications" }
# bypass Gatekeeper protections (NOT RECOMMENDED)
# cask "firefox", args: { no_quarantine: true }
# always upgrade auto-updated or unversioned cask to latest version even if already installed
# cask "opera", greedy: true
# 'brew install --cask' only if '/usr/libexec/java_home --failfast' fails
# cask "java" unless system "/usr/libexec/java_home", "--failfast"

# 'mas install'
# mas "1Password", id: 443_987_910

# 'whalebrew install'
# whalebrew "whalebrew/wget"

# 'vscode --install-extension'
# vscode "GitHub.codespaces"

#############################################################################
### Always install every time!                                              #
#############################################################################

# Shell
brew "starship"
brew "zoxide"

# Utilities
brew "fd"                 # find replacement
brew "rg"                 # grep replacement
brew "sd"                 # sed replacement
brew "bat"                # cat replacement
brew "fzf"                # Fuzzy Finder
brew "direnv"             # Heirarchial environment files
brew "choose-rust"        # Human-friendly cut/awk alternative

#############################################################################
### Conditional installs                                                    #
#############################################################################
# Docker
def docker_installed?
  system('which docker > /dev/null 2>&1')
end
if docker_installed?
  brew "ctop"
  brew "lazydocker"
end

# Rust
def rust_installed?
  system('which cargo > /dev/null 2>&1')
end
if rust_installed?
  brew "cargo-binstall"
  brew "rust-script"
end

#############################################################################
### No Docker Containers                                                    #
#############################################################################
if File.exist?("/.dockerenv")
  return
end

# IDE
brew "helix"
brew "lazygit"
brew "git-delta"

# General Language Servers
brew "yaml-language-server"
brew "bash-language-server"
# brew "harper"

# File Manager
# brew "ranger"
brew "yazi"

#############################################################################
### No SSH                                                                  #
#############################################################################
if ENV['SSH_CLIENT'] == nil
  return
end

brew "zellij"
brew "nushell"
brew "carapace"

# Utilities
brew "jq"                     # JSON Parser
brew "yq"                     # YAML Parser
brew "eva"                    # Simple calculator (bc replacement)
brew "lsd"                    # ls replacement
brew "tldr"                   # Quick help docs
brew "tailspin"               # Log Colorizer (tspin)
brew "jless"                  # TUI JSON Browser
brew "hwatch"                 # Modern 'watch' alternative
tap "knqyf263/pet"
brew "knqyf263/pet/pet"       # CLI Snippets
brew "abhimanyu003/sttr/sttr" # Various string maniuplations

# Misc
brew "aichat"
brew "pass"
brew "hwatch"
brew "autossh"
brew "posting"

#############################################################################
### No WSL                                                                  #
#############################################################################
if File.exist?("/proc/sys/fs/binfmt_misc/WSLInterop")
  return
end

# Fonts
# This isn't working anymore, cask-fonts was deprecated?
# Disabling for now

# tap "homebrew/cask-fonts"
# cask "font-jetbrains-mono-nerd-font"
# brew "font-jetbrains-mono-nerd-font"
