export EDITOR=nvim
export VISUAL=nvim

eval "$(mise activate zsh)"

# Machine-specific config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases
