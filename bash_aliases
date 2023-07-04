#!/usr/bin/env bash

# If we've already read these, don't do it again
[[ -z "${SET_ALIASES}" ]] && readonly SET_ALIASES=true || return 0
_log ".bash_aliases"
_log "SHELL: $SHELL"
hub_path=$(command -v hub)
if [ -n "${hub_path}" ];then
  # alias git="${hub_path}"
  eval "$(hub alias -s "$SHELL")"
fi


# Kubectl/kubernetes/k8s aliases
# alias kc='kubectl'
# complete -o default -o nospace -F __start_kubectl kc
#alias nodes='kubectl get nodes'
#alias pods='kubectl get pods'
#alias kns='kubens'
#alias kctx='kubectx'

# Allow aliases to be sudoed
# alias sudo='sudo '

# Detect which `ls` flavor is in use
export colorflag="-G"
if ls --color &> /dev/null ; then # GNU `ls`
  colorflag="--color"
fi # OS X `ls`

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"
alias -- --="cd --"

alias sal='source ~/.bash_aliases'
#alias b64="build64"

# common typos
# Because I'm occasionally dislexic:
alias cate='cat'

alias clr=clear
alias cls=clear
alias clar=clear
alias claer=clear
alias cler=clear
alias ''=clear

# alias comcast='ftp upload.comcast.net'

if command -v colordiff &> /dev/null; then
  alias diff='colordiff'
  alias dif='colordiff'
else
  alias dif='diff'
fi

if [ "$UNAME" == "cygwin" ];then
  alias diff="diff --color"
  alias dif="diff --color"
fi

# alias dl="cd ~/Downloads"
alias dfh='df -h '
alias duh='du -sh'
alias dus='du -sh . | sort -h'
alias dust='du -sh * | sort -h'

alias d='dirs -v'

alias fild='file'
alias fiel='file'

alias bit="git"
alias g="git"
alias get='git'
alias gut='git'
alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'
alias gau='git add --update'

alias gcom='git switch master'
alias gcod='git switch dev'
alias gco='git checkout'
alias gcob='git checkout -b'

alias gc='git commit'
alias gcm='git commit'
alias gcmsg='git commit -m'
alias gcam='git commit -a -m'

alias gcf='git config --list'

alias gd='git diff'
alias gdw='git diff --word-diff'
alias giff='git diff'
alias gl='git log'
alias glp='git log -p'
alias gf='git fetch'
alias gfa='git fetch --all --prune'
alias gfo='git fetch origin'

alias gp='git push'
alias gpa='git remote | xargs -I X git push X --all'
alias grv='git remote -v'
alias gss='git status -s'
alias gs='git status'

alias gsu='git submodule update'

# So these two aliases do bash_completion from git
 # complete -o bashdefault -o default -o nospace -F __git_wrap__git_main g
 # complete -o bashdefault -o default -o nospace -F __git_wrap__git_main gl
 # complete -o bashdefault -o default -o nospace -F __git_wrap__git_main gd
 # complete -o bashdefault -o default -o nospace -F __git_wrap__git_main get
 __git_complete g git
 __git_complete get git
 __git_complete gut git
 __git_complete ga git_add
 __git_complete gaa git_add
 __git_complete gc  git_commit
 __git_complete gcm git_commit
 __git_complete gco git_checkout
 __git_complete gp git_push
 __git_complete gpa git_push
 __git_complete gl git_log
 __git_complete gd git_diff
 __git_complete gf git_fetch

alias grep='grep -a --color=always'
alias gpre='grep -a --color=always'
alias grpe='grep -a --color=always'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
# alias gvim='/c/WINDOWS/gvim.bat'

# vhosts
alias hosts='sudo vim /etc/hosts'

alias hp='hashapass.sh'

alias irb='irb --readline -r irb/completion'

alias ppath='echo -e ${PATH//:/\\n}'

# Use fzf with a preview window
if command -v bat &> /dev/null ; then
  alias pf='fzf --preview="bat --color=always --decorations=always {}" --bind shift-up:preview-page-up,shift-down:preview-page-down'
else
  alias pf='fzf --preview="less {}" --bind shift-up:preview-page-up,shift-down:preview-page-down'
fi

# IP addresses
alias pubip="dig +short myip.opendns.com @resolver1.opendns.com"

# alias ip="dig +short myip.opendns.com @resolver1.opendns.com"

