#!/bin/bash

alias tomcat=_tomcat

_tomcat() {
  local clna=$(command -v catalina)
  if [[ -x "${clna}" ]];then
    if [[ "$1" = "status" ]] || [[ -z "$1" ]];then
      if psg "catalina.startup" > /dev/null 2>&1 ; then
        printf "catalina is running.\n"
      else
        printf "catalina is not running.\n"
      fi
    elif [[ "$1" = "restart" ]];then
      # Shut down if it is running
      if psg "catalina.startup" > /dev/null 2>&1; then
        "${clna}" stop
      fi
      "${clna}" start
    else
      "${clna}" "$@"
    fi
  fi
}


