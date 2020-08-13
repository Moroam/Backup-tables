#!/bin/bash

USERNAME="user_name"
PASSWORD="user_password"
DBNAME="mydatabase"
LOG="restore.log"

# directory with backup
DIR="2020_08_10"

BEFOR="SET foreign_key_checks=0;SET unique_checks=0;SET sql_log_bin=0;"
AFTER="SET foreign_key_checks=1;SET unique_checks=1;SET sql_log_bin=1;"

echo "# `date +%Y%m%d-%H:%M` START Restore MySQL"  | tee -a $LOG

for FILE in $(ls -1 $DIR); do
  echo "Restore: $DIR/$FILE" | tee -a $LOG
  mysql -u${USERNAME} -p${PASSWORD} ${DBNAME} -e"${BEFOR}"
  zcat -f $DIR/${FILE} | mysql -u${USERNAME} -p${PASSWORD} ${DBNAME} | tee -a $LOG
  mysql -u${USERNAME} -p${PASSWORD} ${DBNAME} -e"${AFTER}"
done

echo "# `date +%Y%m%d-%H:%M` END Restore MySQL"  | tee -a $LOG
