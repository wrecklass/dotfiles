#!/bin/bash
# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide. This software is distributed without any warranty.
# You should have received a copy of the CC0 Public Domain Dedication along
# with this software.
# If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

# base-files version 4.0-9

# ~/.bash_profile: executed by bash(1) for login shells.

# The latest version as installed by the Cygwin Setup program can
# always be found at /etc/defaults/etc/skel/.bash_profile

# Modifying /etc/skel/.bash_profile directly will prevent
# setup from updating it.

# The copy in your home directory (~/.bash_profile) is yours, please
# feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benifitial to all, please feel free to send
# a patch to the cygwin mailing list.

# User dependent .bash_profile file

# Set user-defined locale
# export LANG=$(locale -uU)

# Set this and only source file once
[[ -z "${BASH_PROFILE}" ]] && readonly BASH_PROFILE=true || return 0
# {{{ Logging
declare -x -i VERBOSE=0

_log() {
    if [ "$VERBOSE" -eq 1 ];then
      dt="$(date)"
      printf "%s-%s: %s\n" "${dt}" "BASH_PROFILE[$$]" "$*"
    fi
}

_log "bash_profile"
# }}}
# {{{ Includes

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
  shopt -s "$option" 2> /dev/null
done

# shellcheck source=/dev/null
[ -f /etc/profile ] && source /etc/profile

# shellcheck source=/dev/null
[ -f /usr/local/etc/profile.d/autojump.sh ] && source /usr/local/etc/profile.d/autojump.sh

# Override /etc/profile
# shellcheck source=/dev/null
[[ "$-" == *i* ]] && [[ -f "$HOME/.bashrc" ]] && source "$HOME/.bashrc"

export BASH_PROFILE

# Handled Elsewhere:
# Set PATH so it includes user's private bin if it exists
# if [ -d "${HOME}/bin" ] ; then
 # PATH="${HOME}/bin:${PATH}"
# fi

# Set MANPATH so it includes users' private man if it exists
# if [ -d "${HOME}/man" ]; then
#   MANPATH="${HOME}/man:${MANPATH}"
# fi

# Set INFOPATH so it includes users' private info if it exists
# if [ -d "${HOME}/info" ]; then
#   INFOPATH="${HOME}/info:${INFOPATH}"
# fi
# }}}
