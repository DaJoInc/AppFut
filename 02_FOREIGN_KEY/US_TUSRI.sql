/* ---------------------------------------------------- */
/*  Generated by Enterprise Architect Version 13.5 		*/
/*  Created On : 24-abr.-2018 12:17:38 p.m. 			*/
/*  DBMS       : Oracle 								*/
/* ---------------------------------------------------- */




ALTER TABLE  "US_USRI" 
 ADD CONSTRAINT "FK_US_USRI_US_PSNA"
	FOREIGN KEY ("USRI_PSNA") REFERENCES  "US_PSNA" ("PSNA_PSNA")
;
