#!/bin/bash

check=$1

if [[ "$EUID" -ne 0 ]]; then
    echo sudo ./l1.sh
    exit 1
fi

if [[ $check = '' ]]; then
    $0 -h
fi

case "$check" in
"-h"|"--help")
    printf "Авторы:\n\tАлександр Шихалев\n\tАлина Насонова\n\tГригорий Голомидов\n
Все доступные аргументы:\n\t-i - Вывод всех сетевых интерфейсов
\t-o - Включение/отсключение заданных интерфейсов
\t-s - Установка IP/Mask/Gateway для определенного интерфейса
\t-k - Убийство процесса по занимаему порту
\t-f - Отключение сетевого интерфейса по шаблону ip
\t-n - Отображение сетевой статистики\n\t-a - Отключение всех сетевых интерфейсов
Кратное описание проекта:
\tПроект позволяет управлять сетевыми настройками системы с помощью аргументов.
Примеры запуска:\n\tl1.sh -o down <int_name1> up <int_name2>\n\tl1.sh -k <port>\n
\tl1.sh -s <ip> <mask> <int_name> <gw>\n\tl1.sh -f <ip>\n";;
"-k")
    kill -9 $(lsof -t -i4:$2);;
"-i")
    printf "Имя сетевого инт.\tMAC адрес\t\tIP адрес\t\tСкорость соединения\n"
    for i in $(ls /sys/class/net/)
    do
	printf "$i\t\t$(ifconfig $i | grep "ether" | awk '{print $2}')\t\t$(ifconfig $i | grep "inet " | awk '{print $2}')\t\t$(ifconfig $i | grep "RX packets" | awk '{print $6, $7}')\n"
    done;;
"-o")
    for (( i=2, j=3; i <= $#; i+=2, j+=2 ))
    do
	ip link set ${!j} ${!i}
	#"if${!i}" ${!j}
    done;;
"-a")
    for i in $(ls /sys/class/net/)
    do
	ip link set $i down
    done;;
"-s")
    ip addr add $2/$3 dev $4
    #ifconfig $4 $2 netmask $3 up
    ip route add default via $5;;
"-n")
    netstat -plntu --inet | sort -t: -k2,2n | sort --stable -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n | sort -s -t" " -k1,1;;
#"-f")
#    z="1[0-9][0-9].1[0-9][0-9].[0-9].[0-9]"
#    d=$(ip r | grep $z | sed '1d' | awk '{print $3}')
#    sudo ifdown $d;;
"-f")
    d=$(ip a | grep $2 | awk '{print $9}')
    #d=$(ip r | grep $2 | sed '1d' | awk '{print $3}')
    ip link set $d down;;
esac