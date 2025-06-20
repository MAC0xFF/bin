#!/bin/bash
# longest-word : поиск самой длинной строки в файле
while [[ -n "$1" ]]; do
  if [[ -r "$1" ]]; then
    max_word=
    max_len=0
    for i in $(strings "$1"); do
      len="$(echo "$i" | wc -c)"
        if (( len > max_len )); then
          max_len="$len"
          max_word="$i"
        fi
      done
      echo "$1: '$max_word' ($max_len characters)"
  fi
  shift
done
