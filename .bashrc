[ -f $HOME/.bash_popos_defaults ] && source $HOME/.bash_popos_defaults
[ -f $HOME/.git-prompt.sh ] && source $HOME/.git-prompt.sh

find_file_global() {
    find / -name $1 -type f -print 2>/dev/null
}

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWCONFLICTSTATE="yes"

PROMPT_COMMAND=__prompt_command
__prompt_command() {
    local EXIT="$?"
    PS1=""

    local COLOR_WHITE='\[\e[0m\]'
    local COLOR_RED='\[\e[0;31m\]'
    local COLOR_GREEN='\[\e[1;32m\]'
    local COLOR_YELLOW='\[\e[1;33m\]'
    local COLOR_BLUE='\[\e[1;36m\]'

    PS1+="${COLOR_BLUE}\u${COLOR_WHITE}@${COLOR_BLUE}\h ${COLOR_GREEN}\w"
    PS1+="${COLOR_YELLOW}$(__git_ps1)"

    if [ $EXIT != 0 ]; then
	PS1+="${COLOR_RED}"
    else
	PS1+="${COLOR_WHITE}"
    fi

    PS1+=" $ ${COLOR_WHITE}"
}

test_colors() {
    # Taken from https://tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html
    
    T='gYw'   # The test text
    
    echo -e "\n                 40m     41m     42m     43m\
         44m     45m     46m     47m";
    
    for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
               '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
               '  36m' '1;36m' '  37m' '1;37m';
      do FG=${FGs// /}
      echo -en " $FGs \033[$FG  $T  "
      for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
        do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
      done
      echo;
    done
    echo
}
