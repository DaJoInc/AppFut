/* ---------------------------------------------------- */
/*  Generated by Enterprise Architect Version 13.5 		*/
/*  Created On : 24-abr.-2018 12:14:11 p.m. 				*/
/*  DBMS       : Oracle 						*/
/* ---------------------------------------------------- */



ALTER TABLE  "US_CVJU" 
 ADD CONSTRAINT "FK_US_CVJU_EQ_CVCT"
	FOREIGN KEY ("CVJU_CVCT") REFERENCES  "EQ_CVCT" ("CVCT_CVCT")
;

ALTER TABLE  "US_CVJU" 
 ADD CONSTRAINT "FK_US_CVJU_US_USRI"
	FOREIGN KEY ("CVJU_USRI") REFERENCES  "US_USRI" ("USRI_USRI")
;
