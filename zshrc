#
# Setup Antigen
#
source ~/.antigen/antigen.zsh
antigen use oh-my-zsh

#
# Antigen Bundles
#
antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle rupa/z

antigen bundle virtualenvwrapper

antigen bundle cabal

antigen bundle web-search

#
# Antigen Theme
#
if [[ -n ${INSIDE_EMACS} ]]; then
    antigen theme blinks
else
    antigen theme kennethreitz
fi

#
# OS Specific things
#
if [[ `uname` == 'Darwin' ]]; then
    antigen bundle brew
    antigen bundle brew-cask
    antigen bundle osx
fi

# Start X if needed
if [[ -z $DISPLAY && $XDG_VTNG -eq 1 ]]; then
    startx
fi

#
# Commands
#
alias rma='rm *~'

function mkcd(){
    mkdir $1;
    cd $1;
}

# python
alias p="python"
alias p2="python2"
alias p3="python3"
alias bp="bpython"

# emacs
alias e="emacs"
alias ema="emacs"
alias enw="emacs -nw"

# navigation
alias j="z"
alias jb="cd -"
alias zb="cd -"

export LESSOPEN="| src-hilite-lesspipe.sh %s"
export LESS=' -R '

#
# Defaults
#
export EDITOR='ema'
export PATH=~/.cabal/bin:~/.bin:$PATH:/usr/local/sbin
export PATH=$PATH:/usr/local/bin:/usr/bin:/usr/bin/core_perl
export PATH=/home/izzy/Documents/workspace/ares/install/bin:$PATH
#
# Apply Antigen
#
antigen apply

# Go Lang config
export GOROOT=$HOME/workspace/go
export PATH=$PATH:$GOROOT/bin

# OPAM configuration
. /Users/tylercecil/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
