HISTFILE="$HOME/.zhistory"
HISTSIZE=10000
SAVEHIST=10000
PATH="/usr/local/bin:$HOME/bin:$PATH"

_cache_hosts=(`perl -ne  'if (/^([a-zA-Z0-9.-]+)/) { print "$1\n";}' ~/.ssh/known_hosts`)
autoload -U compinit

fpath=(~/.zsh/zsh-completions/src $fpath)

compinit

setopt always_last_prompt
    
setopt append_history
setopt hist_ignore_space
setopt share_history

setopt auto_list
setopt auto_menu
setopt nobeep
setopt prompt_subst
#setopt extended_glob
setopt no_flow_control # disable C-s and C-q
setopt print_eight_bit

setopt auto_cd
setopt autopushd
setopt pushd_ignore_dups

alias gd='dirs -v; echo -n "select number: "; read newdir; cd -"$newdir"'

unsetopt promptcr

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

#stty -istrip
#bindkey -m
bindkey -e

bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

export LANG=ja_JP.UTF-8
export LC_MESSAGES=C
export PAGER='less -isr'
export EDITOR=vi
export SVN_EDITOR=vi
export LSCOLORS=gxfxcxdxbxegedabagacad

# Perl Library Path
#export PKG_DBDIR=$HOME/shared/cpan/db/pkg
#export PORT_DBDIR=$HOME/shared/cpan/db/pkg
#export INSTALL_AS_USER
#export LD_LIBRARY_PATH=$HOME/shared/cpan

#export PERL5_CPANPLUS_CONFIG=$HOME/.cpanplus/config
#export SVKMERGE=svk-merge-emacs

export MANPATH=/opt/local/man:$MANPATH
#export PERL5LIB=/opt/local/lib/perl5::/opt/local/lib/perl5/site_perl/5.8.9:/opt/local/lib/perl5/site_perl/5.8.9/darwin-2level:/opt/local/lib/perl5/vendor_perl/5.8.9/darwin-2level$PERL5LIB


function alc() {
  if [ $# != 0 ]; then
    w3m "http://eow.alc.co.jp/$*/UTF-8/?ref=sa" | less +37
  else
    w3m "http://www.alc.co.jp/"
  fi
}

case "${OSTYPE}" in
    freebsd*|darwin*)
        alias ls="ls -G -w"
        ;;
    linux*)
        alias ls="ls --color=auto -F"
        ;;
esac

if [ $TERM = 'screen-256color' ]; then
    function ssh_tmux() {
        eval server=\${$#}
        tmux new-window -n $@ "exec ssh $@"
    }
    alias ssh=ssh_tmux
fi

[[ $EMACS = t ]] && unsetopt zle

#
# Environment Variable
#

# Amazon EC2 Setting
export EC2_HOME=/usr/local/ec2
export PATH=$PATH:$ec2_HOME/bin
export EC2_PRIVATE_KEY=$EC2_HOME/key

# Amazon RDS Settings
export AWS_RDS_HOME=$HOME/bin/rds
export PATH=$PATH:$AWS_RDS_HOME/bin

export AWS_CREDENTIAL_FILE=$AWS_RDS_HOME/credential-file-path.txt
JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home
export EC2_CERT=/Users/sei/bin/ec2/key/cert-DRMW22QEKV3K4T3D6VVTEEBJVUHIKGV6.pem
export EC2_PRIVATE_KEY=/Users/sei/bin/ec2/key/pk-DRMW22QEKV3K4T3D6VVTEEBJVUHIKGV6.pem

# Android Setting
PATH=$HOME/android-sdk/tools:$PATH

#
# npm
#
export NODE_PATH="/usr/local/lib/node_modules":$NODE_PATH

#
# display vcs status
#

autoload -Uz add-zsh-hook
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats ' (%s)-[%b]'
zstyle ':vcs_info:*' actionformats ' (%s)-[%b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true

autoload -Uz is-at-least
if is-at-least 4.3.10; then
  # この check-for-changes が今回の設定するところ
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr "+"    # 適当な文字列に変更する
  zstyle ':vcs_info:git:*' unstagedstr "-"  # 適当の文字列に変更する
  zstyle ':vcs_info:git:*' formats '(%s)-[%c%u%b]'
  zstyle ':vcs_info:git:*' actionformats '(%s)-[%c%u%b|%a]'
fi

precmd() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    psvar[1]=$vcs_info_msg_0_
}


PROMPT=$'%2F%n@%m%f %3F%~%5F%1v%f%2F %f\n%# '

#
# rvm
#
if [[ -f ~/.rvm/scripts/rvm ]]; then
    source ~/.rvm/scripts/rvm;
    
    if which rvm > /dev/null 2>&1 ;then
        _rvm_use_version="ruby-1.9.3"
        if rvm ls | grep -F -e "${_rvm_use_version}" >/dev/null 2>&1 ;then
            rvm use "${_rvm_use_version}" >/dev/null
        fi
        unset _rvm_use_version
    fi
fi

#
# nvm
#
if [[ -f ~/.nvm/nvm.sh ]]; then
    source ~/.nvm/nvm.sh
    nvm use "v0.6.18"
    npm_dir=${NVM_PATH}_modules
    export NODE_PATH=$NODE_PATH:$npm_dir
fi

#
# plenv
#
if [ -d ${HOME}/.plenv  ] ; then
  PATH=${HOME}/.plenv/bin/:${HOME}/.plenv/shims:${PATH}
  export PATH
  eval "$(plenv init -)"
fi

#
# rbenv
#
if [ -d ${HOME}/.rbenv ] ; then
  eval "$(rbenv init -)"
fi

#
# zsh-completion
#

REPORTTIME=3
if which plenv > /dev/null; then eval "$(plenv init -)"; fi

#
# go
#
# for go lang
if [ -x "`which go`" ]; then
  export GOROOT=`go env GOROOT`
  export GOPATH=$HOME/.go
  export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi

#
# peco
#
# peco settings
# 過去に実行したコマンドを選択。ctrl-rにバインド
function peco-select-history() {
  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# search a destination from cdr list
function peco-get-destination-from-cdr() {
  cdr -l | \
  sed -e 's/^[[:digit:]]*[[:blank:]]*//' | \
  peco --query "$LBUFFER"
}


### 過去に移動したことのあるディレクトリを選択。ctrl-iにバインド
function peco-cdr() {
  local destination="$(peco-get-destination-from-cdr)"
  if [ -n "$destination" ]; then
    BUFFER="cd $destination"
    zle accept-line
  else
    zle reset-prompt
  fi
}
zle -N peco-cdr
#bindkey '^E' peco-cdr

# ブランチを簡単切り替え。git checkout lbで実行できる
alias -g lb='`git branch | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'


# dockerコンテナに入る。deで実行できる
alias de='docker exec -it $(docker ps | peco | cut -d " " -f 1) /bin/bash'

function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

#
# flutter
#
export PATH="$PATH:$HOME/dev/flutter/bin"

#
# JAVA_HOME
#
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export JAVA_HOME=`/usr/libexec/java_home -v 11.0.8`

#
# nodenv
#
eval "$(nodenv init -)"

#
# bash_completion
#
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  source $(brew --prefix)/etc/bash_completion
fi

source /usr/local/etc/bash_completion.d/tig-completion.bash

