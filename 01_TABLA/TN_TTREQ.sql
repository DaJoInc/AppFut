/* ---------------------------------------------------- */
/*  Generated by Enterprise Architect Version 13.5 		*/
/*  Created On : 24-abr.-2018 12:13:06 p.m. 				*/
/*  DBMS       : Oracle 						*/
/* ---------------------------------------------------- */


CREATE TABLE  "FS_ADDEP_US"."TN_TREQ"
(
	"TREQ_TREQ" NUMBER(32) NOT NULL, --"id torneo equipo"
	"TREQ_EQPO" NUMBER(32) NULL, --"id equipo"
	"TREQ_TRNE" NUMBER(32) NOT NULL		 --"id torneo"
)
TABLESPACE	TS_ADDEP
PCTFREE		10
INITRANS	1
MAXTRANS	255
STORAGE (
	INITIAL		65536
	MINEXTENTS	1
	MAXEXTENTS	2147483645
	BUFFER_POOL	DEFAULT
	)
LOGGING
NOCOMPRESS
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON TABLE "FS_ADDEP_US"."TN_TREQ" 					IS 'Contiene llos equipos registrados'
;
COMMENT ON COLUMN "FS_ADDEP_US"."TN_TREQ"."TREQ_TREQ"		IS 'Identificador unico por equipo'
;
COMMENT ON COLUMN "FS_ADDEP_US"."TN_TREQ"."TREQ_EQPO"  		IS 'Contiene los nombres de los equipos registrados'
;
COMMENT ON COLUMN "FS_ADDEP_US"."TN_TREQ"."TREQ_TRNE"  		IS 'Estado de los equipos'
;

ALTER TABLE  "FS_ADDEP_US"."TN_TREQ" 
 ADD CONSTRAINT "PK_TN_TREQ"
	PRIMARY KEY ("TREQ_TREQ") 
 USING INDEX 
 LOGGING 
 TABLESPACE	TS_IADDEP 
 PCTFREE		10 
 INITRANS	2 
 MAXTRANS	255 
 STORAGE 
 ( 
	INITIAL		65536
	MINEXTENTS 1
	MAXEXTENTS 2147483645
	BUFFER_POOL DEFAULT 
 );


