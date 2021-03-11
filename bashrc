
if [ -e /usr/share/vulkan/icd.d/intel_icd.x86_64.json ]; then
  export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/intel_icd.x86_64.json
fi

alias signal="signal-desktop-beta"
alias trizen="MAKEFLAGS=-j8 trizen"

# Write down a note. Arguments are the title of the note, for markdown.
note() {
  dir="$HOME/log/notes"
  cd $dir
  fn="$dir/$(date +%b-%d-%Y_%H:%M:%S).md"
  if [ -e $fn ]; then
    echo "FATAL ERROR: '$fn' already exists. Try again."
    return
  fi
  echo -e "# $@\n\n" > "$fn"
  vim "$fn" +3
}

tt() { export PROMPT_COMMAND="echo -ne \"\033]0;$*\007\""; }

fixwifi() {
  if [ "$1x" = "x" ]; then
    echo "Usage: fixwifi [network]"
    return
  fi
  netctl stop-all && \
    rfkill unblock all && \
    sleep 1 && \
    netctl start $_WIFI_DEV-$1 && \
    sleep 2 && \
    ping 8.8.8.8
}

HISTCONTROL=ignorespace

fixmouse() {
  # TrackPoint
  #  ⎜   ↳ TPPS/2 IBM TrackPoint id=12  [slave  pointer  (2)]
  xinput set-int-prop 12 "Device Enabled" 8 0
}

print() {
  ! [ -z "$1" ] && cat "$1" | ssh linux exec lpr -P $_LAB_PRINTER
}

alias sudo='sudo -S'
alias quit=exit

# Convert github link into raw link:
wgetgit() {
  wget `echo "$1" | sed 's/github.com/raw.githubusercontent.com/g'` "${@:1}"
}

[ -e /etc/bash_completion.d/git     ] && . /etc/bash_completion.d/git
[ -e /etc/profile.d/pbench-agent.sh ] && . /etc/profile.d/pbench-agent.sh

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

#find() {
#  path=$1
#  shift
#  /usr/bin/find $path -regextype posix-egrep $@
#}

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
_TIME='\[\033[38;5;238m\]\t\[$(tput sgr0)\]'
PS1=$_TIME' \[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
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

shopt -s histappend

PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
export GDBHISTFILE=~/.gdb_eternal_history
export GDBHISTSIZE=unlimited
alias gdb='/usr/bin/gdb -q"$@"'

#export LESS="-R"
#export LESSOPEN='|~/.lessfilter %s'
export LESS='-RQ -z-2 -j2'
alias dmesg='dmesg --human --color=always'

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
export RESEARCH=$HOME/w
p() {
  cd $PADS_HASKELL
  #pathadd_unsafe $HOME/.cabal/bin
  # PADS / ML:
  #export PADS_HOME=$HOME/r/pads/padsc/padsc_runtime
  #export PML_HOME=$HOME/r/pads/padsc
  #export OCAML_BIN_DIR=/usr/bin/
  #export OCAML_LIB_DIR=/usr/lib/ocaml/
  #export CAMLIDL_LIB_DIR=$OCAML_LIB_DIR
  #. $PADS_HOME/scripts/Q_DO_SETENV.sh
}

# For building Hotspot:
#JDK=$HOME/bin/jdk-13.0.1
#export JAVA_HOME=$JDK
#pathadd_unsafe $JDK/bin

#j() {
#  cd $RESEARCH/pc
#  JDK=$HOME/bin/jdk1.6.0_45
#  export JAVA_HOME=$JDK
#  pathadd_unsafe $JDK/bin
#  alias ls=ls2
#}
#alias jj='j; cd pin/source/tools/Jikes'

#antlr() {
#  ANTLR=$HOME/w/siriusly/antlr
#  ANTLR_LIB=$ANTLR/lib/antlr-4.0-complete.jar
#  cd $ANTLR
#  export CLASSPATH=".:$ANTLR_LIB:$CLASSPATH"
#  alias antlr4="java -jar $ANTLR_LIB"
#  alias grun="java org.antlr.v4.runtime.misc.TestRig"
#}

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
export PYTHONPATH="$PATHPATH:/usr/local/lib/python3.5"
#alias python='python3.5'

