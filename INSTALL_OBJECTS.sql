ALTER SESSION SET CURRENT_SCHEMA=FS_PCRM_US;

PROMPT CREANDO TABLAS
@@01_TABLA/00_INSTALADOR.sql

PROMPT CREANDO PAQUETE FOREIGN_KEY
@@02_FOREIGN_KEY/00_INSTALADOR.sql


PROMPT CREANDO SECUENCIAS
@@03_INDICES/00_INSTALADOR.sql

PROMPT CREANDO SECUENCIAS
@@02_SECUENCIAS/01_SECUENCIAS.sql

PROMPT CREANDO PAQUETE INSERTAR DATOS PERSONA
@@10_PAQUETES/00_INSTALADOR.sql


