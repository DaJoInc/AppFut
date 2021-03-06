/* ---------------------------------------------------- */
/*  Generated by Enterprise Architect Version 13.5 		*/
/*  Created On : 24-abr.-2018 12:15:49 p.m. 				*/
/*  DBMS       : Oracle 						*/
/* ---------------------------------------------------- */


CREATE TABLE  "FS_ADDEP_US"."US_JDEQ"
(
	"JDEQ_JDEQ" 	NUMBER(32) NOT NULL,	 --"id jugador equipo"
	"JDEQ_EQPO" 	NUMBER(32) NOT NULL,	 --"nombre equipo"
	"JDEQ_ESDO" 	NUMBER(8) NULL,			 --"estado equipo"
	"JDEQ_USRI" 	NUMBER(32) NOT NULL		 --"id usuario"
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

COMMENT ON TABLE "FS_ADDEP_US"."US_JDEQ" IS 'Contiene los jugadores con su respectivo equipo'
;
COMMENT ON COLUMN "FS_ADDEP_US"."US_JDEQ"."JDEQ_JDEQ"		  IS 'Identificador unico de jugadorequipo'
;                                         
COMMENT ON COLUMN "FS_ADDEP_US"."US_JDEQ"."JDEQ_EQPO"  IS 'Nombre de equipo'
;                                         
COMMENT ON COLUMN "FS_ADDEP_US"."US_JDEQ"."JDEQ_ESDO"  IS 'estado del equipo'
;                                         
COMMENT ON COLUMN "FS_ADDEP_US"."US_JDEQ"."JDEQ_USRI"  IS 'identificador del usuario'
;

ALTER TABLE  "FS_ADDEP_US"."US_JDEQ"
 ADD CONSTRAINT "PK_US_JDEQ"
	PRIMARY KEY ("JDEQ_JDEQ") 
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
