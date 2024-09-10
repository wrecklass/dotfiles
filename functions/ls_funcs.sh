#!/bin/bash

# shellcheck disable=2012
alias lso="_lso"
alias llo="_lso"
alias lsg="_lsg"
alias llsg="_lsg"

_lsg() {
    if [ $# -gt 0 ]; then
        /bin/ls -lF $DF $colorflag "$@" | sed -e 's/--x/1/g' -e 's/-w-/2/g' -e 's/-wx/3/g' -e 's/r--/4/g'  -e 's/r-x/5/g' -e 's/rw-/6/g' -e 's/rwx/7/g' -e 's/---/0/g' -e 's/rwt/7t/g' -e 's/r-t/5t/' -e 's/-wt/3t/g' -e 's/--t/1t/g' -e 's/rws/47/g' -e 's/--s/41/g' -e 's/-ws/43/g'
    else
        /bin/ls -lF $DF $colorflag | sed -e 's/--x/1/g' -e 's/-w-/2/g' -e 's/-wx/3/g' -e 's/r--/4/g'  -e 's/r-x/5/g' -e 's/rw-/6/g' -e 's/rwx/7/g' -e 's/---/0/g' -e 's/rwt/7t/g' -e 's/r-t/5t/' -e 's/-wt/3t/g' -e 's/--t/1t/g' -e 's/rws/47/g' -e 's/--s/41/g' -e 's/-ws/43/g'
    fi
}

_lso() {
    if [ $# -gt 0 ]; then
        /bin/ls -lFG $DF $colorflag "$@" | sed -e 's/--x/1/g' -e 's/-w-/2/g' -e 's/-wx/3/g' -e 's/r--/4/g'  -e 's/r-x/5/g' -e 's/rw-/6/g' -e 's/rwx/7/g' -e 's/---/0/g' -e 's/rwt/7t/g' -e 's/r-t/5t/' -e 's/-wt/3t/g' -e 's/--t/1t/g' -e 's/rws/47/g' -e 's/--s/41/g' -e 's/-ws/43/g'
    else
        /bin/ls -lFG $DF $colorflag | sed -e 's/--x/1/g' -e 's/-w-/2/g' -e 's/-wx/3/g' -e 's/r--/4/g'  -e 's/r-x/5/g' -e 's/rw-/6/g' -e 's/rwx/7/g' -e 's/---/0/g' -e 's/rwt/7t/g' -e 's/r-t/5t/' -e 's/-wt/3t/g' -e 's/--t/1t/g' -e 's/rws/47/g' -e 's/--s/41/g' -e 's/-ws/43/g'
    fi
}

la() {
  # shellcheck disable=SC2012
  /bin/ls -lF $DF $colorflag "$@" | awk '
    {
      k=0;
      for (i=0;i<=8;i++)
        k+=((substr($1,i+2,1)~/[rwx]/) *2^(8-i));
      if (k)
        printf("%0o ",k);
      printf(" %9s  %3s %2s %5s  %6s  %s %s %s\n", $3, $6, $7, $8, $5, $9,$10, $11);
    }'
}


