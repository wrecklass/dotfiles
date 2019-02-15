# Detect which `ls` flavor is in use

# [[ -z "${CYG_HOME_ALIASES}" ]] && CYG_HOME_ALIASES="1" || return 0
# echo ".bash_aliases"

hub_path=$(command -v hub)
if [ -n "${hub_path}" ];then
  alias git="${hub_path}"
fi

# Lock the screen (when going AFK) MacOS Only
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# Kubectl/kubernetes/k8s aliases
alias nodes='kubectl get nodes'
alias pods='kubectl get pods'
alias kns='kubens'
alias kctx='kubectx'

# Allow aliases to be sudoed
alias sudo='sudo '

if ls --color > /dev/null 2>&1; then # GNU `ls`
	colorflag="--color"
else # OS X `ls`
	colorflag="-G"
fi

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

alias sal='source ~/.bash_aliases'
#alias b64="build64"

alias code='/Users/smartin/Applications/Visual Studio Code.app//Contents/Resources/app/bin/code'

# common typos
# Because I'm occasionally dislexic:
alias cate='cat'

alias cls=clear
alias comcast='ftp upload.comcast.net'

colordiff="$(command -v colordiff)"
if [ "$?" -eq 0 ];then
  alias diff='colordiff'
fi
if [ "$UNAME" == "cygwin" ];then
  alias diff="diff --color"
fi

# alias dl="cd ~/Downloads"
alias dfh='df -h '
alias duh='du -sh'
alias dus='du -sh . | sort -h'
alias dust='du -sh * | sort -h'

alias fild='file'
alias fiel='file'

alias g="git"
alias get='git'
complete -o default -o nospace -F _git g
complete -o default -o nospace -F _git get

alias gc=". $HOME/bin/gitdate && git commit -v "

alias grep='grep -a --color=always'
alias gpre='grep -a --color=always'
alias grpe='grep -a --color=always'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
# alias gvim='/c/WINDOWS/gvim.bat'

# vhosts
alias hosts='sudo vim /etc/hosts'

alias hp='hashapass.sh'
# alias h="history"

alias irb='irb --readline -r irb/completion'

alias kc='kubectl'
alias ppath='echo -e ${PATH//:/\\n}'

# IP addresses
alias pubip="dig +short myip.opendns.com @resolver1.opendns.com"

if ipconfig > /dev/null 2>&1; then # Windows ipconfig
  alias localip="ipconfig | grep IPv4 | awk -F':' '{print \$2}'"
else # *ix ifconfig
  alias localip="sudo ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
  alias ips="sudo ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"
fi

alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias j='jobs'
alias dot='ls -dAF ${colorflag} .*'
alias l.='ls -dAF ${colorflag} .*'
alias ll.='ls -ldF ${colorflag} .*'
alias l=less
alias lesb='$(history -p !!) | less'
alias ls='ls -F ${colorflag}'
alias lsp='\ls -F'
alias la='ls -AF ${colorflag}'
alias ll='ls -lF ${colorflag}'
alias lla='ls -alF ${colorflag}'
alias lh='ls -lhF ${colorflag}'
alias llh='ls -lhF ${colorflag}'
alias lt='ls -lrtF ${colorflag}'
alias llt='ls -lrtF ${colorflag}'
alias lltg='ls -lrtF ${colorflag}'
alias llgt='ls -lrtF ${colorflag}'
alias lg='ls -lF ${colorflag}'
alias llg='ls -lF ${colorflag}'

alias md='mkdir'
alias mdp='mkdir -p'
alias mypid='kindlepid.py B001BFB781653202'
alias mplayer='mplayer'
#alias mysql='start mysql'

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

alias nslookupo=nslookup
alias now='date +"%T"'
alias nowtime='now'
alias nowdate='date +"%d-%m-%Y"'

alias pp='ping google.com'
alias fastping='ping -c 10 -i .2'
alias r='fc -s'
alias ri='ri -f bs '
alias rit='ri -T -f bs '
alias rm='rm -i'
alias mr='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias vm='mv -i'

alias s7='secure7'
alias sb='cd /usr/local/streambaby ; ./streambaby_high &> ~/.log/streambaby.log &'
alias scc='less $HOME/bin/screencheat'
alias sec='/usr/bin/vim $HOME/bin/.secret'
alias sec2='ssh -i ~/.ssh/EngProdKey.pem -l ec2-user'
# alias sensu='ssh -i ~/.ssh/EngProdKey.pem -l ec2-user sensu'
alias svi='sudo vim'
alias sw='telnet  towel.blinkenlights.nl'
alias sx='startxwin.sh > .xwin_errors 2>&1'

# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

alias untar='tar xvf'
alias tp='terraform plan -out ./flagship.plan'
alias ta='terraform apply ./flagship.plan'
alias tg='tivoget.rb'
alias tivo='remote.pyw 192.168.1.20 &'
alias tivol='remote.pyw --landscape 192.168.1.20 &'
alias tivokeys="clear;cat $HOME/bin/keys"
alias tomcat='catalina'
# alias todo='~/bin/todo.sh'
# alias t='~/bin/todo.sh'
alias xtar="tar xvf"
alias ctar="tar cvf"
alias ttar="tar cvf"

# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

alias vi="$EDITOR"
alias vim="$EDITOR"
alias vib='$EDITOR ~/.bashrc'
alias iv="$EDITOR"

alias week='date +%V'

alias httpd.py='python -m SimpleHTTPServer'
alias httpd.rb='ruby -run -e httpd . -p 8000'

# alias xh='xhost +'
alias x='chmod +x '

# alias rout='route add 172.0.0.0 mask 255.0.0.0 '

