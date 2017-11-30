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
#                            install
# ================================================================

# Set DOTPATH as default variable
if [ -z "${DOTPATH:-}" ]; then
  DOTPATH=~/.dotfiles; export DOTPATH
fi

DOTFILES_GITHUB="https://github.com/shinkwhek/dotpapyrus.git"; export DOTFILES_GITHUB

dotfiles_download() {
  if [ -d "$DOTPATH" ]; then
    log_fail "$DOTPATH: already exists"
    exit 1
  fi

  e_newline
  e_header "Downloading dotfiles..."

  if is_exists "git"; then
    # --recursive equals to ...
    # git submodule init
    # git submodule update
    git clone --recursive "$DOTFILES_GITHUB" "$DOTPATH"

  elif is_exists "curl" || is_exists "wget"; then
    # curl or wget
    local tarball="https://github.com/shinkwhek/dotpapyrus/archive/master.tar.gz"
    if is_exists "curl"; then
      curl -L "$tarball"

    elif is_exists "wget"; then
      wget -O - "$tarball"

    fi | tar xvz
    if [ ! -d dotpapyrus-master ]; then
      log_fail "dotpapyrus-master: not found"
      exit 1
    fi
    command mv -f dotpapyrus-master "$DOTPATH"

  else
    log_fail "curl or wget required"
    exit 1
  fi
  e_newline && e_done "Download"
}

dotfiles_deploy() {
  e_newline
  e_header "Deploying dotfiles..."

  if [ ! -d $DOTPATH ]; then
    log_fail "$DOTPATH: not found"
    exit 1
  fi

  cd "$DOTPATH"
  make deploy
  e_newline && e_done "Deploy"
}

dotfiles_initialize() {
  e_newline
  e_header "Initializing dotfiles..."
  if [ -f Makefile ]; then
    #DOTPATH="$(dotpath)"
    #export DOTPATH
    #bash "$DOTPATH"/etc/init/init.sh
    make init
  else
    log_fail "Makefile: not found"
    exit 1
  fi &&
    e_newline && e_done "Initialize"
}

# A script for the file named "install"
dotfiles_install() {
  dotfiles_download && dotfiles_deploy &&  dotfiles_initialize
}

# -> bash a.sh
if [ "$0" = "${BASH_SOURCE:-}" ]; then
  exit
fi

if [ -n "${BASH_EXECUTION_STRING:-}" ] || [ -p /dev/stdin ]; then

  dotfiles_install

  # Restart shell if specified "bash -c $(curl -L {URL})"
  # not restart:
  #   curl -L {URL} | bash
  if [ -p /dev/stdin ]; then
    e_warning "Now continue with Rebooting your shell"
  else
    e_newline
    e_arrow "Restarting your shell..."
    exec "${SHELL:-/bin/zsh}"
  fi
fi