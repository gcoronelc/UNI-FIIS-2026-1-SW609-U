show user;


SELECT 
    name        AS "Parámetro",
    description AS "Descripción",
    value       AS "Valor"
FROM 
    v$parameter
WHERE 
    name IN (
        'shared_pool_size',
        'db_cache_size',
        'large_pool_size',
        'java_pool_size',
        'sga_max_size',
        'sga_target'
    )
ORDER BY 
    name;
    
select instance_name from v$instance;

select name from v$database;


select component,current_size from v$sga_dynamic_components;


select name from v$controlfile;

select name from v$datafile;

select group#, members from v$log;

select group#, member from v$logfile order by 1;

select * from v$tablespace;

-- Ver el tamaño de bloque estándar de la BD
SELECT name, value
FROM v$parameter
WHERE name = 'db_block_size';

-- Ver tamaños de bloque por tablespace
SELECT tablespace_name,
       block_size
FROM dba_tablespaces
ORDER BY block_size;

select tablespace_name, file_name
from dba_data_files;


select username, default_tablespace, temporary_tablespace 
from dba_users
where username in ('SYS','SYSTEM','SCOTT','HR');


select * from gv_$aq_server_pool;

SELECT GRANTEE, GRANTED_ROLE, ADMIN_OPTION, DEFAULT_ROLE 
FROM DBA_ROLE_PRIVS 
WHERE GRANTEE = 'SYS';


