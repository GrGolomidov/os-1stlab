#!/bin/bash

check=$1

case "$check" in
"-h"|"--help")
    printf "Авторы:\n\tАлександр Шихалев\n\tАлина Насонова\n\tГригорий Голомидов\n
Все доступные аргументы:\n\t-i - Вывод всех сетевых интерфейсов
\t-o - Включение/отсключение заданных интерфейсов
\t-s - Установка IP/Mask/Gateway для определенного интерфейса
\t-k - Убийство процесса по занимаему порту
\t-m - Построение карты сети\n\t-p - Отображение сетевой статистики
Кратное описание проекта:
\tПроект позволяет управлять сетевыми настройками системы с помощью аргументов.
Примеры запуска:\n\tl1.sh -o down <int_name1> up <int_name2>\n\tl1.sh -k <port>\n";;
"-k")
    kill -9 $2;;
"-i")
    printf "Имя сетевого инт.\tMAC адрес\t\tIP адрес\t\tСкорость соединения\n"
    for i in $(ls /sys/class/net/)
    do
	printf "$i\t\t$(ifconfig $i | grep "ether" | awk '{print $2}')\t\t$(ifconfig $i | grep "inet " | awk '{print $2}')\t\t$(ifconfig $i | grep "RX packets" | awk '{print $6, $7}')\n"
    done;;
"-o")
    q=$#
    for (( i=2, j=3; i <= q; i+=2, j+=2 ))
    do
	sudo ip link set ${!j} ${!i}
	#sudo "if${!i}" ${!j}
    done;;
esac