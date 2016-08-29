
# Convert github link into raw link:
wgetgit() {
  wget `echo "$1" | sed 's/github.com/raw.githubusercontent.com/g'` "${@:1}"
}

source /etc/bash_completion.d/git

# Moved to /usr/local/bin:
#alias wifi='sudo iwconfig wlp4s0 power off && sudo wifi-menu'
#alias eth0-start='sudo $HOME/bin/eth0-start'

[ -e $HOME/.secret ] && source $HOME/.secret

echoerr() { echo "$@" 1>&2; }
export -f echoerr

# Adds '$1' to the end of the PATH variable
pathadd() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    if [ -z "$PATH" ]; then
      export PATH="$1"
    else
      export PATH="$PATH:$1"
    fi  
    #export PATH="${PATH:+"$PATH:"}$1"
  elif [ ! -d "$1" ]; then
    echoerr "pathadd: '$1' is not a directory"
  fi  
}
export -f pathadd

# Adds '$1' to the beginning of the PATH variable:
pathadd_unsafe() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    if [ -z "$PATH" ]; then
      export PATH="$1"
    else
      export PATH="$1:$PATH"
    fi  
  elif [ ! -d "$1" ]; then
    echoerr "pathadd_unsafe: '$1' is not a directory"
  fi  
}
export -f pathadd_unsafe

pathadd_ignore()        { [ -d $1 ] && pathadd "$1"; }
pathadd_unsafe_ignore() { [ -d $1 ] && pathadd_unsafe "$1"; }

find() {
  path=$1
  shift
  /usr/bin/find $path -regextype posix-egrep $@
}

# Ignore year, and add seconds when doing research / working on recent things:
alias ls2='/bin/ls --color=auto --time-style="+%b %d %H:%M:%S"'

# Last thing in list of output is most recently modified:
alias lst='ls2 -lahtr'

up() {
  n=$1
  if [ -z "$n" ]; then n=4; fi
  for i in `seq 1 $n`; do cd ../; done
}

# Old debian PS1:
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# Removed chroot junk:
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
export PROMPT_DIRTRIM=2

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias grepjava='grep --include=\*.java -rn . -e'
alias grephs='grep --include=\*.hs -rnw . -e'
alias grepjikes='grep -rn . -e'
alias ppl='cd $HOME/w/ppl/git/deckbuild/hakaru'

alias gdm='systemctl start gdm'

# Infinite history, but fix resulting broken GDB history:
export HISTSIZE=
export HISTFILESIZE=
export HISTTIMEFORMAT="[%F %T] "
export HISTFILE=~/.bash_eternal_history
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
export GDBHISTFILE=~/.gdb_eternal_history
export GDBHISTSIZE=70000000
#alias gdb='/usr/bin/gdb "$@"'

export LESS="-R"
export LESSOPEN='|~/.lessfilter %s'

export LANG=en_US.UTF-8
export HOSTNAME=`hostname`
export GIT_EDITOR=vim
export EDITOR=vim
alias c='clear'
alias rm='rm -i'
alias vi='vim'
alias yes='echo yes'
alias src='source ~/.bashrc'

export PADS_HASKELL=$HOME/r/pads/git
export PADS_HOME=$HOME/r/pads/pads
export RESEARCH=/mnt/Ragnorak/r
p() {
  cd $RESEARCH/pads/pads
  export PADS_HOME=$HOME/r/pads/pads
  export OCAML_LIB_DIR=/usr/lib/ocaml
  . $PADS_HOME/scripts/Q_DO_SETENV.sh

  # PADS / ML:
  #export PADS_HOME=$HOME/r/pads/padsc/padsc_runtime
  #export PML_HOME=$HOME/r/pads/padsc
  #export OCAML_BIN_DIR=/usr/bin/
  #export OCAML_LIB_DIR=/usr/lib/ocaml/
  #export CAMLIDL_LIB_DIR=$OCAML_LIB_DIR
  #. $PADS_HOME/scripts/Q_DO_SETENV.sh
}

