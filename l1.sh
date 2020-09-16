#!/bin/bash

check=$1

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
\tl1.sh -s <ip> <mask> <int_name> <gw>\n";;
"-k")
    kill -9 $2;;
"-i")
    printf "Имя сетевого инт.\tMAC адрес\t\tIP адрес\t\tСкорость соединения\n"
    for i in $(ls /sys/class/net/)
    do
	printf "$i\t\t$(ifconfig $i | grep "ether" | awk '{print $2}')\t\t$(ifconfig $i | grep "inet " | awk '{print $2}')\t\t$(ifconfig $i | grep "RX packets" | awk '{print $6, $7}')\n"
    done;;
"-o")
    for (( i=2, j=3; i <= $#; i+=2, j+=2 ))
    do
	sudo ip link set ${!j} ${!i}
	#sudo "if${!i}" ${!j}
    done;;
"-a")
    for i in $(ls /sys/class/net/)
    do
	sudo ip link set $i down
    done;;
"-s")
    #sudo ip addr add $2/$3 dev $4
    sudo ifconfig $4 $2 netmask $3 up
    sudo ip route add default via $5;;
"-n")
    netstat -r
    netstat -i
    netstat -s
#"-f")
    #grep -E -o "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)" file.txt
    #printf $ip
esac