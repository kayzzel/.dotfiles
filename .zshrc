########################################
# ZSH CONFIG
########################################


########################################
# Powerlevel10k Instant Prompt (Fast Startup)
########################################
# Must stay at the top for best performance
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


########################################
# Zinit Plugin Manager Setup
########################################
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"


########################################
# Prompt Theme — Powerlevel10k
########################################
zinit ice depth=1
zinit load romkatv/powerlevel10k

# Load p10k config if it exists
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh


########################################
# Vi Mode — zsh-vi-mode + Ctrl-R Fix
########################################
# Disable Ctrl-R inside vi mode (plugin-safe)
function zvm_after_init() {
  bindkey -M viins '^R' ''
  bindkey -M vicmd '^R' ''
}

zinit ice depth=1
zinit load jeffreytse/zsh-vi-mode

# Enable vi keybindings
bindkey -v
export KEYTIMEOUT=1


########################################
# Core Plugins (Lazy Loaded for Speed)
########################################

# Syntax highlighting
zinit ice wait lucid
zinit load zsh-users/zsh-syntax-highlighting

# Command autosuggestions
zinit ice wait lucid
zinit load zsh-users/zsh-autosuggestions

# Better tab completion UI (fzf-tab)
zinit ice wait lucid
zinit load Aloxaf/fzf-tab

# Completion system improvements
zinit load zsh-users/zsh-completions


########################################
# Oh-My-Zsh Plugin Snippets (Lazy Loaded)
########################################
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux

zinit ice wait lucid
zinit snippet OMZP::aws

zinit ice wait lucid
zinit snippet OMZP::kubectl

zinit ice wait lucid
zinit snippet OMZP::kubectx

zinit ice wait lucid
zinit snippet OMZP::command-not-found


########################################
# Completion System (Fast Mode)
########################################
autoload -Uz compinit
compinit -C -d ~/.cache/zcompdump

zinit cdreplay -q


########################################
# History Settings
########################################
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups


########################################
# Completion Styling & fzf-tab Preview
########################################
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

# Preview files when tab-completing paths
zstyle ':fzf-tab:complete:*' fzf-preview 'ls --color $realpath'


########################################
# Shell Integrations
########################################

# fzf keybindings & completion
eval "$(fzf --zsh)"

# Smarter cd with zoxide
eval "$(zoxide init --cmd cd zsh)"

# Show system info only in interactive shells
[[ $- == *i* ]] && macchina


########################################
# Aliases
########################################
# Basic shortcuts
alias ls='ls --color'           # colored ls output
alias c="clear"                  # clear terminal
alias x="exit"                   # exit shell

# Workflow / tools
alias cm="clear; macchina"       # clear + show system info
alias vim="nvim"                 # map vim to neovim
alias norm="norminette"          # custom tool
alias config_ghostty="vim ~/Library/Application\\ Support/com.mitchellh.ghostty"


########################################
# PATH
########################################
PATH="$HOME/bin:$HOME/.local/bin:$PATH"
