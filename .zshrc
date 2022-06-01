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
alias byo="bundle outdated; yarn outdated"
alias dfman="$(which git) --git-dir=$HOME/projects/dotfiles --work-tree=$HOME"
alias gollum="docker run --rm --name gollum -d -v $(pwd):/wiki -p 4567:4567 gollum"
alias y="yarn"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export EDITOR=vim

# For Pure prompt: https://github.com/sindresorhus/pure
autoload -U promptinit; promptinit
zstyle ':prompt:pure:path' color 033
prompt pure
