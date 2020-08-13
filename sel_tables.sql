SET @db:='mydatabase';

select concat(
    T.TABLE_NAME, ',',
    if(C.COLUMN_NAME is null or T.AUTO_INCREMENT is null,
	'-',
	concat(C.COLUMN_NAME, '>=', T.AUTO_INCREMENT)
    )
) as '-'
from information_schema.tables T
    left join information_schema.columns C on C.TABLE_NAME=T.TABLE_NAME and T.table_schema=C.table_schema
where C.table_schema=@db
    and lower(C.column_key)='pri'
    and C.extra='auto_increment';
