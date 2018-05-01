REM ******************************************************************
REM Fecha         : 26/03/2018
REM Realizado por : TheOverLordKotan
REM Base de Datos : FS_PCRM_US
REM ******************************************************************

REM TABLESPACE TEMPORAL

Create Temporary tablespace TS_TADDEP TEMPFILE
'C:\oraclexe\app\oracle\oradata\XE\TADDEP.dbf' size 300m
         Extent management local uniform size 2m
;

REM TABLESPACE DE DATOS
CREATE TABLESPACE TS_ADDEP DATAFILE 
  'C:\oraclexe\app\oracle\oradata\XE\DADDEP.DBF' SIZE 300M AUTOEXTEND ON NEXT 1024M MAXSIZE UNLIMITED
LOGGING
ONLINE
PERMANENT
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;


REM TABLESPACE DE INDICES 
                                                            
CREATE TABLESPACE TS_IADDEP DATAFILE 
  'C:\oraclexe\app\oracle\oradata\XE\IADDEP.DBF' SIZE 300M AUTOEXTEND ON NEXT 1024M MAXSIZE UNLIMITED
LOGGING
ONLINE
PERMANENT
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;   

