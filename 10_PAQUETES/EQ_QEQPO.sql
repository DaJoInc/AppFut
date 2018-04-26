-----------------------------------------------------------PAQUETE PARA EL REGISTRO EQUIPO--------------------------------------------------
--CONTIENE LOS SIGUIENTES PROCESOS																										   -
----------------------------------REGISTRO DE EQUIPO                                                                                       -
----------------------------------REGISTRO DE DIRECTIVOS POR EQUIPO                                                                        -
--==========================================================================================================================================
CREATE OR REPLACE PACKAGE EQ_QEQPO AS

	PROCEDURE REGISTRO_EQUIPO
	(
				p_Id_Equipo   		IN EQ_EQPO.EQPO_EQPO%type,
				p_Nombre_Equipo		IN EQ_EQPO.EQPO_NBEQ%type,
				p_Estado_Equipo		IN EQ_EQPO.EQPO_ESDO%type,
				p_Id_Usuario 		IN number,
				
				cod_respuesta        		 OUT VARCHAR,
				msg_respuesta        		 OUT VARCHAR
	);
	
	PROCEDURE REGISTRO_DIRECTIVO_EQUIPO
	(			
				p_Id_Dt_Equipo  	IN US_DTEQ.DTEQ_DTEQ%type,
				p_Id_Equipo_Dt 		IN US_DTEQ.DTEQ_EQPO%type,
				p_Estado			IN US_DTEQ.DTEQ_ESDO%type,
				p_Id_Usuario_Dt		IN US_DTEQ.DTEQ_USRI%type
	);
	
END EQ_QEQPO;

 /

prompt
prompt PACKAGE BODY: EQ_QEQPO
prompt

create or replace PACKAGE BODY EQ_QEQPO AS
--============================================================================================================================================================
-----------------------------------------------------PROCESO REGISTRO EQUIPO---------------------------------------------------------------------------------
	PROCEDURE REGISTRO_EQUIPO(
				
				p_Id_Equipo   		IN EQ_EQPO.EQPO_EQPO%type,
				p_Nombre_Equipo		IN EQ_EQPO.EQPO_NBEQ%type,
				p_Estado_Equipo		IN EQ_EQPO.EQPO_ESDO%type,
				
				p_Id_Usuario IN number,
				
				cod_respuesta        		 OUT VARCHAR,
				msg_respuesta        		 OUT VARCHAR
	
	)IS
	
	V_Numero_Registro number;
	v_Numero_Registro_Us number;
	
	BEGIN
		
		/*SELECT COUNT (*) INTO v_numero_Registro FROM EQ_EQPO;
		
		IF(v_numero_Registro = 0 )THEN

			INSERT INTO 
				EQ_QEQPO(EQPO_EQPO,EQPO_NBEQ,EQPO_ESDO)
			VALUES(p_Id_Equipo,p_Nombre_Equipo,p_Estado_Equipo);
			
		END;*/
		--CONSULTA SI PARA SABER SI UN USUARIO YA RREGISTRO UN EQUIPO
		SELECT COUNT (*) INTO v_Numero_Registro_Us FROM US_DTEQ WHERE DTEQ_USRI = p_Id_Usuario;
		
		--SI NO HA REGISTRADO EQUIPO HACE UN INSERT Y MUESTRA UN MENSAJE 
		IF(v_Numero_Registro_Us >= 0 )THEN

			INSERT INTO 
				EQ_EQPO(EQPO_EQPO,EQPO_NBEQ,EQPO_ESDO)
			VALUES(p_Id_Equipo,p_Nombre_Equipo,p_Estado_Equipo);
			
			cod_respuesta:='OK';
		    msg_respuesta:='EQUIPO REGISTRADO';
		ELSE
		
			cod_respuesta:='ERROR';
		    msg_respuesta:='SU USUARIO YA TIENE UN EQUIPO REGISTRADO';
			
		END IF;
	
	END;
---------------------------------------------------------------------------TERMINA PROCESO REGISTRO EQUIPO---------------------------------------------------------------------------------
--=========================================================================================================================================================================================
-------------------------------------PROCESO DE REGISTRO DE DIRECTIVOS CON SU EQUIPO-------------------------------------------------------------------------------------------------------
	PROCEDURE REGISTRO_DIRECTIVO_EQUIPO
	(			
				p_Id_Dt_Equipo  	IN US_DTEQ.DTEQ_DTEQ%type,
				p_Id_Equipo_Dt 		IN US_DTEQ.DTEQ_EQPO%type,
				p_Estado			IN US_DTEQ.DTEQ_ESDO%type,
				p_Id_Usuario_Dt		IN US_DTEQ.DTEQ_USRI%type
	)IS
	
	v_Numero_Registro number ;
	BEGIN
	
		SELECT COUNT (*) INTO v_Numero_Registro FROM US_DTEQ;
		
		IF(v_Numero_Registro >=0 )THEN
		
			INSERT INTO 
				US_DTEQ(DTEQ_DTEQ,DTEQ_EQPO,DTEQ_ESDO,DTEQ_USRI)
			VALUES(p_Id_Dt_Equipo,p_Id_Equipo_Dt,p_Estado,p_Id_Usuario_Dt);
		
		END IF;
	END;

END EQ_QEQPO;