#!/usr/bin/env bash
[ -n "$BOOK_ASC" ] || {
  echo "FATAL: export \$BOOK_ASC to the location of the Asciidoc files!"; exit 1
}
\cd "$BOOK_ASC" || {
  echo "FATAL: can't cd to '$BOOK_ASC'!"; exit 2
}
SELF="$0" 
action="$1" 
shift 
[ -x /usr/bin/xsel -a $# -lt 1 ] && { 
  text=$(xsel -b)
  function Output { echo -en "$*" | xsel -bi }
} || {
  # Чтение/запись STDIN/STDOUT
  text=$*
  function Output { echo -en "$*" }
}
case "$action" in
  h1 ) Output "[[$($SELF id $text)]]\n=== $text" ;;
  h2 ) Output "[[$($SELF id $text)]]\n==== $text" ;;
  h3 ) Output "[[$($SELF id $text)]]\n===== $text" ;;
  bul|bullet ) Output "* $text" ;;
  nul|number|order* ) Output ". $text" ;;
  term ) Output "term_here::\n $text" ;;
  bold ) Output "*$text*" ;;
  i|italic*|itl ) Output "_${text}_" ;;
  c|constant|cons ) Output "+$text+" ;;
  type|constantbold ) Output "*+$text+*" ;;
  var|constantitalic ) Output "_++$text++_" ;;
  sub|subscript ) Output "~$text~" ;;
  sup|superscript ) Output "^$text^" ;;
  foot ) Output "footnote:[$text]" ;;
  url|link ) Output "link:\$\$$text\$\$[]" ;;
  esc|escape ) Output "\$\$$text\$\$" # $$*$$ ;;
#######################################################################
  id ) #us_text=${text// /_} # Пробелы в '_'
  #lc_text=${us_text,,} # Нижний регистр; только в bash 4+!
  # Предварительно вызвать `tr -s '_' ' '`, чтобы сохранить _ в случае
  # обработки ID дважды (например, в перекрестных ссылках "xref")
  Output $(echo $text | tr -s '_' ' ' | tr '[:upper:]' '[:lower:]' \
  | tr -d '[:punct:]' | tr -s ' ' '_')
;;
  index ) ## Создать 'index.txt' в каталоге AsciiDoc
egrep '^=== ' ch*.asciidoc | egrep -v '^ch00.asciidoc' \
> $BOOK_ASC/index.txt && {
echo "Updated: $BOOK_ASC/index.txt"
exit 0
} || {
  echo "FAILED to update: $BOOK_ASC/index.txt"
  exit 1
}
;;
  rerun ) for output in examples/*/*.out; do
    code=${output/out/sh}
    echo "Re-running code for: $code > $output"
    $code > $output; done ;;
  cleanup ) rm -fv {ch??,app?}.{pdf,xml,html} book.{xml,html} docbook-xsl.css ;;
  * ) \cd - 
( echo "Usage:" 
  egrep '\)[[:space:]]+# ' $0 
echo ''
  egrep '\)[[:space:]]+## ' $0 
echo ''
  egrep '\)[[:space:]]+### ' $0 ) | grep "${1:-.}" | more ;;
esac
