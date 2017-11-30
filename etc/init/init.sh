#!/bin/bash

e_newline() {
  printf "\n"
}
e_header()  {
  printf " \033[37;1m%s\033[m\n" "$*"
}
e_error()   {
  printf " \033[31m%s\033[m\n" "✖ $*" 1>&2
}
e_warning() {
  printf " \033[31m%s\033[m\n" "$*"
}
e_done()    {
  printf " \033[37;1m%s\033[m...\033[32mOK\033[m\n" "✔ $*"
}
e_arrow()   {
  printf " \033[37;1m%s\033[m\n" "➜ $*"
}
e_indent() {
  for ((i=0; i<${1:-4}; i++)); do
    echon " "
  done
  if [ -n "$2" ]; then
    echo "$2"
  else
    cat <&0
  fi
}
die() {
  e_error "$1" 1>&2
  exit "${2:-1}"
}
e_success() {
  printf " \033[37;1m%s\033[m%s...\033[32mOK\033[m\n" "✔ " "$*"
}
e_failure() {
  die "${1:-$FUNCNAME}"
}

ink() {
  if [ "$#" -eq 0 -o "$#" -gt 2 ]; then
    echo "Usage: ink <color> <text>"
    echo "Colors:"
    echo "  black, white, red, green, yellow, blue, purple, cyan, gray"
    return 1
  fi

  local open="\033["
  local close="${open}0m"
  local black="0;30m"
  local red="1;31m"
  local green="1;32m"
  local yellow="1;33m"
  local blue="1;34m"
  local purple="1;35m"
  local cyan="1;36m"
  local gray="0;37m"
  local white="$close"

  local text="$1"
  local color="$close"

  if [ "$#" -eq 2 ]; then
    text="$2"
    case "$1" in
      black | red | green | yellow | blue | purple | cyan | gray | white)
        eval color="\$$1"
        ;;
    esac
  fi

  printf "${open}${color}${text}${close}"
}
logging() {
  if [ "$#" -eq 0 -o "$#" -gt 2 ]; then
    echo "Usage: ink <fmt> <msg>"
    echo "Formatting Options:"
    echo "  TITLE, ERROR, WARN, INFO, SUCCESS"
    return 1
  fi

  local color=
  local text="$2"

  case "$1" in
    TITLE)
      color=yellow
      ;;
    ERROR | WARN)
      color=red
      ;;
    INFO)
      color=blue
      ;;
    SUCCESS)
      color=green
      ;;
    *)
      text="$1"
  esac

  timestamp() {
    ink gray "["
    ink purple "$(date +%H:%M:%S)"
    ink gray "] "
  }

  timestamp; ink "$color" "$text"; echo
}
log_pass() {
    logging SUCCESS "$1"
}
log_fail() {
    logging ERROR "$1" 1>&2
}
log_fail() {
    logging WARN "$1"
}
log_info() {
    logging INFO "$1"
}
log_echo() {
    logging TITLE "$1"
}

# is_exists returns true if executable $1 exists in $PATH
is_exists() {
    which "$1" >/dev/null 2>&1
    return $?
}
# is_login_shell returns true if current shell is first shell
is_login_shell() {
    [ "$SHLVL" = 1 ]
}
# is_git_repo returns true if cwd is in git repository
is_git_repo() {
    git rev-parse --is-inside-work-tree &>/dev/null
    return $?
}

# is_screen_running returns true if GNU screen is running
is_screen_running() {
    [ ! -z "$STY" ]
}
# is_tmux_runnning returns true if tmux is running
is_tmux_runnning() {
    [ ! -z "$TMUX" ]
}
# is_screen_or_tmux_running returns true if GNU screen or tmux is running
is_screen_or_tmux_running() {
    is_screen_running || is_tmux_runnning
}
# is_ssh_running returns true if the ssh deamon is available
is_ssh_running() {
    [ ! -z "$SSH_CLIENT" ]
}
# is_number returns true if $1 is int type
is_number() {
    if [ $# -eq 0 ]; then
        cat <&0
    else
        echo "$1"
    fi | grep -E '^[0-9]+$' >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        return 0
    else
        return 1
    fi
}

# ================================================================
#                            init
# ================================================================

# zplug
e_header "zplug installing"
if [ -e ${HOME}/.zplug ]; then
  e_arrow "zplug is already installed."
else
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
  e_success "zplug"
fi
log_pass "zplug"

# dein.vim
e_header "dein.vim installing"
if [ -e ${HOME}/.vim/bundles ]; then
  e_arrow "dein.vim is already installed."
else
  curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
  sh ./installer.sh ~/.vim/bundles
  rm ./installer.sh
  e_success "dein.vim"
fi
log_pass "dein.vim"
