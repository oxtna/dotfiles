# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# set a fancy prompt
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    color_prompt=yes
    else
    color_prompt=
    fi
fi

PROMPT_COMMAND=__prompt_command

__prompt_command() {
    local exit_code="$?"
    # Prompt separator
    local separator="\[\e[97m\]:\[\e[0m\]"

    # Chroot
    PS1=" \[\e[35m\]${debian_chroot:+$debian_chroot}${debian_chroot:+ ${separator} }\[\e[0m\]"
    # Timestamp
    PS1+="\[\e[93m\]\t ${separator} \[\e[0m\]"
    # User@Host
    PS1+="\[\e[92m\]\u\[\e[94m\]@\[\e[92m\]\h ${separator} \[\e[0m\]"
    # Current Directory
    PS1+="\[\e[96m\]\w \[\e[0m\]"
    # Error Code
    if [ ${exit_code} -ne 0 ]; then
        PS1+="${separator} \[\e[31m\]${exit_code} \[\e[0m\]"
    fi
    # If effective UID is 0 (user is root), `#`, otherwise `$`
    PS1+="\[\e[97m\]\\$ \[\e[0m\]"
}

unset color_prompt force_color_prompt

# enable color support of ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# set neovim as the default text editor
export EDITOR=nvim
export VISUAL=nvim

