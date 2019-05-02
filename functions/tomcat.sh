#!/bin/bash

alias tomcat=_tomcat

_tomcat() {
  local clna=$(command -v catalina)
  if [[ -x "${clna}" ]];then
    if [[ "$1" = "status" ]];then
      if psg "catalina.startup" > /dev/null 2>&1 ; then
        echo "catalina is running"
      fi
    else
      catalina "$@"
    fi
  fi
}


