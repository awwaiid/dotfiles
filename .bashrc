# awwaiid's .bashrc
# Symlink from .profile and .bash_profile to this and all will be well

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

if [ -n $PS1 ]; then
  : # These are executed only for interactive shells

  PAGER=/usr/bin/less
  PATH=$HOME/bin:$PATH
  # PS1='\u@\h:\w\$ '
  PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;33m\]\w\[\033[00m\]\$ '

  # Locale stuff
  export LANG=en_US.UTF-8
  export TZ='America/New_York'

  [ -x /usr/bin/dircolors ] && eval `dircolors $HOME/.dir_colors`

  export HISTCONTROL=ignoredups # No dups in bash_history
  shopt -s checkwinsize # update LINES and COLUMNS

  # make less more friendly for non-text input files, see lesspipe(1)
  [ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

  # Set the xterm-compatible title to user@host:dir
  PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
  
  # export LS_COLORS=auto
  alias ls='ls -F --color'
  alias ocaml='rlwrap ocaml || ocaml'
  alias open='gnome-open'

  # enable programmable completion features (you don't need to enable
  # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
  # sources /etc/bash.bashrc).
  if [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
  fi

else
    : # Only for NON-interactive shells
fi

if shopt -q login_shell ; then
    : # These are executed only when it is a login shell
else
    : # Only when it is NOT a login shell
fi



