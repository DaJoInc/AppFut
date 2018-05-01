--------------------------------------------------------------------------PAQUETE INGRESO DE USUARIO-----------------------------------------------------------------------------------
--CONTIENE LOS SIGUINETES PROCESOS																																					  -
----------------------------------INGRESO DE USUARIO                                                                                                                                  -
--=====================================================================================================================================================================================
create or replace PACKAGE US_QINGS AS

	PROCEDURE INGRESO_USUARIO
	(
		p_Nombre_Usuario			 IN  US_USRI.USRI_NUSR%type,
		p_Contrasena_Usuario	 	 IN US_USRI.USRI_CTUS%type,
		cod_usuario       		 OUT VARCHAR,
        cod_respuesta      		 OUT VARCHAR,
		msg_respuesta        		 OUT VARCHAR,		
        r_Usuario out number
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
		p_Nombre_Usuario			 IN  US_USRI.USRI_NUSR%type,
		p_Contrasena_Usuario	 	 IN US_USRI.USRI_CTUS%type,
		cod_usuario       		 OUT VARCHAR,
        cod_respuesta           OUT VARCHAR,
		msg_respuesta        		 OUT VARCHAR,
        r_Usuario out number
	
	)IS
	
	--CURSOR CONSULTA EL ID DE USUARIO SEGUN EL NOMBRE DE USUARIO
	--Y CONTRASEÃ‘A INGRESADA POR EL USUARIO
	CURSOR USUARIO
	IS
     SELECT USRI_USRI
		FROM US_USRI
			WHERE USRI_NUSR = p_Nombre_Usuario AND USRI_CTUS = utl_i18n.string_to_raw(data =>dbms_obfuscation_toolkit.md5(input_string => p_Contrasena_Usuario));

	 
	 v_Id_Usuario number;
	 v_Id_Rol number;

	BEGIN

		OPEN USUARIO;
		FETCH USUARIO INTO r_Usuario;

		--SI LA CONSULTA DEL CRUSOR DEVUELVE UN VERDADERRO CUARDA EL ID DE USUARIO EN VARIABLE
		IF(USUARIO%FOUND)THEN

				v_Id_Usuario := r_Usuario;
                cod_respuesta:='OK';
                msg_respuesta :='DATOS CORRECTOS';
		CLOSE USUARIO; 

		--CONSULTA EL ID DEL ROL DEPENDIENDO EL ID DEL USUARIO
		SELECT USRS_ROLS INTO v_Id_Rol FROM US_USRS WHERE USRS_USRI = v_Id_Usuario;	

		IF(v_Id_Rol = 1) THEN

			cod_usuario:= 'AD'; --ROL ADMINISTRADOR

		END IF;		              

		IF(v_Id_Rol = 2) THEN	  

			cod_usuario:= 'DT'; --ROL DIRECTIVO

		END IF;		              

		IF(v_Id_Rol = 3) THEN	  

			cod_usuario:= 'JG'; --ROL JUGADOR

		END IF;
        
      
        ELSIF(USUARIO%NOTFOUND) THEN
            cod_respuesta:='ERROR';
            msg_respuesta :='CONTRASEÑA O NOMBRE DE USUARIO INCORRECTO';
        END IF;
	END;
--------------------------------------------------------------------------------------------------------TERMINA PROCESO DE INGRESO--------------------------------------------------------------
--==============================================================================================================================================================================================
END US_QINGS;