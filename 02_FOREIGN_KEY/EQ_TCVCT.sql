/* ---------------------------------------------------- */
/*  Generated by Enterprise Architect Version 13.5 		*/
/*  Created On : 24-abr.-2018 12:11:25 p.m. 			*/
/*  DBMS       : Oracle 								*/
/* ---------------------------------------------------- */




ALTER TABLE  "FS_ADDEP_US"."EQ_CVCT" 
 ADD CONSTRAINT "FK_EQ_CVCT_EQ_EQPO"
	FOREIGN KEY ("CVCT_EQPO") REFERENCES  "FS_ADDEP_US"."EQ_EQPO" ("EQPO_EQPO")
;
