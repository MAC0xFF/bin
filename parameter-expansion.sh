#!/usr/bin/env bash
# parameter-expansion.sh: применение дополнительных параметров для анализа
# Автор и дата: _bash Idioms_ 2022
# Имя файла в bash Idioms: examples/ch04/parameter-expansion.sh
#_________________________________________________________________________
# Не работает в Zsh 5.4.2!
customer_subnet_name='Acme Inc subnet 10.11.12.13/24'
echo ''
echo "Say we have this string: $customer_subnet_name"
customer_name=${customer_subnet_name%subnet*} # Удалить 'subnet' в конце
subnet=${customer_subnet_name##* } # Удалить начальные пробелы
ipa=${subnet%/*} # Удалить '/*' в конце
cidr=${subnet#*/} # Удалить до '/*'
fw_object_name=${customer_subnet_name// /_} # Заменить пробелы на '_'
fw_object_name=${fw_object_name////-} # Заменить '/' на '-'
fw_object_name=${fw_object_name,,} # В нижний регистр
echo ''
echo 'When the code runs we get:'
echo ''
echo "Customer name: $customer_name"
echo "Subnet: $subnet"
echo "IPA $ipa"
echo "CIDR mask: $cidr"
echo "FW Object: $fw_object_name"

# ${var#pattern} Удалить кратчайшее совпадение с pattern в начале
# ${var##pattern} Удалить самое длинное совпадение с pattern в начале
# ${var%pattern} Удалить кратчайшее совпадение с pattern в конце
# ${var%%pattern} Удалить самое длинное совпадение с pattern в конце
# ${var/pattern/replacement} Заменить первое совпадение с pattern на replacement
# ${var//pattern/replacement} Заменить все совпадения с pattern на replacement
# ${var^pattern} Преобразовать первое совпадение с pattern в верхний
# регистр
# ${var^^pattern} Преобразовать все совпадения с pattern в верхний
# регистр
# ${var,pattern} Преобразовать первое совпадение с pattern в нижний
# регистр
# ${var,,pattern} Преобразовать все совпадения с pattern в нижний
# регистр
# ${var:offset} Извлечь подстроку, начиная с offset
# ${var:offset:length} Извлечь подстроку, начиная с offset, длиной length
# ${var:-default} Вернуть значение var, если имеется, иначе default
# ${var:=default} Присвоить default переменной var, если она еще не
# установлена
# ${var:?error_message} Вернуть error_message, если var не установлена
# ${var:+replaced} Вернуть replaced, если var установлена
# ${#var} Вернуть длину var
# ${!var[*]} Вернуть индексы или ключи массива
# ${!var[@]} Вернуть индексы или ключи массива (поддерживаются
# кавычки)
# ${!prefix*} Вернуть имена переменных, начинающиеся с +prefix+
# ${!prefix@} Вернуть имена переменных, начинающиеся с prefix,
# (поддерживаются кавычки)
# ${var@Q} Вернуть значение в кавычках
# ${var@E} Вернуть развернутое значение (лучше, чем `eval`!)
# ${var@P} Вернуть развернутое значение как приглашение к вводу
# ${var@A} Вернуть оператор присваивания или объявления
# переменной
# ${var@a} Вернуть атрибуты
