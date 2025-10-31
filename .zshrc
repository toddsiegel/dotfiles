eval "$(rbenv init -)"

# Start nvm initialization: See https://github.com/nvm-sh/nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# place this after nvm initialization!
autoload -U add-zsh-hook

load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc
# End nvm initialization

# Setup brew shell completion
# See https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

# aliases
[[ -f ~/.config.local/aliases ]] && source ~/.config.local/aliases

alias b="bundle"
alias by="bundle && yarn"
alias bo="bundle outdated"
alias boe="bundle outdated --only-explicit"
alias bup="bundle update"
alias byo="bundle outdated; yarn outdated"
alias yo="yarn outdated"
alias yup="yarn upgrade"

# Docker aliases
alias dis="docker images"
alias dps="docker ps"

alias dfman="$(which git) --git-dir=$HOME/projects/dotfiles --work-tree=$HOME"
alias gollum="docker run --rm --name gollum -d -v $(pwd):/wiki -p 4567:4567 gollum"
alias y="yarn"

# git aliases
alias gcam="git commit -am"
alias gcm="git commit -m"
alias lzg="lazygit"

# gh aliases
alias gha="gh run list -u toddsiegel"
alias ghw="gh run watch"

# rails aliases
alias dbst="rails db:migrate:status"
alias dbmi="rails db:migrate"
alias dbro="rails db:rollback"
alias rt="bin/rails test"

export EDITOR=nvim

# ngok completions
if command -v ngrok &>/dev/null; then
  eval "$(ngrok completion)"
fi

eval "$(mise activate zsh)"

# Machine-specific config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
