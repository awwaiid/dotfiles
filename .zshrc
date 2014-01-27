#!/bin/zsh
# awwaiid's .bashrc
# Symlink from .profile and .bash_profile to this and all will be well

# Source global definitions
#  if [ -f /etc/bashrc ]; then
  #  . /etc/bashrc
#  fi

if [ -n $PS1 ]; then
  : # These are executed only for interactive shells

  PAGER=/usr/bin/less
  PATH=$HOME/bin:$HOME/local/bin:$PATH
  EDITOR=vim

  # PS1='\u@\h:\w\$ '
  #  PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;33m\]\w\[\033[00m\]\$ '
  #  \e[0;31m
  #  PS1=$'\e[01;32m%n@%m\e[00m:\e[01;33m%~\e[00m$ '
  #  PS1="%{%B$fg[green]%}%n%{$reset_color%}%{%B$fg[cyan]%}@%m:%{%B$fg[yellow]%}%~%{$reset_color%}$ "
  autoload -U colors && colors
  PS1="%{%B$fg[green]%}%n@%m:%{%B$fg[yellow]%}%~%{$reset_color%}$ "

  # Locale stuff
  export LANG=en_US.UTF-8
  export TZ='America/New_York'

  [ -x /usr/bin/dircolors ] && eval `dircolors $HOME/.dir_colors`

  export HISTCONTROL=ignoredups # No dups in bash_history
  #  shopt -s checkwinsize # update LINES and COLUMNS

  # make less more friendly for non-text input files, see lesspipe(1)
  [ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

  # Set the xterm-compatible title to user@host:dir
  PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
  
  # export LS_COLORS=auto
  alias ls='ls -F --color --dereference-command-line-symlink-to-dir'
  alias ocaml='rlwrap ocaml || ocaml'
  alias open='gnome-open'
  # alias perldoc=cpandoc
  alias log-optoro='task log proj:optoro'

  # Make cpanm even more succinct
  PERL_CPANM_OPT="--quiet"
  
  # enable programmable completion features
  #  if [ -f /etc/bash_completion ]; then
      #  source /etc/bash_completion
  #  fi

  # Yummy perlbrew -- local perl install
  if [ -f ~/local/perlbrew/etc/bashrc ]; then
      export PERLBREW_ROOT=~/local/perlbrew
      source ~/local/perlbrew/etc/bashrc
      #  source setup-bash-complete
  fi

  # Yummy rvm -- local ruby install
  if [ -f ~/.rvm/scripts/rvm ]; then
    source ~/.rvm/scripts/rvm
  fi

  # Make a handy little calculator!
  #  calc() { bc <<< "scale=5; $*"; }

  ## History
  HISTFILE=$HOME/.zhistory       # enable history saving on shell exit
  setopt APPEND_HISTORY          # append rather than overwrite history file.
  HISTSIZE=1200                  # lines of history to maintain memory
  SAVEHIST=1000                  # lines of history to maintain in history file.
  setopt HIST_EXPIRE_DUPS_FIRST  # allow dups, but expire old ones when I hit HISTSIZE
  setopt EXTENDED_HISTORY        # save timestamp and runtime information
  zstyle ":completion:*:commands" rehash 1

  # Taskwarrior!
  fpath=($fpath /usr/local/share/doc/task/scripts/zsh)
  autoload -Uz compinit
  compinit
  # be verbose, i.e. show descriptions
  zstyle ':completion:*' verbose yes
  zstyle ':completion:*:descriptions' format '%U%B%d%b%u'

  # group by tag names
  zstyle ':completion:*' group-name ''

else
    : # Only for NON-interactive shells
  export PATH=$HOME/bin:$HOME/local/bin:$PATH
fi

#  if shopt -q login_shell ; then
    #  : # These are executed only when it is a login shell
#  else
    #  : # Only when it is NOT a login shell
#  fi




# PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