j() {
  cd $RESEARCH/permc
  JDK=$HOME/bin/jdk1.6.0_45
  export JAVA_HOME=$JDK
  pathadd_unsafe $JDK/bin
  alias ls=ls2
}
alias jj='j; cd pin/source/tools/Jikes'

l() {
  # l u = light up
  # l d = light down
  if [ "$1" == "u" ]; then
    xbacklight -inc 20
  elif [ "$1" == "d" ]; then
    xbacklight -dec 20
  fi
}

gitme() { git commit --date "`stat -c %y $1`" $1; } # 2015-08-20 12:56:07.900488383 -0400
export PYTHONSTARTUP=$HOME/.pythonrc.py
#export PYTHONPATH="$PATHPATH:/usr/local/lib/python3.5"
#alias python='python3.5'

alias minecraft="java -jar $HOME/bin/Minecraft.jar"

inLXC() { cat /proc/1/cgroup | grep -q lxc; }
! inLXC && mesg n

alias t='gnome-terminal&'
alias term='gnome-terminal&'

alias reindent='python /usr/share/doc/python2.7/examples/Tools/scripts/reindent.py'

alias KillKyle='echo Mr. Lincoln has just been shot!'
alias clare='clear'
alias clar='clear'
alias claer='clear'
alias lear='clear'
alias vector='echo VECTOR BAH.'
alias quantum='echo QUANTUM SPOON.'

alias pdf='evince'
alias natty='nautilus `pwd` &'
#alias python3.1='/usr/local/bin/python3.1'

alias printers='/usr/bin/system-config-printer &'
alias fonts='sudo font-manager &'
alias httpd.conf='cd /etc/apache2/'
alias apacheconfig='cd /etc/apache2/'

alias du="du --human-readable --max-depth=1"

#alias python3="/usr/bin/python3.1"
alias mkv2avi="/usr/local/bin/mkv2avi.sh"
alias soffice=libreoffice

#export ANDROID_SDK=$HOME/bin/android-sdk-linux
export ANDROID_SDK=/opt/android-sdk


pathadd $HOME/bin

p=pathadd_ignore
$p $ANDROID_SDK/platform-tools    # android platform tools
$p $HOME/bin/gradle-2.6/bin       # gradle
$p $HOME/bin/btsync               # btsync
$p $HOME/bin.local                # Local bin?
$p $HOME/Private/bin              # Encrypted bin
$p $HOME/go/bin                   # Go
$p $HOME/bin/processing-3.1.1     # Processing
unset p

# Haskell:
#export GHC_HOME=$HOME/bin/ghc-dev
export GHC_HOME=$HOME/bin/ghc-7.10.2/inst

#pathadd_unsafe $GHC_HOME/bin

# TODO: re-add?
#pathadd_unsafe $HOME/.cabal/bin

export GHC_HOME_IA32=$HOME/bin/ghc-7.10.2-i386/inst
export GOPATH=~/go

alias getIP='dig +short myip.opendns.com @resolver1.opendns.com'
alias lsblk='lsblk -o NAME,SIZE,FSTYPE,TYPE,RO,LABEL,UUID,MOUNTPOINT'
alias dt='date +%Y-%b-%d'
alias dircmp='diff <(cd $1 && find | sort) <(cd $2 && find | sort)' # 2015-08-20 13:11:34.196481549 -0400 
alias chrome="/usr/bin/google-chrome-stable" #--incognito"
alias google-chrome="chrome"
alias google-chrome-stable="chrome"
alias xclipv='xclip -selection clipboard'
alias vi!='vi `!!`'
alias hodges='echo stupid zach, hodges are for kids'
alias tamper='sudo wifi Tamper\!\!'
# TODO: might be this: "sudo wifi 'tamper!!'" # 2015-10-21 11:31:36.707837464 -0400
alias ping8='ping 8.8.8.8'

#alias fixnet='sudo service network-manager restart' # Ubuntu! 2015-08-20 12:56:06.864488390 -0400

setterm -blength 0 &> /dev/null
xset b off &> /dev/null

# http://unix.stackexchange.com/a/167911/121871
shopt -s checkwinsize

gitpast() {
  git add $1
  git commit -m "$2" --date="`stat -c %y $1`" $1
}

