# git-completion and git-prompt
source $HOME/dotfiles/.git-completion.bash
source $HOME/dotfiles/.git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWSTASHSTATE=1

############### ターミナルのコマンド受付状態の表示変更
# \u ユーザ名
# \h ホスト名
# \W カレントディレクトリ
# \w カレントディレクトリのパス
# \n 改行
# \d 日付
# \[ 表示させない文字列の開始
# \] 表示させない文字列の終了
# \$ $
export PS1='\[\033[1;32m\]\u\[\033[00m\]:\[\033[1;34m\]\w\[\033[1;31m\]$(__git_ps1)\[\033[00m\] \$ '
##############

#export EDITOR="/usr/local/bin/vim"

alias ll="ls -la"

export PATH=$PATH:~/google-cloud-sdk/bin

shopt -s dotglob

export PATH=$HOME/.nodebrew/current/bin:$PATH

## go
#eval "$(goenv init -)"
#export PATH=$PATH:$(go env GOPATH)/bin
#export GOPATH=$(go env GOPATH)

## Java
#export JAVA_HOME=$(/System/Library/Frameworks/JavaVM.framework/Versions/A/Commands/java_home -v "11")
#PATH=${JAVA_HOME}/bin:${PATH}
