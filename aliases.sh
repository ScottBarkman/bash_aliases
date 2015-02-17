##### Extract Function ######
# $EDITOR=nano
function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
 else
    if [ -f $1 ] ; then
        # NAME=${1%.*}
        # mkdir $NAME && cd $NAME
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


#### quick backup of file ####
bak(){
  cp ./$1 ./$1-bak
  # touch $1
}

#### quick restore of file ####
rest(){
  cp ./$1-bak ./$1
  rm ./$1-bak
}

#### mkdir and navigate to it ####
mcd () {
    mkdir -pv $1
    cd $1
}

alias mkdir="mkdir -pv" # recursive mkdir


alias ps="ps auxf" # process listing table
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e" # searchable process listing table ($ psg postgres)

alias fhere="find . -name " #find here (find files in current dir)

alias df="df -Tha --total" # display disk usage in readable format
alias du="du -ach | sort -h" # moar disk usage

alias top="htop"  #better formatted top command
alias histg="history | grep" # display recent history. (helpful to get history id: ie: removing an accidental password entry)
alias wget="wget -c"  # -c will allow for continuable downloads

alias comall="git commit -am" #trigger git commit all command.

alias run="python manage.py runserver" # run local django server

alias op="nautilus ./"  # open current directory in nautilus
alias ophome="nautilus ~/"  # open home in nautilus
alias gotodev="cd ~/Development/Lift" # goto my local dev folder

