# os-1stlab
Лабораторная 1. Командная оболочка. Создание проекта «Управление сетевыми настройками системы»

Язык программирования: bash

ТЗ:

    В проекте должен обрабатываться аргумент "-h" для вывода справки, в которой отображаются:
        Авторы;
        Все доступные аргументы;
        Краткое описание проекта;
        Примеры запуска.
    Проект обязательно должен содержать следующий функционал (на хорошо):
        Вывод всех сетевых интерфейсов;
        Включение/отключение заданных интерфейсов (в т.ч. сразу нескольких);
        Установка IP/Mask/Gateway для определенного интерфейса.

Общие сведения:

Проект позволяет управлять сетевыми настройками системы с помощью аргументов.

Все доступные аргументы:

    -i - Вывод всех сетевых интерфейсов
    -o - Включение/отсключение заданных интерфейсов
    -s - Установка IP/Mask/Gateway для определенного интерфейса
    -k - Убийство процесса по занимаему порту
    //-m - Построение карты сети
    //-p - Отображение сетевой статистики