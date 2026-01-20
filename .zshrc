export EDITOR=nvim
export VISUAL=nvim

eval "$(mise activate zsh)"

export PATH="${HOME}/.local/bin:$PATH"

# Machine-specific config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt beep nomatch
unsetopt autocd extendedglob notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/todd/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

PS1="%~ $ "

# Start SSH Agent
if [ -z "$SSH_AGENT_SOCK" ]; then
    eval "$(ssh-agent -s)"
fi
