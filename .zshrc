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

#if [[ "$TERM" == "screen" || "$TERM" == "screen-bce" ]] then
##  tset -s xterm-256color
#  keychain --quiet ~/.ssh/keys/*~*.pub
#  . ~/.keychain/${HOST}-sh
#fi

# preexec

#if [[ "$TERM" == "screen" || "$TERM" == "screen-bce" ]]; then
##    chpwd () { echo -n "_`dirs`\\" }
#   preexec() {
#        # see [zsh-workers:13180]
#        # http://www.zsh.org/mla/workers/2000/msg03993.html
#        emulate -L zsh
#        local -a cmd; cmd=(${(z)2})
#        case $cmd[1] in
#            fg)
#                if (( $#cmd == 1 )); then
#                    cmd=(builtin jobs -l %+)
#                else
#                    cmd=(builtin jobs -l $cmd[2])
#                fi
#                ;;
#            %*)
#                cmd=(builtin jobs -l $cmd[1])
#                ;;
#            emacsclient)
#                screen -X eval "select 1"
#                return
#                ;;
#            cd|ssh|rlwrap)
#                if (( $#cmd >= 2)); then
#                    cmd[1]=$cmd[2]
#                fi
#                ;&
#            *)
#                echo -n "k$cmd[1]:t\\"
#                return
#                ;;
#        esac
#       
#        local -A jt; jt=(${(kv)jobtexts})
#       
#        $cmd >>(read num rest
#            cmd=(${(z)${(e):-\$jt$num}})
#        echo -n "k$cmd[1]:t\\") 2>/dev/null
#    }
#
#    chpwd () {
#       
#    }
#
#chpwd
#fi

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

alias emacs='open -a /Applications/Emacs.app'
alias e=emacs
alias qr="php -r 'echo \"http://chart.apis.google.com/chart?chs=150x150&cht=qr&chl=\".urlencode($argv[1]);' '$@' | xargs wget"

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
export JAVA_HOME
PATH=${JAVA_HOME}/bin:$PATH
export EC2_CERT=/Users/sei/bin/ec2/key/cert-DRMW22QEKV3K4T3D6VVTEEBJVUHIKGV6.pem
export EC2_PRIVATE_KEY=/Users/sei/bin/ec2/key/pk-DRMW22QEKV3K4T3D6VVTEEBJVUHIKGV6.pem

# Android Setting
PATH=$HOME/android-sdk/tools:$PATH

#
# cdd
#
source ~/.zsh/cdd

#
# perlbrew
#
#source ~/perl5/perlbrew/etc/bashrc

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

plenv_perl_version() {
    local dir=$PWD

    [[ -n $PLENV_VERSION ]] && { echo $PLENV_VERSION; return }

    while [[ -n $dir && $dir != "/" && $dir != "." ]]; do
        if [[ -f "$dir/.perl-version" ]]; then
            head -n 1 "$dir/.perl-version"
            return
        fi
        dir=$dir:h
    done

    local plenv_home=$PLENV_HOME
    [[ -z $PLENV_HOME && -n $HOME ]] && plenv_home="$HOME/.plenv"

    if [[ -f "$plenv_home/version" ]]; then
        head -n 1 "$plenv_home/version"
    fi
}

precmd() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    psvar[1]=$vcs_info_msg_0_
}


PROMPT=$'%2F%n@%m%f %3F%~%5F%1v%f%2F [plenv:$(plenv_perl_version)]%f\n%# '

#if [ $SHLVL = 1 ];then
#    screen -xR
#fi

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
# zsh-completion
#

REPORTTIME=3
if which plenv > /dev/null; then eval "$(plenv init -)"; fi

#
# hub
#
function git(){hub "$@"} # zsh

#
# gh
#
eval "$(gh alias -s)"

#
# go
#
# for go lang
if [ -x "`which go`" ]; then
  export GOROOT=`go env GOROOT`
  export GOPATH=$HOME/.go
  export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi
