#!/bin/bash
# longest-word2 : поиск самой длинной строки в файле
for i; do
  if [[ -r "$i" ]]; then
    max_word=
    max_len=0
    for j in $(strings "$i"); do
      #len="$(echo "$j" | wc -c)"
      len="${#j}"
      if (( len > max_len )); then
        max_len="$len"
        max_word="$j"
      fi
    done
    echo "$i: '$max_word' ($max_len characters)"
  fi
done

#time longest-word2 dirlist-usr-bin.txt
