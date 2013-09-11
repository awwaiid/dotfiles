# -*- sh -*-
function svn_dir {
    [ -d ".svn" ] || return 1

    autostash alias pull="svn up"
    autostash alias commit="svn commit"
    autostash alias push="svn ci"
    autostash alias revert="svn revert"

    base_dir="."
    while [ -d "$base_dir/../.svn" ]; do base_dir="$base_dir/.."; done
    base_dir=`cd $base_dir; pwd`

    vcs=svn
}

function git_dir {
    base_dir=$(git rev-parse --show-cdup 2>/dev/null) || return 1

    if [ -n "$base_dir" ]; then
	base_dir=`cd $base_dir; pwd`
    else
	base_dir=$PWD
    fi

    #  autostash alias cleanup="git fsck && git gc"
    #  autostash alias commit="git commit -s"
    #  autostash alias dc="d --cached"
    #  autostash alias l="git log"
    #  autostash alias lg="git lg"
    #  autostash alias lp="l -p"
    #  autostash alias lgp="git lg -p"
    #  autostash alias lss="l --stat --summary"
    #  autostash alias newbranch="git checkout -b"
    #  autostash alias pull="git pull"
    #  autostash alias push="commit ; git push"
    #  autostash alias revert="git checkout"

    vcs=git
}

function precmd {
  local load vcs base_dir sub_dir ref P1 P2 P3 P4

  # time
  P1="%{$fg_bold[light_grey]%}%*%{$reset_color%}"
  # host
  P2="%{$fg[green]%}%m%{$reset_color%}"

  # load average
  if [[ -e /proc/loadavg ]]; then
      load=$( cut -f1 -d' ' /proc/loadavg )
      P3="[%{$fg[blue]%}$load%{$reset_color%}] "
  else
      P3=""
  fi

  # exit status and error come
  P4="%(?,%{$fg[green]%}☺%{$reset_color%},%{$fg[red]%}☹ [ $? ]%{$reset_color%})"

  # git info
  ZSH_THEME_GIT_PROMPT_PREFIX=""
  ZSH_THEME_GIT_PROMPT_SUFFIX=""
  ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗%{$reset_color%} "
  ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}•%{$reset_color%} "
  ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[blue]%}✭%{$reset_color%}"
  ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}✚%{$reset_color%}"
  ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}✹%{$reset_color%}"
  ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[white]%}➜%{$reset_color%}"
  ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✖%{$reset_color%}"
  ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%}═%{$reset_color%}"

  STATUS=""
  CHERRY=$(git cherry 2> /dev/null)
  if [ -n "$CHERRY" ]; then
      STATUS="%{$fg[cyan]%}↑%{$reset_color%}"
  fi

  STASH=$(git stash list 2> /dev/null | tail -n1)
  if [ -n "$STASH" ]; then
      STATUS="%{$fg[red]%}%{$bg[white]%}↓%{$reset_color%}"
  fi
  # /git info

  PROMPT="
$P2:%{$fg_bold[yellow]%}%~%{$reset_color%}
$P3$P4 %# "

  RPROMPT="$(git_prompt_info)$(git_prompt_status)$STATUS $P1"

  git_dir || svn_dir

  if [ -n "$vcs" ]; then
      #  autostash alias st="$vcs status"
      #  autostash alias d="$vcs diff"
      #  autostash alias up="pull"
      #  autostash alias cdb="cd $base_dir"
  fi

}
