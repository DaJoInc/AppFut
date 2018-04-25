--------------------------------------------------------------------------PAQUETE INGRESO DE USUARIO-----------------------------------------------------------------------------------
--CONTIENE LOS SIGUINETES PROCESOS																																					  -
----------------------------------INGRESO DE USUARIO                                                                                                                                  -
--=====================================================================================================================================================================================
CREATE OR REPLACE PACKAGE US_QINGS AS

	PROCEDURE INGRESO_USUARIO
	(
		p_Nombre_Usuario			 IN US_USRI.USRI_NUSR%type,
		p_Contrasena_Usuario	 	 IN US_USRI.USRI_CTUS%type,
		cod_respuesta        		 OUT VARCHAR,
		msg_respuesta        		 OUT VARCHAR		
	
	);
	
END US_QINGS;	

 /

prompt
prompt PACKAGE BODY: US_QINGS
prompt

create or replace PACKAGE BODY US_QINGS AS

--===============================================================================================================================================================================
---------------------------------------------------------------------PROCEDIMIENTO DE INGRESO DE USUARIO------------------------------------------------------------------------
	PROCEDURE INGRESO_USUARIO
	(
		p_Nombre_Usuario			 IN US_USRI.USRI_NUSR%type,
		p_Contrasena_Usuario	 	 IN US_USRI.USRI_CTUS%type,
		cod_respuesta        		 OUT VARCHAR,
		msg_respuesta        		 OUT VARCHAR	
	
	)IS
	
	--CURSOR CONSULTA EL ID DE USUARIO SEGUN EL NOMBRE DE USUARIO
	--Y CONTRASEÑA INGRESADA POR EL USUARIO
	CURSOR USUARIO
	IS
     SELECT USRI_USRI
		FROM US_USRI
			WHERE US_USRI = p_Nombre_Usuario AND USRI_NUSR = p_Contrasena_Usuario;
	 
	 r_Usuario USRI_USRI%ROWTYPE;
	 v_Id_Usuario number;
	 v_Id_Rol number;
	 
	BEGIN
	
		OPEN USUARIO;
		FETCH USUARIO INTO r_Usuario;
	
		--SI LA CONSULTA DEL CRUSOR DEVUELVE UN VERDADERRO CUARDA EL ID DE USUARIO EN VARIABLE
		IF(USUARIO%FOUND)THEN
				
				v_Id_Usuario := r_Usuario.USRI_USRI;
							
		END IF;
	
		CLOSE USUARIO; 
	
		--CONSULTA EL ID DEL ROL DEPENDIENDO EL ID DEL USUARIO
		SELECT USRS_ROLS INTO v_Id_Rol FROM US_USRS WHERE USRS_USRI = v_Id_Usuario;	
		
		IF(v_Id_Rol = 1) THEN
		
			cod_respuesta:= 'AD'; --ROL ADMINISTRADOR
		                          
		END IF;		              
				                  
		IF(v_Id_Rol = 2) THEN	  
				                  
			cod_respuesta:= 'DT'; --ROL DIRECTIVO
				                  
		END IF;		              
				                  
		IF(v_Id_Rol = 3) THEN	  
				                  
			cod_respuesta:= 'JG'; --ROL JUGADOR
		
		END IF;
	
	END;
--------------------------------------------------------------------------------------------------------TERMINA PROCESO DE INGRESO--------------------------------------------------------------
--==============================================================================================================================================================================================
END US_QINGS;