
export GOPATH=~/go
alias xclipv='xclip -selection clipboard'
alias vi!='vi `!!`'
alias hodges='echo stupid zach, hodges are for kids'
alias tamper='sudo wifi Tamper\!\!'
setterm -blength 0 &> /dev/null
xset b off

# Moved to /usr/local/bin:
#alias wifi='sudo iwconfig wlp4s0 power off && sudo wifi-menu'
#alias eth0-start='sudo /home/karl/bin/eth0-start'

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

find() {
  path=$1
  shift
  #echo $@
  /usr/bin/find $path -regextype posix-egrep $@
}

# Ignore year, and add seconds when doing research / working on recent things:
alias ls2='/bin/ls --color=auto --time-style="+%b %d %H:%M:%S"'

# Last thing in list of output is most recently modified:
alias lst='ls2 -lahtr'

up() {
  n=$1
  if [ -z "$n" ]; then n=4; fi
  for i in `seq 1 $n`; do
    cd ../ 
  done
}

export PATH=$PATH:/home/karl/bin

#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias grepjava='grep --include=\*.java -rn . -e'
alias grephs='grep --include=\*.hs -rnw . -e'
alias grepjikes='grep -rn . -e'
alias ppl='cd /home/karl/w/ppl/git/deckbuild/hakaru'

alias gdm='systemctl start gdm'

export HISTSIZE=
export HISTFILESIZE=
export HISTTIMEFORMAT="[%F %T] "
export HISTFILE=~/.bash_eternal_history
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
alias gdb='HISTSIZE=70000000; /usr/bin/gdb "$@"'

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

export PADS_HASKELL=/home/karl/r/pads/git
export PADS_HOME=/home/karl/r/pads/pads
p() {
  cd ~/r/pads/pads
  export PADS_HOME=/home/karl/r/pads/pads
  export OCAML_LIB_DIR=/usr/lib/ocaml
  . $PADS_HOME/scripts/Q_DO_SETENV.sh

  # PADS / ML:
  #export PADS_HOME=/home/karl/r/pads/padsc/padsc_runtime
  #export PML_HOME=/home/karl/r/pads/padsc
  #export OCAML_BIN_DIR=/usr/bin/
  #export OCAML_LIB_DIR=/usr/lib/ocaml/
  #export CAMLIDL_LIB_DIR=$OCAML_LIB_DIR
  #. $PADS_HOME/scripts/Q_DO_SETENV.sh
}

j() {
  cd ~/r/permc/
  JDK=/home/karl/bin/jdk1.6.0_45
  export JAVA_HOME=$JDK
  pathadd_unsafe $JDK/bin
  alias ls=ls2
}
alias jj='j; cd pin/source/tools/Jikes'

export PYTHONSTARTUP=/home/karl/.pythonrc.py
alias acc='(cd ~/Dropbox/accounting; soffice accounting.ods) &'
alias eat='(cd ~/Dropbox/EatSmart; soffice EatSmart_log.ods) &'

mesg n

alias handbrake='ghb'

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
alias natty='nautilus ./ &'
alias python3.1='/usr/local/bin/python3.1'

alias printers='/usr/bin/system-config-printer &'
alias fonts='sudo font-manager &'
alias httpd.conf='cd /etc/apache2/'
alias apacheconfig='cd /etc/apache2/'

alias du="du --human-readable --max-depth=1"

alias python3="/usr/bin/python3.1"
alias mkv2avi="/usr/local/bin/mkv2avi.sh"
alias soffice=libreoffice

#export ANDROID_SDK=/home/karl/bin/android-sdk-linux
export ANDROID_SDK=/opt/android-sdk
pathadd $ANDROID_SDK/platform-tools
pathadd /home/karl/bin/gradle-2.6/bin

pathadd /home/karl/bin
pathadd /home/karl/bin/btsync
[ -d /home/karl/bin.local ] && pathadd /home/karl/bin.local
[ -d /home/karl/Private/bin ] && pathadd /home/karl/Private/bin

# Go:
pathadd /home/karl/go/bin

# Viz class:
pathadd /home/karl/bin/processing-3.0b4

# Haskell:
#export GHC_HOME=$HOME/bin/ghc-dev
export GHC_HOME=$HOME/bin/ghc-7.10.2/inst

#pathadd_unsafe $GHC_HOME/bin

# TODO: re-add?
#pathadd_unsafe $HOME/.cabal/bin

export GHC_HOME_IA32=$HOME/bin/ghc-7.10.2-i386/inst

alias chrome="/usr/bin/google-chrome-stable --incognito"
alias google-chrome="chrome"
alias google-chrome-stable="chrome"

xset b off &> /dev/null

