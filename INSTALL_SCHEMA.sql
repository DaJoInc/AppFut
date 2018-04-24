SET serveroutput on size 10000
SET linesize 500
SET verify on 
SPOOL C:\Users\user\Desktop\ProyectoFutbol\SqlProyecto.txt

PROMPT 00_SCHEMA...
@@00_SCHEMA/00_INSTALADOR.sql
SPOOL OFF;

SET FEEDBACK ON
SET page 200