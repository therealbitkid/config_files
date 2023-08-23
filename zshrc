# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Get the only language computers should speak
export LANG=en_US
export LC_ALL=en_US

source ~/.zsh/themes/powerlevel10k/powerlevel10k.zsh-theme

# Get termcolors
source ~/.termcolors

#prompt="%S(%n@%m)%s %3c> "
prompt=" $CYAN%T$NORMAL %n@%m:$BRIGHT$CYAN%30<..<%~/$NORMAL > " 

# It's nice, but too annoying when copy/pasting
#RPROMPT="[%T]"
unset RPROMPT

# My Windowmanager
#export WINDOWMANAGER=/usr/X11R6/bin/blackbox

# History
HISTSIZE=5000
HISTFILE=${HOME}/.zsh_history
SAVEHIST=5000

# I am capable of checking mail myself.
unset MAILCHECK

# pushd on every cd is nice
setopt auto_pushd

# No CR to screw output
setopt nopromptcr

# Correction sucks!
setopt nocorrect
setopt nocorrectall

# setopt auto_cd
setopt print_exit_value
unsetopt bg_nice
unsetopt hup

# User defined aliases
alias l="less"
alias ll="ls -ltrG"
alias la="ls -laG"
alias ls="ls -G"
alias rm="rm -v"
alias rgrep='grep -iR --color=auto -n'
alias vi='/Applications/MacVim.app/Contents/MacOS/Vim'
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'

# History completion
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# Kill parts of a path with ESC-backspace
autoload -U bash-backward-kill-word
zle -N bash-backward-kill-word
bindkey "^[^?" bash-backward-kill-word

# Make the shell's have titlebar with hostname etc.
if [ $TERM = "xterm" ]; then 
	echo "\033]2;`uname -n`  `uname -sr` \007\033]1";
fi

# The nice ZSH completion
autoload -U compinit
compinit

# Completion on .ssh/known_hosts
zstyle -e ':completion:*:ssh:*' hosts 'reply=($(sed -e "/^#/d" -e "s/ .*\$//" -e "s/,/ /g" /etc/ssh_known_hosts ~/.ssh/known_hosts ~/.ssh/known_hosts2 2>/dev/null))'

# Completion so "cd ..<TAB>" -> "cd ../"
# zstyle ':completion:*' special-dirs ..

export PATH=:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin:/opt/homebrew/bin:$PATH
export SVN_EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim

# source ~/.zsh/git_prompt.zsh


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

function lk {
  cd "$(walk "$@")"
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# 1Password
export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
