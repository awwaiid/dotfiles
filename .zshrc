#!/bin/zsh

# awwaiid's .zshrc
# Symlink from .profile and .bash_profile to this and all will be well

# if [ -n $PS1 ]; then
#   : # These are executed only for interactive shells
# else
#   : # Only for NON-interactive shells
# fi

# if shopt -q login_shell ; then
#   : # These are executed only when it is a login shell
# else
#   : # Only when it is NOT a login shell
# fi

# Hack for stupid mosh
if [ "$TERM" = "xterm-256color" ] ; then
  TERM=rxvt-unicode-256color exec zsh
fi

PAGER=/usr/bin/less
PATH=$HOME/bin:$HOME/local/bin:$HOME/.local/bin:$PATH
EDITOR=nvim

# Fix HOSTNAME if it hasn't been set
: ${HOSTNAME:=$HOST}

if [ -n "$ZSH_VERSION" ]; then
  autoload -U colors && colors
  PS1="%{%B$fg[green]%}%n@%m:%{%B$fg[yellow]%}%~%{$reset_color%}$ "
else
  PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;33m\]\w\[\033[00m\]\$ '
fi

# Locale stuff
export LANG=en_US.UTF-8
export TZ='America/New_York'

[ -x /usr/bin/dircolors ] && eval `dircolors $HOME/.dir_colors`

#  shopt -s checkwinsize # update LINES and COLUMNS

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# Set the xterm-compatible title to user@host:dir
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'

alias ls='ls -F --color --dereference-command-line-symlink-to-dir'
alias ocaml='rlwrap ocaml || ocaml'
alias open='xdg-open'
alias log-optoro='task log proj:optoro'

# Experimental use nvim without thinking
alias vim=nvim

# enable programmable completion features
#  if [ -f /etc/bash_completion ]; then
    #  source /etc/bash_completion
#  fi

# Try to fix xmonad-vs-openoffice
export SAL_USE_VCLPLUGIN=gen

# Try to fix java + tiling issue
export _JAVA_AWT_WM_NONREPARENTING=1

# Make a handy little calculator!
#  calc() { bc <<< "scale=5; $*"; }

## History
HISTFILE=$HOME/.zhistory      # enable history saving on shell exit
HISTSIZE=1200                 # lines of history to maintain memory
SAVEHIST=10000                # lines of history to maintain in history file.
HISTCONTROL=ignoredups        # No dups in bash_history

# Bunch of zsh-specific stuff
if [ -n "$ZSH_VERSION" ]; then
  # echo "Setting up zsh stuff"
  setopt APPEND_HISTORY         # append rather than overwrite history file.
  setopt HIST_EXPIRE_DUPS_FIRST # allow dups, but expire old ones when I hit HISTSIZE
  setopt EXTENDED_HISTORY       # save timestamp and runtime information

  # Rehash stuff all the time
  zstyle ":completion:*:commands" rehash 1

  # autoload -Uz compinit
  # compinit
  # # be verbose, i.e. show descriptions
  # zstyle ':completion:*' verbose yes
  # zstyle ':completion:*:descriptions' format '%U%B%d%b%u'

  # # group by tag names
  # zstyle ':completion:*' group-name ''

  # -------------------------------------------------------
  # OH MY! ZSH!
  #
  # Path to your oh-my-zsh configuration.
  ZSH=$HOME/.oh-my-zsh

  # Set name of the theme to load.
  # Look in ~/.oh-my-zsh/themes/
  # Optionally, if you set this to "random", it'll load a random theme each
  # time that oh-my-zsh is loaded.
  # ZSH_THEME="robbyrussell"
  ZSH_THEME="genehack"

  # Example aliases
  # alias zshconfig="mate ~/.zshrc"
  # alias ohmyzsh="mate ~/.oh-my-zsh"

  # Set to this to use case-sensitive completion
  # CASE_SENSITIVE="true"

  # Comment this out to disable bi-weekly auto-update checks
  DISABLE_AUTO_UPDATE="true"

  # Uncomment to change how often before auto-updates occur? (in days)
  # export UPDATE_ZSH_DAYS=13

  # Uncomment following line if you want to disable colors in ls
  # DISABLE_LS_COLORS="true"

  # Uncomment following line if you want to disable autosetting terminal title.
  # DISABLE_AUTO_TITLE="true"

  # Uncomment following line if you want to disable command autocorrection
  # DISABLE_CORRECTION="true"

  # Uncomment following line if you want red dots to be displayed while waiting for completion
  # COMPLETION_WAITING_DOTS="true"

  # Uncomment following line if you want to disable marking untracked files under
  # VCS as dirty. This makes repository status check for large repositories much,
  # much faster.
  # DISABLE_UNTRACKED_FILES_DIRTY="true"

  # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
  # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
  # Example format: plugins=(rails git textmate ruby lighthouse)
  plugins=(git)

  # source $ZSH/oh-my-zsh.sh

  setopt prompt_subst
  autoload -Uz vcs_info
  zstyle ':vcs_info:*' formats       \
      '%F{2}[%F{2}%b%F{2}]%f'
      #  '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
  zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

  zstyle ':vcs_info:*' enable git cvs svn

  # or use pre_cmd, see man zshcontrib
  vcs_info_wrapper() {
    vcs_info
    if [ -n "$vcs_info_msg_0_" ]; then
      echo "%{$fg[lightgrey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
    fi
  }
  RPROMPT=$'$(vcs_info_wrapper)'

  # Experimental ctrl-backspace
  bindkey -M emacs '' backward-kill-word
fi

# echo "Setting up other stuff"

# Fix mosh's escape key
export MOSH_ESCAPE_KEY='~'

# Task Warrior!
# source /usr/local/share/doc/task/scripts/zsh/_task

# FZF: Cool fuzzy finder thing
export FZF_TMUX=0
export FZF_DEFAULT_COMMAND='ag -l -g ""'
export FZF_DEFAULT_OPTS="--reverse"
[[ -f "$HOME/.fzf.zsh" ]] && source ~/.fzf.zsh

# ========= Languages and tooling =============

# Android: SDK
export PATH=$PATH:~/local/android-sdk-linux/tools

# Perl6: Rakudobrew
if [ -d ~/.rakudobrew ] ; then
  export PATH=~/.rakudobrew/bin:$PATH
fi

# OCaml: OPAM configuration
[ -f ~/.opam/opam-init/init.zsh ] && . ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# Python: pyenv
if [ -d ~/.pyenv ] ; then
  # echo "Setting up pyenv"
  export PYENV_VIRTUALENV_DISABLE_PROMPT=1
  export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init - >/dev/null)"
fi

# NodeJS: nvm
if [ -d ~/.nvm ] ; then
  # echo "Setting up nvm"
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
fi

# Perl5: cpanm
PERL_CPANM_OPT="--quiet"

# Perl5: Perlbrew
if [ -f ~/local/perlbrew/etc/bashrc ]; then
  # echo "Setting up perlbrew"
  export PERLBREW_ROOT=~/local/perlbrew
  source ~/local/perlbrew/etc/bashrc
fi

# Ruby: misc settings
export RUBY_GC_MALLOC_LIMIT=90000000
alias be='bundle exec'

# Ruby: rvm
if [ -f ~/.rvm/scripts/rvm ]; then
  # echo "Setting up rvm"
  source ~/.rvm/scripts/rvm
fi

if [ -f ~/.nix-profile/etc/profile.d/nix.sh ]; then
  source ~/.nix-profile/etc/profile.d/nix.sh
fi

bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line

[[ `hostname` == "koopa" ]] && export TERM=rxvt-unicode-256color

# echo "DONE loading zshrc!"


export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

