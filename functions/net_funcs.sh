#!/bin/bash

export NETREGX="[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"
GREP="/bin/grep"
alias grepip="_grepip"
alias filegrepip="_filegrepip"
alias ripip="_filegrepip"
alias ripips="_filegrepip"

_grepip() {
  echo "$*" | ${GREP} -oE "$NETREGX"
}

_filegrepip() {
  <"$*" ${GREP} -oE "$NETREGX"
}

function localip() {
  if command -v ifconfig > /dev/null; then # Not Windows
    sudo ifconfig | ${GREP} -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | ${GREP} -Eo '([0-9]*\.){3}[0-9]*' | ${GREP} -v '127.0.0.1'
  else # Windows ipconfig
    ipconfig | ${GREP} IPv4 | awk -F':' '{print $2}'
  fi
}

if command -v ifconfig > /dev/null; then # Not on Windows
function ips() {
  sudo ifconfig -a | ${GREP} -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'
}
fi

# Show all the names (CNs and SANs) listed in the SSL certificate
# for a given domain
function getcertnames() {
  if [ -z "${1}" ]; then
    printf "ERROR: No domain specified.\n"
    return 1
  fi

  local domain="${1}"
  printf "Testing %s…\n" "${domain}"

  local tmp
  tmp=$(printf "GET / HTTP/1.0\nEOT" \
    | openssl s_client -connect "${domain}:443" -servername "${domain}" 2>&1)

  if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
    local certText
    certText=$(echo "${tmp}" \
      | openssl x509 -text -certopt "no_aux, no_header, no_issuer, no_pubkey, \
      no_serial, no_sigdump, no_signame, no_validity, no_version")
    printf "Common Name:\n\n"
    echo "${certText}" | ${GREP} "Subject:" | sed -e "s/^.*CN=//" | sed -e "s/\/emailAddress=.*//"
    printf "\n"
    printf "Subject Alternative Name(s):\n\n"
    echo "${certText}" | ${GREP} -A 1 "Subject Alternative Name:" \
      | sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2
    return 0
  else
    printf "ERROR: Certificate not found.\n"
    return 1
  fi
}

