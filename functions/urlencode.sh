#!/usr/bin/env bash
#
urlencode() {
    local LC_ALL=C # support unicode: loop bytes, not characters
    local c i n=${#1}
    for (( i=0; i<n; i++ )); do
        c="${1:i:1}"
        case "$c" in
            ' ') printf '+' ;; # HTML5 variant
            [[:alnum:]=?.~_\/-:]) printf '%s' "$c" ;; # We needed ?/:
            *) printf '%%%02x' "'$c" ;;
        esac
    done
}

# urlencode "http://foo bar/~smartin"
# echo
# urlencode "https://google.com/search?q=Linux testing"
