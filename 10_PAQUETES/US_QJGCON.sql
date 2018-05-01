CREATE OR REPLACE PACKAGE US_QJGCON AS


	
	PROCEDURE MOSTRAR_CONVOCATORIA
	(
		p_Id_Convocatoria  	OUT EQ_CVCT.CVCT_CVCT%type,
		p_Id_Equipo			OUT EQ_CVCT.CVCT_EQPO%type,
		p_Nombre_Equipo		OUT EQ_EQPO.EQPO_NBEQ%type,
	
	);
	
END US_QJGCON;	

/

prompt
prompt PACKAGE BODY: US_QJGCON
prompt

create or replace PACKAGE BODY US_QJGCON AS

	PROCEDURE MOSTRAR_CONVOCATORIA
	(
		p_Id_Convocatoria  	OUT EQ_CVCT.CVCT_CVCT%type,
		p_Id_Equipo			OUT EQ_CVCT.CVCT_EQPO%type,
		p_Nombre_Equipo		OUT EQ_EQPO.EQPO_NBEQ%type,
	
	)IS
	CURSOR convocatoria IS
		SELECT EQ_CVCT.CVCT_CVCT,
               EQ_CVCT.CVCT_EQPO,
				EQ_EQPO.EQPO_NBEQ
		FROM EQ_CVCT
		INNER JOIN EQ_EQPO ON EQ_CVCT.CVCT_EQPO = EQ_EQPO.EQPO_EQPO;
		
		r_Convocatoria%ROWTYPE;
	BEGIN
		OPEN convocatoria;
		FETCH convocatoria INTO r_Convocatoria;
		
		WHILE convocatoria%FOUND
		LOOP
			/* Procesamiento de los registros recuperados */
			FETCH convocatoria INTO r_Convocatoria;
		END LOOP;
		CLOSE convocatoria;
	
	END;

	
END US_QJGCON;		