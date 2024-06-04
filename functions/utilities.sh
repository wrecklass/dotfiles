#!/bin/bash
# Misc. Utilities

alias err='_err'
alias dush='_dush'

function _err {
  if [ "$#" -ne 1 ];then
    printf "usage: %s\n" "${FUNCNAME[@]}"
    printf "where N is an Integer\n"
    return 2
  fi

  # The numeric error codes are 'SpaceNUMTab'
  if ! grep -P " ${*}\t" /usr/include/sys/errno.h 2> /dev/null ; then
    echo "Not found."
  fi
}

if command -v batcat &> /dev/null ;then
  function bat() {
    batcat "$@"
  }
fi

# Open that works on either cygwin or linux
function open() {
  if command -v cygstart > /dev/null; then
    if [ $# -eq 0 ]; then
      cygstart .
    else
      cygstart "$@"
    fi
  elif command -v xdg-open > /dev/null; then
    if [ $# -eq 0 ]; then
      xdg-open . &> /dev/null
    else
      xdg-open "$@" &> /dev/null
    fi
  fi
}

# SUDO=""
# if command -v sudo &> /dev/null ; then
#   SUDO=$(command -v sudo)
# else
#   SUDO=""
# fi
# echo "SUDO $SUDO"
_dush() {
  du -sk "$@" 2> /dev/null | sort -g | awk '{

    numBytes = $1 * 1024;
    numUnits = split("B K M G T P", unit);
    num = numBytes;
    iUnit = 0;

    while(num >= 1024 && iUnit + 1 < numUnits) {
      num = num / 1024;
      iUnit++;
    }

    $1 = sprintf( ((num == 0) ? "%6d%s " : "%6.1f%s "), num, unit[iUnit + 1]);
    print $0;

  }'
}

path() {

  local tmp
  tmp="${1%/}"
  if [[ -n "${tmp}" ]] && [[ -d "${tmp}" ]];then
    if ! /bin/grep -q "${tmp}" <<<"${PATH}" ; then
      PATH="${tmp}:$PATH"
    fi
  fi
  echo "$PATH" | tr ':' '\n'
}


# Determine size of a file or total size of a directory
fs() {
  local arg
  if du -b /dev/null &> /dev/null ; then
    arg="-sbh"
  else
    arg="-sh"
  fi
  if [[ -n "$*" ]]; then
    du $arg -- "$@"
  else
    du $arg -- .[^.]* *
  fi
}

# Create a data URL from a file
dataurl() {
  local mimeType
  mimeType=$(file -b --mime-type "$1")
  if [[ $mimeType == text/* ]]; then
    mimeType="${mimeType};charset=utf-8"
  fi
  echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

# Start an HTTP server from a directory, optionally specifying the port
server() {
  local port="${1:-8000}"
  # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
  # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
  python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
  sleep 1 && open "http://localhost:${port}/"
}

# Compare original and gzipped file size
gz() {
  local origsize
  local gzipsize
  local ratio
  origsize=$(wc -c < "$1")
  gzipsize=$(gzip -c "$1" | wc -c)
  ratio=$(echo "$gzipsize * 100 / $origsize" | bc -l)
  printf "orig: %d bytes\n" "$origsize"
  printf "gzip: %d bytes (%2.2f%%)\n" "$gzipsize" "$ratio"
}

# Run `dig` and display the most useful info
digga() {
  dig +nocmd "$1" any +multiline +noall +answer
}

# Reverse lookup
digr() {
  dig +short -x "$1"
}

# Query Wikipedia via console over DNS
mwiki() {
  dig +short txt "$*".wp.dg.cx
}

# UTF-8-encode a string of Unicode symbols
escape() {
  printf "\\\x%s" "$(printf "%s" "$@" | xxd -p -c1 -u)"
  # print a newline unless we’re piping the output to another program
  if [ -t 1 ]; then
    echo ""; # newline
  fi
}

# Decode \x{ABCD}-style Unicode escape sequences
unidecode() {
  perl -e "binmode(STDOUT, ':utf8'); print \"$*\""
  # print a newline unless we’re piping the output to another program
  if [ -t 1 ]; then
    echo ""; # newline
  fi
}

# Get a character’s Unicode code point
codepoint() {
  perl -e "use utf8; print sprintf('U+%04X', ord(\"$*\"))"
  # print a newline unless we’re piping the output to another program
  if [ -t 1 ]; then
    echo ""; # newline
  fi
}

# `v` with no arguments opens the current directory in Vim, otherwise opens the
# given location
v() {
  if [ $# -eq 0 ]; then
    vim .
  else
    vim "$@"
  fi
}

# Call from a local repo to open the repository on github/bitbucket in browser
repo() {
  local giturl

  giturl=$(git config --get remote.origin.url | sed 's/git@/\/\//g' | sed 's/.git$//' | sed 's/https://g' | sed 's/:/\//g')

  if [[ $giturl == "" ]]; then
    echo "Not a git repository or no remote.origin.url is set."
  else
    local gitbranch
    local giturl
    gitbranch=$(git rev-parse --abbrev-ref HEAD)
    giturl="http:${giturl}"

    if [[ $gitbranch != "master" ]]; then
      if echo "${giturl}" | grep -i "bitbucket" > /dev/null ; then
        local giturl="${giturl}/branch/${gitbranch}"
      else
        local giturl="${giturl}/tree/${gitbranch}"
      fi
    fi

    echo "$giturl"
    open "$giturl"
  fi
}

YUM=$(command -v yum)
if [[ -z "${YUM}" ]];then
  function yum() {
    echo "Must be a debian system, use apt."
  }
fi

# Get colors in manual pages
# _man is a keybinding function defined by man.
# So we must use __man here.
alias man="__man"
__man() {
  env \
    LESS_TERMCAP_mb="$(printf "\e[1;31m")" \
    LESS_TERMCAP_md="$(printf "\e[1;31m")" \
    LESS_TERMCAP_me="$(printf "\e[0m")" \
    LESS_TERMCAP_se="$(printf "\e[0m")" \
    LESS_TERMCAP_so="$(printf "\e[1;44;33m")" \
    LESS_TERMCAP_ue="$(printf "\e[0m")" \
    LESS_TERMCAP_us="$(printf "\e[1;32m")" \
    man "$@"
}

# `o` with no arguments opens the current directory, otherwise opens the given
# location
function o() {
  if [ $# -eq 0 ]; then
    open .
  else
    open "$@"
  fi
}

# `start` with no arguments opens the current directory, otherwise opens the given
# location
function start() {
  if [ $# -eq 0 ]; then
    open .
  else
    open "$@"
  fi
}

function mhz() {
  awk '/MHz/{ temp+=$4; n++} END {printf("%6.1f\n", temp/n) }' /proc/cpuinfo
}

function ver() {
  [[ -n "$1" ]] && "$1" --version
}
