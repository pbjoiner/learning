#!/bin/bash
#
# define my aliases

alias dir='ls -Alh --color=always'
alias hm='cd /home/pjoiner;clear'
alias ssh='ssh -C'
alias rsync='rsync -vazcilt --exclude ''.svn'''
alias mv='mv -v'
alias cp='cp -vr'
alias mkdir='mkdir -pv'
alias df='df -h'

alias enca='enca -L none'
alias enconv='enconv -L none'
alias toascii='enconv -L none -x iso-8859-1'
alias sudoku='sudo -K'
alias fixname='rename ''s/[^a-zA-Z0-9-_\.]//g'''

alias tbz='tar -xjvf'
alias tgz='tar -xzvf'

alias ftp='ftp -iv'
alias grep='grep -ri --color=always --exclude=*.svn-base'
alias prep='perl -pi -w -e'

# set terminal tab title
alias settitle='echo -ne "\033]0;${USER}@${HOSTNAME}:${PWD/$HOME/~}\007"'
