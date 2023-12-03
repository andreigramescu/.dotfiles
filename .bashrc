[ -f $HOME/.bash_popos_defaults ] && source $HOME/.bash_popos_defaults

bind -s 'set completion-ignore-case on'

find_file_global() {
    find / -name $1 -type f -print 2>/dev/null
}

PROMPT_COMMAND=__prompt_command
__prompt_command() {
    local EXIT="$?"
    PS1=""

    local COLOR_WHITE='\[\e[0m\]'
    local COLOR_RED='\[\e[0;31m\]'
    local COLOR_GREEN='\[\e[0;32m\]'
    local COLOR_YELLOW='\[\e[1;33m\]'
    local COLOR_BLUE='\[\e[1;34m\]'

    PS1+="${COLOR_BLUE}\u${COLOR_WHITE}@${COLOR_BLUE}\h ${COLOR_GREEN}\w"
    PS1+="${COLOR_YELLOW}$(__git_ps1)"

    if [ $EXIT != 0 ]; then
	PS1+="${COLOR_RED}"
    else
	PS1+="${COLOR_WHITE}"
    fi

    PS1+=" $ ${COLOR_WHITE}"
}
