##### Extract Function ######
function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
 else
    if [ -f $1 ] ; then
        case $1 in
          *.tar.bz2)   tar xvjf ../$1    ;;
          *.tar.gz)    tar xvzf ../$1    ;;
          *.tar.xz)    tar xvJf ../$1    ;;
          *.lzma)      unlzma ../$1      ;;
          *.bz2)       bunzip2 ../$1     ;;
          *.rar)       unrar x -ad ../$1 ;;
          *.gz)        gunzip ../$1      ;;
          *.tar)       tar xvf ../$1     ;;
          *.tbz2)      tar xvjf ../$1    ;;
          *.tgz)       tar xvzf ../$1    ;;
          *.zip)       unzip ../$1       ;;
          *.Z)         uncompress ../$1  ;;
          *.7z)        7z x ../$1        ;;
          *.xz)        unxz ../$1        ;;
          *.exe)       cabextract ../$1  ;;
          *)           echo "extract: '$1' - unknown archive method" ;;
        esac
    else
        echo "$1 - file does not exist"
    fi
fi
}
#######################################################################
#
# Find & generate import string for giving class name
# ---------------------------------------------------------------------
#
# I got fed up seeing classes referenced in django docs, with no easy way
# to find where they were imported from. (too much scrolling)
# Simple recursive grep command to search through virtualenv site packages
# folder for class you supply. For sake of speed, matching case is required
# (camel case that suckah)
#
# Usage:
#   imp ValidationError
#
#   NOTE: REQUIRES ACTIVE VIRTUALENV (uses sitepackages)
#----------------------------------------------------------------------

imp() {
    cyan='\e[1;36m'
    NC='\e[0m'
    red='\e[0;31m'
    echo ""
    echo "Searching for ${cyan}$1${NC}"
    python -c 'import sys; print sys.real_prefix' 2>/dev/null && INVENV=1 || INVENV=0
    if [ $INVENV -eq 1 ]
    then
        cdsitepackages > /dev/null
        echo ""
        grep -r "class "$1 | while read -r line ; do
        line=${line//.py*}
        line="from "${line//\//.}" import $1"

        echo $line
        done
        echo ""
  grep -r "def "$1 | while read -r line ; do
        line=${line//.py*}
        line="from "${line//\//.}" import $1"

        echo $line
        done
        cd - > /dev/null

    else
        echo ""
        echo "${red}no virtual env detected${NC}"
    fi
}

##### DEV OPS #####
alias ps="ps auxf" # process listing table
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e" # searchable process listing table ($ psg postgres)

alias fhere="find . -name " #find here (find files in current dir)

alias df="df -Tha --total" # display disk usage in readable format
alias du="du -ach | sort -h" # moar disk usage

alias top="htop"  #better formatted top command
alias histg="history | grep" # display recent history. (helpful to get history id: ie: removing an accidental password entry)
alias wget="wget -c"  # -c will allow for continuable downloads
#####

##### Git #####
alias gitall="git commit -am" #trigger git commit all command.
#####

##### Development Folder control #####
bak(){
  # quick backup of file
  cp ./$1 ./$1-bak
}

rest(){
  # quick restore of file
  cp ./$1-bak ./$1
  rm ./$1-bak
}

mcd () {
  # mkdir and navigate to it
  mkdir -pv $1
  cd $1
}

sshme(){
  grep -A 4 $1 ~/.ssh/config
}



alias mkdir="mkdir -pv" # recursive mkdir
alias op="nautilus ./"  # open current directory in nautilus
alias ophome="nautilus ~/"  # open home in nautilus
alias cddev="cd ~/Development/" # goto my local dev folder
alias nautdev="nautilus ~/Development/"
alias cdlift="cd ~/Development/Lift/"
alias nautdev="nautilus ~/Development/Lift"
#####

##### Django Dev #####
alias run="python manage.py runserver" # run local django server
alias runp="python manage.py runserver_plus" # run location django plus server
#####

alias editalias="subl ~/Development/bash_aliases/aliases.sh"

alias fig="docker-compose"

alias purgepyc="find . -name '*.pyc' -print0 | xargs -0 rm;"