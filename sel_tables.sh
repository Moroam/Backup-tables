#!/bin/bash

# MySQL settings
mysql_user="backup_user"
mysql_password="backup_user_password"

mysql --user=${mysql_user} --password=${mysql_password} < sel_tables.sql > tables.csv
