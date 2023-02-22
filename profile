#!/bin/bash
# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide. This software is distributed without any warranty.
# You should have received a copy of the CC0 Public Domain Dedication along
# with this software.
# If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

# base-files version 4.0-9

# ~/.profile: executed by the command interpreter for login shells.

# The latest version as installed by the Cygwin Setup program can
# always be found at /etc/defaults/etc/skel/.profile

# Modifying /etc/skel/.profile directly will prevent
# setup from updating it.

# The copy in your home directory (~/.profile) is yours, please
# feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benificial to all, please feel free to send
# a patch to the cygwin mailing list.

# User dependent .profile file

# Set user-defined locale
# export LANG=$(locale -uU)

# This file is not read by bash(1) if ~/.bash_profile or ~/.bash_login
# exists.
#
# Use shellcheck -x to allow the proper sourcing.

# if running bash
# {{{ Logging
declare -x -i VERBOSE=0

_log() {
    if [ "$VERBOSE" -eq 1 ];then
      dt="$(date)"
      printf "%s-%s: %s\n" "${dt}" "PROFILE[$$]" "$*"
    fi
}

_log ".profile"
# }}}
# {{{ Includes
if [ -n "${BASH_VERSION}" ]; then
  if [ -f "${HOME}/.bash_profile" ]; then
    # This will source .bashrc for us.
    # shellcheck source=./bash_profile
    source "${HOME}/.bash_profile"
  elif [ -f "${HOME}/.bashrc" ]; then
    # Ok, so we do it ourselves
    # shellcheck source=./bashrc
    source "${HOME}/.bashrc"
  fi
fi
_log ".profile done"

# Cargo env
if [ -f "$HOME/.cargo/env" ];then
  source "$HOME/.cargo/env"
fi
# }}}
