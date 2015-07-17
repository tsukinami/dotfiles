# for regex
shopt -s extglob

# umask
umask 022

# disable stty stop for i-search
[ -t 0 ] && stty stop undef

# lang
export LANG=ja_JP.UTF-8

# editor
export EDITOR=vim

# for vipw, vigr, visudo
export VISUAL=vim

# homebrew coreutils
if [ -e /usr/local/opt/coreutils/libexec ]; then
    export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
    export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
fi

if [ -e $HOME/local/share/man ]; then
    export MANPATH=$HOME/local/share/man:$MANPATH
fi
if [ -e $HOME/local/man ]; then
    export MANPATH=$HOME/local/man:$MANPATH
fi

# path
export PATH=$HOME/local/bin:$PATH
export LD_LIBRARY_PATH=$HOME/local/lib:$LD_LIBRARY_PATH

# bash completion
MY_BASH_COMPLETION_DIR=(/usr/local/etc/bash_completion.d $HOME/local/etc/bash_completion.d)
for dir in ${MY_BASH_COMPLETION_DIR[@]}; do
    [ -e $dir ] && for f in $(find $dir -type f -or -type l -follow); do
        [ -f $f ] && . $f
    done
done
if ! $(type __git_ps1 &> /dev/null); then
    __git_ps1() { git branch 2> /dev/null | grep '*' | sed 's/* \(.*\)/ (\1)/'; }
fi

# prompt
export PS1='[\[\033[32m\]\u@\H\[\033[00m\] \[\033[34m\]\W\[\033[31m\]$(__git_ps1)\[\033[00m\]]\$ '

# alias
case "${OSTYPE}" in
    darwin*|freebsd*)
        if type gnuls &> /dev/null; then
            alias ls="gnuls --color"
            alias ll="gnuls -alF --color"
        elif type gls &> /dev/null; then
            alias ls="gls --color"
            alias ll="gls -alF --color"
        elif [ -e $HOME/local/bin/ls ]; then # coreutils
            alias ls="ls --color"
            alias ll="ls -alF --color"
        else
            alias ls="ls -G"
            alias ll="ls -alFG"
        fi
        ;;
    linux*)
        alias ls="ls --color"
        alias ll="ls -alF --color"
        ;;
esac

# import .my.bashrc
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi

# vim: set tabstop=4 shiftwidth=4 expandtab fenc=utf-8 ff=unix :
