# Created by newuser for 5.3.1
#
# ---- ---- ---- zplug ---- ---- ----
#
source ~/.zplug/init.zsh
# Make sure to use double quotes
zplug "zsh-users/zsh-history-substring-search"

# Use the package as a command
# And accept glob patterns (e.g., brace, wildcard, ...)
zplug "Jxck/dotfiles", as:command, use:"bin/{histuniq,color}"

# Disable updates using the "frozen" tag
zplug "k4rthik/git-cal", as:command, frozen:1

# zsh syntax highlight
zplug "zsh-users/zsh-syntax-highlighting", defer:2
 

# Supports checking out a specific branch/tag/commit
zplug "b4b4r07/enhancd", at:v1
zplug "mollifier/anyframe", at:4c23cb60

# Can manage local plugins
zplug "~/.zsh", from:local

# Load theme file
zplug 'oskarkrawczyk/honukai-iterm-zsh', as:theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

# ---- ---- ---- BASIC ---- ---- ----
#
# alias
#
alias la='ls -a'
alias lla='ls -la'
alias gst='git status'
alias glg='git log'
alias gad='git add'
alias gcm='git commit'
alias nyao='git'
alias oppai='git'

eval "$(pyenv init -)"