alias j='jobs'

# File lists 'ls'
alias dot='ls -dAF ${colorflag} .[a-zA-Z0-9]*'
alias dolt='ls -dlAF ${colorflag} .[a-zA-Z0-9]*'
# alias exl='exa --long'
# alias exs='exa --sort size'
alias l.='ls -dAF ${colorflag} .*'
alias ll.='ls -ldF ${colorflag} .*'
alias l='ls -lF ${colorflag}'
alias lesb='$(history -p !!) | less'
alias ls='ls -F ${colorflag}'
alias lsa='ls -AF ${colorflag}'
alias lsp='\ls -F'
alias la='ls -AF ${colorflag}'
alias ll='ls -lF ${colorflag}'
alias lla='ls -AlF ${colorflag}'
alias lh='ls -lhF ${colorflag}'
alias llh='ls -lhF ${colorflag}'
alias lt='ls -lrtF ${colorflag}'
alias llt='ls -lrtF ${colorflag}'
alias lltg='ls -lGrtF ${colorflag}'
alias llgt='ls -lGrtF ${colorflag}'
alias lg='ls -lGF ${colorflag}'
alias llg='ls -lGF ${colorflag}'

alias md='mkdir'
alias mdp='mkdir -p'
# alias mypid='kindlepid.py B001BFB781653202'
# alias mplayer='mplayer'
# alias mysql='start mysql'

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

alias nslookupo=nslookup
alias now='date +"%T"'
alias nowtime='now'
alias nowdate='date +"%d-%m-%Y"'

alias pp='ping 8.8.8.8'
alias fastping='ping -c 10 -i .2'
alias r='fc -s'
alias ri='ri -f bs '
alias rit='ri -T -f bs '

alias res='printf "%s x %s\n" "$COLUMNS" "$LINES"'

alias trash="gio trash"
alias rm='rm -i'
alias mr='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias vm='mv -i'

# alias s7='secure7'
# alias sb='cd /usr/local/streambaby ; ./streambaby_high &> ~/.log/streambaby.log &'
alias scc='less $HOME/bin/screencheat'
if [ -x "$HOME/bin/vim" ];then
  alias sec='$HOME/bin/vim $HOME/bin/.secret'
else
  alias sec='/usr/bin/vim $HOME/bin/.secret'
fi
alias svi='sudo vim'
alias via='vi ~/.ssh/assh.yml'
alias sw='telnet  towel.blinkenlights.nl'
# alias sx='startxwin.sh &> .xwin_errors'

# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

alias untar='tar xvf'
alias xtar="tar xvf"
alias ctar="tar cvf"
alias ttar="tar tvf"
alias ttc='tty-clock -scxBC 6'

# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

if [ -z "$EDITOR" ];then
  export EDITOR="/bin/vim"
fi
alias vi="\$EDITOR"
alias vim="\$EDITOR"
alias vimrc="\$EDITOR \${HOME}/.vimrc"
alias vib="\$EDITOR ~/.bashrc"
alias iv="\$EDITOR"

alias week='date +%V'
alias wcl='wc -l'

alias httpd.py='python -m SimpleHTTPServer'
alias httpd.rb='ruby -run -e httpd . -p 8000'

# Because we do this so often
alias xit='exit'

# alias xh='xhost +'
alias x='chmod ug+x '

# EditPadPro
alias edit='cygstart "/c/users/smartin/appdata/local/just great software/editpad pro 8/editpadpro8.exe"'

alias muffins='cygstart '\''https://www.amazon.com/dp/B007YPOBLI?psc=1&ref=ppx_yo2ov_dt_b_product_details'\'''
alias orders='cygstart "https://www.amazon.com/gp/css/order-history"'

# Duck Duck Go Search, 8 per screen
alias ddgr='ddgr -n 8 --url-handler "c:/Program Files/BraveSoftware/Brave-Browser/Application/brave.exe"'
alias winip='ipconfig /all | grep "Wi-Fi 3" -A 18'
alias mywinip='ipconfig /all|  grep IPv4 | /bin/grep -Eo "$NETREGX"'
alias mkvim='./configure --enable-luainterp=dynamic --enable-perlinterp=yes -enable-pythoninterp=dynamic --enable-python3interp=dynamic --enable-rubyinterp=yes --with-python-command=python2.7 --with-python3-command=python3 && make && sleep 1 && ./src/vim'
