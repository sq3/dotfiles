#
# zsh
#
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

#
# powerline10k
#
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

local user_symbol="$"
#if [[ $(print -P "%    user_symbol = " ]] fi

ZSH_THEME="powerlevel10k/powerlevel10k"

POWERLEVEL10K_LEFT_PROMPT_ELEMENTS=(dir rbenv vcs)
POWERLEVEL10K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time)
POWERLEVEL10K_PROMPT_ON_NEWLINE=true
POWERLEVEL10K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_INSTANT_PROMPT=off
POWERLEVEL10K_VCS_MODIFIED_BACKGROUND=’red’
POWERLEVEL10K_MULTILINE_FIRST_PROMPT_PREFIX="%f"
POWERLEVEL10K_MULTILINE_LAST_PROMPT_PREFIX="%{%B%F{black}%K{yellow}%} $user_symbol%{%b%f%k%F{yellow}%} %{%f%}"
POWERLEVEL10K_RIGHT_PROMPT_ELEMENTS=(status virtualenv)

#
# paths
#
export PATH=$HOME/bin:/opt/homebrew/bin:$PATH
export PATH="/opt/homebrew/opt/python@3.7/bin:$PATH"
export PATH="/opt/homebrew/opt/python@3.8/bin:$PATH"
export PATH="/opt/homebrew/opt/python@3.9/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/lib/node_modules:$PATH"
export PATH="/opt/homebrew/lib/node_modules/npm/node_modules:$PATH"
export PATH="$HOME/bin:$PATH"

export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/opt/homebrew/opt/coreutils/libexec/gnuman:$MANPATH"

export PATH=/opt/pel/formae/bin:$PATH

#
# oh-my-zsh
#
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
source $(brew --prefix)/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

export ZSH_DISABLE_COMPFIX=false
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=7'

plugins=(
  1password
	ansible
  aws
  brew
  command-not-found
	direnv
  docker
	gcloud
	git
	fzf
	golang
	helm
	kubectl
	pipenv
	terraform
	ssh-agent
	virtualenv
	zsh-autosuggestions
	)


#
# aliases
#
alias l='eza --icons -lgas=changed --time-style=long-iso'
alias ls='eza --icons -as=changed'
alias lt='eza --icons -Tas=changed'
alias ll='eza --icons -lgas=changed --time-style=long-iso | less'

alias tf='terraform'
alias v='nvim'
alias k='kubecolor'

alias g='git'
alias gi='git init --initial-branch=main'
alias gc='git commit -m'

alias bathelp='bat --plain --language=help'

#
# fzf
#
source <(fzf --zsh)
export FZF_COMPLETION_TRIGGER='~~'
export FZF_COMPLETION_OPTS='--border --info=inline'

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
    ssh)          fzf "$@" --preview 'dig {}' ;;
    *)            fzf "$@" ;;
  esac
}

#
# k8s
#
source <(kubectl completion zsh)
compdef kubecolor=kubectl

# man pages settings
#
export MANPATH="/opt/homebrew/opt/coreutils/libexec/gnuman:$MANPATH"
export MANWIDTH=75
export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"

man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[0;37;102m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[4;32m") \
        PAGER=/usr/bin/less \
        _NROFF_U=1 \
        PATH=${HOME}/bin:${PATH} \
    man "$@"
}

#
# brew
#
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

#
# other settings
#
export GOPATH=$HOME/go
[[ -f ~/.config/op/plugins.sh ]] && source ~/.config/op/plugins.sh
eval $(/opt/homebrew/bin/brew shellenv)

_direnv_hook() {
  trap -- '' SIGINT
  eval "$("/opt/homebrew/bin/direnv" export zsh)"
  trap - SIGINT
}
typeset -ag precmd_functions
if (( ! ${precmd_functions[(I)_direnv_hook]} )); then
  precmd_functions=(_direnv_hook $precmd_functions)
fi
typeset -ag chpwd_functions
if (( ! ${chpwd_functions[(I)_direnv_hook]} )); then
  chpwd_functions=(_direnv_hook $chpwd_functions)
fi


#
# bat config
#
help() {
    "$@" --help 2>&1 | bathelp
}


#
# nvm
#
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ];
then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
export PATH=$HOME/go/bin:$PATH

# colima
export DOCKER_HOST=unix://$HOME/.colima/default/docker.sock

export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/bin:$PATH"


