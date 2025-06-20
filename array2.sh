#!/bin/bash
# array-2: Используем массивы для подсчета файлов, принадлежащих
# разным владельцам
5 declare -A files file_group file_owner groups owners

if [[ ! -d "$1" ]]; then
  echo "Usage: array-2 dir" >&2
  exit 1
fi

for i in "$1"/*; do
  owner="$(stat -c %U "$i")"
  group="$(stat -c %G "$i")"
  files["$i"]="$i"
  file_owner["$i"]="$owner"
  file_group["$i"]="$group"
  ((++owners[$owner]))
  ((++groups[$group]))
done

# Вывод списка файлов
{ for i in "${files[@]}"; do
  printf "%-40s %-10s %-10s\n" \
  "$i" "${file_owner["$i"]}" "${file_group["$i"]}"
done } | sort
echo

# Вывод списка владельцев
echo "File owners:"
{ for i in "${!owners[@]}"; do
  printf "%-10s: %5d file(s)\n" "$i" "${owners["$i"]}"
done } | sort
echo

# Вывод списка групп
echo "File group owners:"
{ for i in "${!groups[@]}"; do
  printf "%-10s: %5d file(s)\n" "$i" "${groups["$i"]}"
done } | sort
