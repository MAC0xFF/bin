#!/usr/bin/env bash
function Usage_Exit {
  echo "$0 [color|last|len|long]"; exit
}
function Ls-Length {
  ls -1 "$@" | while read fn; do
    printf '%3d %s\n' ${#fn} ${fn}; done | sort -n
}

(( $# < 1 )) && Usage_Exit 
sub=$1
shift
case $sub in
  color) ls -N --color=tty -T 0 "$@" ;;
  last) ls -lrt | tail "-n${1:-5}" ;;
  len*) Ls-Length "$@" ;;
  long) Ls-Length "$@" | tail -1 ;;
  *) echo "unknown command: $sub"; Usage_Exit ;;
esac
