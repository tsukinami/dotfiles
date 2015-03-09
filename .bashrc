# .bashrc

# disable stty stop for i-search
[ -t 0 ] && stty stop undef

# editor
export EDITOR=vim

# for vipw, vigr, visudo
export VISUAL=vim

# homebrew coreutils
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH

# bash completion
for f in $(find /usr/local/etc/bash_completion.d -type f -or -type l -exec echo "{}" \;); do
    [ -f $f ] && . $f
done

# alias
alias ll="ls -laF --color"

# prompt
export PS1="[\u@\H \W\$(__git_ps1)]\\\$ "

# import .my.bashrc
if [ -f ~/.my.bashrc ]; then
    . ~/.my.bashrc
fi
