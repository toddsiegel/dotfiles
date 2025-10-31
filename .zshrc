eval "$(rbenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export EDITOR=nvim

# I set this a long, long time ago. Maybe it's safe to disable it. Let's see.
# export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# ngok completions
if command -v ngrok &>/dev/null; then
  eval "$(ngrok completion)"
fi

eval "$(mise activate zsh)"