alias t='gnome-terminal&'
alias term='gnome-terminal&'

alias clare='clear'
alias clar='clear'
alias claer='clear'
alias lear='clear'

alias pdf='evince'
alias natty='nautilus `pwd` &'

alias printers='/usr/bin/system-config-printer &'
alias fonts='sudo font-manager &'
alias httpd.conf='cd /etc/apache2/'
alias apacheconfig='cd /etc/apache2/'

alias du="du --human-readable --max-depth=1"

alias mkv2avi="/usr/local/bin/mkv2avi.sh"
alias soffice=libreoffice

#export ANDROID_SDK=$HOME/bin/android-sdk-linux
[ -e /opt/android-sdk ] && export ANDROID_SDK=/opt/android-sdk

pathadd $HOME/bin

# ----------------------------------------------------------------------------
p=pathadd_ignore
$p $ANDROID_SDK/platform-tools    # android platform tools
$p $HOME/bin/gradle-2.6/bin       # gradle
$p $HOME/bin/btsync               # btsync
$p $HOME/bin.local                # Local bin?
$p $HOME/Private/bin              # Encrypted bin
$p $HOME/go/bin                   # Go
$p $HOME/bin/processing-3.1.1     # Processing
$p $HOME/.gem/ruby/2.3.0/bin      # Ruby gem things (e.g. travis)
$p $HOME/w/bridge/dist/build/hakaru
$p $HOME/.cargo/bin

p=pathadd_unsafe_ignore
$p $HOME/.local/bin               # e.g. ghc-mod, ghc-modi, hlint
#$p $HOME/.cabal/bin               # cabal executables
unset p
# ----------------------------------------------------------------------------

# Haskell:
#export GHC_HOME=$HOME/bin/ghc-dev
export GHC_HOME=$HOME/bin/ghc-7.10.3-x86_64/inst

#pathadd_unsafe $GHC_HOME/bin

export GHC_HOME_IA32=$HOME/bin/ghc-7.10.2-i386/inst
export GOPATH=~/.go

alias getIP='dig +short myip.opendns.com @resolver1.opendns.com'
alias lsblk='lsblk -o NAME,SIZE,FSTYPE,TYPE,RO,LABEL,UUID,MOUNTPOINT'
alias dt='date +%Y-%b-%d'
alias dircmp='diff <(cd $1 && find | sort) <(cd $2 && find | sort)' # 2015-08-20 13:11:34.196481549 -0400 
alias chrome="/usr/bin/google-chrome-beta" # --incognito"
alias google-chrome="/usr/bin/google-chrome-beta"
alias google-chrome-stable="/usr/bin/google-chrome-stable"
alias xclipv='xclip -selection clipboard'
alias vi!='vi `!!`'
# TODO: might be this: "sudo wifi 'tamper!!'" # 2015-10-21 11:31:36.707837464 -0400
alias ping8='bash -c "trap \"exit\" INT; while [ 1 ]; do ping -i 5 8.8.8.8; sleep 1; done"'

setterm -blength 0 &> /dev/null
xset b off &> /dev/null

# http://unix.stackexchange.com/a/167911/121871
shopt -s checkwinsize

gitpast() {
  if [[ -z "$1" || -z "$2" ]]; then
    echo "Usage: gitpast \"[commit message]\" [filenames]"
    return
  fi
  msg="$1"; shift
  for f in "$@"; do
    git add $f
    git commit -m "$msg" --date="`stat -c %y $f`" $f
  done
}

eval "$(stack --bash-completion-script stack)"

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

# OPAM (Ocaml)
. $HOME/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

#source $HOME/.ghcup/env

#eval "$(thefuck --alias)"

# Install Ruby Gems to ~/gems
#export GEM_HOME="$HOME/gems"
#export PATH="$HOME/gems/bin:$PATH"
#pathadd_unsafe $HOME/.gem/ruby/2.7.0/bin/

