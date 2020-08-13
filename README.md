# Backup-tables
Incremental backup of MySQL tables

Let's suppose you have 2 servers: a working server and a test/backup server.
The amount of data is large, but the differences are not so large (just a few million rows).
Full data migration (full recovery from backup) is not good idea.
It will be enough to transfer the difference.

These scripts are designed to solve this problem.

How it works:

1. sel_tables.sql — SQL query to select/commit the current state of the test server.
    Edit it for your own tasks.
    "-" assumes a full copy of the table.
2. sel_tables.sh — script for running sel_tables. sql on the test server
    The result of the work is uploaded to the file tables.csv.
    After receiving the tables.csv and edit it to fit your needs.
    Move the tables.csv file to the working server.
3. backup_tables.sh — run it on the working server and place the tables.csv file next to it.
    As a result, you will get a folder with the necessary table archives.
    Move this folder to the test server.
4. restore_tables.sh — running the test server.
    Don't forget to specify the path to the folder with table archives in the script.

# Backup-tables
Инкриментальный бэкап таблиц MySQL

Предположим у вас есть 2 сервера: рабочий и тестовый/резервный.
Объем данных большой, а различия не столь велики (буквально несколько миллионов строк).
Полный перенос данных (полное восстановление из бэкапа) не целесообразен.
Достаточно будет перенести только разницу.

Данные скрипты призваны решить эту проблему.

Порядок работы:

1. sel_tables.sql — SQL запрос на выборку/фиксацию текущего состояния тестового сервера.
	Редактируете его под свои задачи.
	«-» предполагает полную копию таблицы.
2. sel_tables.sh — скрипт для запуска sel_tables.sql на тестовом сервере.
	Результат работы выгружается в файл tables.csv.
	После получения tables.csv редактируете его под свои нужды.
	Файл tables.csv переносите на рабочий сервер.
3. backup_tables.sh — запускаете на рабочем сервере, рядом с ним располагаете файл tables.csv.
	В результате получите папку с архивами необходимых таблиц.
	Переносите эту папку на тестовый сервер.
3. restore_tables.sh — запускаете на тестовом сервер.
	Не забудьте в скрипте указать путь к папке с архивами таблиц.
