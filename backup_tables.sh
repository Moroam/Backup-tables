#!/bin/bash
# Simple script to backup MySQL databases

# Parent backup directory
backup_parent_dir="/home/backups_table"

# Журналируем ошибки и успешное выполнение бекапа в файл
LOGFILE="/root/backups_table/backup.log"

# MySQL database for backup
database="mydatabase"

# CSV file with tables information
csv="tables.csv"

# MySQL settings
mysql_user="backup_user"
mysql_password="backup_user_password"

echo "# `date +%Y%m%d-%H:%M` START backup  MySQL tables"  | tee -a $LOGFILE

# Create backup directory and set permissions
backup_date=`date +%Y_%m_%d`
backup_dir="${backup_parent_dir}/${backup_date}"
echo "Backup directory: ${backup_dir}"
mkdir -p "${backup_dir}"
chmod 700 "${backup_dir}"

# Backup and compress each table in database with condition
params="--disable-keys --extended-insert"
params_where="--disable-keys --no-create-info --extended-insert"

while IFS=, read -r table where
do
  # skip first row
  if [ ${table} == "-" ]
  then
    continue
  fi

  if [ ${where} == "-" ]
  then
    # INSERT backup with where
    mysqldump ${params_where} --user=${mysql_user} --password=${mysql_password} ${database} ${table} --where=${where} | gzip > "${backup_dir}/${table}.gz"
  else
    # FULL table backup
    mysqldump ${params} --user=${mysql_user} --password=${mysql_password} ${database} ${table} | gzip > "${backup_dir}/${table}.gz"
  fi

  if [ ${PIPESTATUS[0]} != "0" ];
  then
     echo "Backup table is failed ${table}" | tee -a $LOGFILE
  else
     echo "Backup table ${table} is DONE ${where}" | tee -a $LOGFILE
  fi
  chmod 600 "${backup_dir}/${table}.gz"

done < ${csv}
