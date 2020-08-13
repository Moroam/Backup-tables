# Backup-tables
Incremental backup of MySQL tables

Let's suppose you have 2 servers: a working server and a test/backup server.
The amount of data is large, but the differences are not so large (just a few million rows).
Full data migration (full recovery from backup) is not good idea.
It will be enough to transfer the difference.

These scripts are designed to solve this problem.

How it works

1. #sel_tables.sql# — SQL query to select/commit the current state of the test server.
    Edit it for your own tasks.
    "-" assumes a full copy of the table.
2. #sel_tables.sh# — script for running sel_tables. sql on the test server
    The result of the work is uploaded to the file tables.csv.
    After receiving the tables.csv and edit it to fit your needs.
    Move the tables.csv file to the working server.
3. #backup_tables.sh# — run it on the working server and place the tables.csv file next to it.
    As a result, you will get a folder with the necessary table archives.
    Move this folder to the test server.
3. #restore_tables.sh# — running the test server
    Don't forget to specify the path to the folder with table archives in the script.
