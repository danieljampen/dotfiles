#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias clock='tty-clock -c -B -D'
alias youtube='mpsyt'
alias tui='s-tui'
#alias trim='sudo fstrim / -v'

trap 'echo -ne "\e[0m"' DEBUG

[ -e "/etc/DIR_COLORS" ] && DIR_COLORS="/etc/DIR_COLORS"
[ -e "$HOME/.dircolors" ] && DIR_COLORS="$HOME/.dircolors"
[ -e "$DIR_COLORS" ] || DIR_COLORS=""
eval "`dircolors -b $DIR_COLORS`"

Color_Off="\033[0m"
Red="\033[0;31m"
Green="\033[0;32m"
Purple="\033[0;35m"

# Command prompt
function __prompt_command()
{
    # capture the exit status of the last command
    EXIT="$?"
    PS1=""
 
    if [ $EXIT -eq 0 ]; then PS1+="\[$Green\][\!]\[$Color_Off\] "; else PS1+="\[$Red\][\!]\[$Color_Off\] "; fi
 
    # if logged in via ssh shows the ip of the client
    if [ -n "$SSH_CLIENT" ]; then PS1+="\[$Yellow\]("${$SSH_CLIENT%% *}")\[$Color_Off\]"; fi
 
    # debian chroot stuff (take it or leave it)
    PS1+="${debian_chroot:+($debian_chroot)}"
 
    # basic information (user@host:path)
    PS1+="\[$BRed\]\u\[$Color_Off\]@\[$BRed\]\h\[$Color_Off\]:\[$BPurple\]\w\[$Color_Off\] "
 
    # check if inside git repo
    local git_status="`git status -unormal 2>&1`"    
    if ! [[ "$git_status" =~ not\ a\ git\ repo ]]; then
        # parse the porcelain output of git status
        if [[ "$git_status" =~ nothing\ to\ commit ]]; then
            local Color_On=$Green
        elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
            local Color_On=$Purple
        else
            local Color_On=$Red
        fi
 
        if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
            branch=${BASH_REMATCH[1]}
        else
            # Detached HEAD. (branch=HEAD is a faster alternative.)
            branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null || echo HEAD`)"
        fi
 
        # add the result to prompt
        PS1+="\[$Color_On\][$branch]\[$Color_Off\] "
    fi
 
    # prompt $ or # for root
    PS1+="\$ "
}
PROMPT_COMMAND=__prompt_command

