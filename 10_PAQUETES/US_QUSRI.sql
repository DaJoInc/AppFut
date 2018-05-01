---------------------------------------------PAQUETE DE REGISTRO DE USUARIO------------------------------------------------------------------------------------------------------
--CONTIENE LOS SIGUINETES PROCESOS 																																				-
----------------------------------REGISTRO DE PERSONA                                                                                                                           -
----------------------------------REGISTRO DE USUARIO                                                                                                                           -
----------------------------------ACTUALIZAR CONTRASEÑA                                                                                                                         -
--===============================================================================================================================================================================
CREATE OR REPLACE PACKAGE FS_ADDEP_US.US_QUSRI AS

	PROCEDURE REGISTRO_PERSONA
	(
        p_Id_Persona         		 IN US_PSNA.PSNA_PSNA%type,
        p_Nombre_Persona			 IN US_PSNA.PSNA_NOBR%type,
		p_Apellido_Persona		 	 IN US_PSNA.PSNA_APDO%type,
		p_Tipo_Documento		     IN US_PSNA.PSNA_TPDOC%type,
		p_Documento_Persona		 	 IN US_PSNA.PSNA_DOTO%type,
		p_Fecha_Nacimiento		 	 IN US_PSNA.PSNA_FCNA%type,
		cod_respuesta        		 OUT VARCHAR,
		msg_respuesta        		 OUT VARCHAR
	);
  
    PROCEDURE REGISTRO_USUARIO
	(
        p_Id_Usuario         		 IN US_USRI.USRI_USRI%type,
        p_Nombre_Usuario			 IN US_USRI.USRI_NUSR%type,
		p_Contrasena_Usuario	 	 IN US_USRI.USRI_CTUS%type,
		p_Estado				     IN US_USRI.USRI_ESDO%type,
		p_Id_Persona	 			 IN US_USRI.USRI_PSNA%type,
		cod_respuesta        		 OUT VARCHAR,
		msg_respuesta        		 OUT VARCHAR
	);
	
	PROCEDURE REGISTRO_ROLES
	(
		p_Id_Rol				IN US_USRS.USRS_ROLS%type,
		p_Id_Usuario			IN US_USRS.USRS_USRI%type
	);
	
	PROCEDURE ACTUALIZAR_USUARIO
	(
        p_Id_Usuario         		 	 IN US_USRI.USRI_USRI%type,
        p_Nombre_Usuario			 	 IN US_USRI.USRI_NUSR%type,
		p_Contrasena_Usuario	 	 	 IN US_USRI.USRI_CTUS%type,
		p_Contrasena_Usuario_Nueva	 	 IN US_USRI.USRI_CTUS%type,
		cod_respuesta        		 	 OUT VARCHAR,
		msg_respuesta        		 	 OUT VARCHAR
	);

END FS_ADDEP_US.US_QUSRI;

 /

prompt
prompt PACKAGE BODY: FS_ADDEP_US.US_QUSRI
prompt

create or replace PACKAGE BODY FS_ADDEP_US.US_QUSRI AS

--============================================================================================================================================================
--------------------------------------------------------------------PROCESO PARA EL REGISTRO PERSONA----------------------------------------------------------
	PROCEDURE REGISTRO_PERSONA
	(
	
        p_Id_Persona         		 IN US_PSNA.PSNA_PSNA%type,
        p_Nombre_Persona			 IN US_PSNA.PSNA_NOBR%type,
		p_Apellido_Persona		 	 IN US_PSNA.PSNA_APDO%type,
		p_Tipo_Documento		     IN US_PSNA.PSNA_TPDOC%type,
		p_Documento_Persona		 	 IN US_PSNA.PSNA_DOTO%type,
		p_Fecha_Nacimiento		 	 IN US_PSNA.PSNA_FCNA%type,
		cod_respuesta        		 OUT VARCHAR,
		msg_respuesta        		 OUT VARCHAR
			
	) IS
		
		v_Numero_Registro number;
		v_Documento_Unico number;
		
		BEGIN																					
				INSERT INTO 
					US_PSNA(PSNA_PSNA,PSNA_NOBR,PSNA_APDO,PSNA_TPDOC,PSNA_DOTO,PSNA_FCNA) 
				VALUES(p_Id_Persona,p_Nombre_Persona,p_Apellido_Persona,p_Tipo_Documento,p_Documento_Persona,p_Fecha_Nacimiento);		


		END;
--------------------------------------------------------------------TERMINA PROCESO PARA EL REGISTRO PERSONA----------------------------------------------------------
--====================================================================================================================================================================
--------------------------------------------------------------------PROCESO PARA EL REGISTRO DE USUARIO---------------------------------------------------------------

    PROCEDURE REGISTRO_USUARIO
	(
        p_Id_Usuario         		 IN US_USRI.USRI_USRI%type,
        p_Nombre_Usuario			 IN US_USRI.USRI_NUSR%type,
		p_Contrasena_Usuario	 	 IN US_USRI.USRI_CTUS%type,
		p_Estado				     IN US_USRI.USRI_ESDO%type,
		p_Id_Persona	 			 IN US_USRI.USRI_PSNA%type,
		cod_respuesta        		 OUT VARCHAR,
		msg_respuesta        		 OUT VARCHAR
	) IS
	
		v_Numero_Registro number;
		v_Nombre_Usuario  number;
		v_Contrasena_MD5  varchar(255);
		BEGIN
		
			v_Contrasena_MD5:= utl_i18n.string_to_raw(data =>dbms_obfuscation_toolkit.md5(input_string => p_Contrasena_Usuario));																				
			
			INSERT INTO 
				US_USRI(USRI_USRI,USRI_NUSR,USRI_CTUS,USRI_ESDO,USRI_PSNA) 
			VALUES(p_Id_Usuario,p_Nombre_Usuario,v_Contrasena_MD5,p_Estado,p_Id_Persona);
			
		END;
--------------------------------------------------------------------TERMINA PROCESO PARA EL REGISTRO DE USUARIO---------------------------------------------------------------
--============================================================================================================================================================================
--------------------------------------------------------------------PROCESO REGISTRO ROLES-----------------------------------------------------------------------------------
	PROCEDURE REGISTRO_ROLES
	(
		p_Id_Rol				IN US_USRS.USRS_ROLS%type,
		p_Id_Usuario			IN US_USRS.USRS_USRI%type
	)IS
		
		v_Numero_Registro number;
		
		BEGIN
			
			SELECT COUNT (*) INTO v_Numero_Registro FROM US_USRS;
			
			IF (v_Numero_Registro >= 0) THEN
				
				INSERT INTO 
					US_USRS(USRS_ROLS,USRS_USRI)
				VALUES(p_Id_Rol,p_Id_Usuario);
			
			END IF ;
		END;
--============================================================================================================================================================================
--------------------------------------------------------------------PROCESO PARA LA ACTUALIZACION DE CONTRASEÑA---------------------------------------------------------------

	PROCEDURE ACTUALIZAR_USUARIO
	(
        p_Id_Usuario         		 	 IN US_USRI.USRI_USRI%type,
        p_Nombre_Usuario			 	 IN US_USRI.USRI_NUSR%type,
		p_Contrasena_Usuario	 	 	 IN US_USRI.USRI_CTUS%type,
		p_Contrasena_Usuario_Nueva	 	 IN US_USRI.USRI_CTUS%type,
		cod_respuesta        		 	 OUT VARCHAR,
		msg_respuesta        		 	 OUT VARCHAR
	)IS
	
		v_Contrasana varchar(255);
		v_Contrasena_Nueva varchar(255);
		
		v_Nombre_Usuario varchar(255);
		v_Contrasena_Consulta varchar(255);
		
		BEGIN
		
			--ENCRIPTA MD5 LA CONTRASEÑA INGRESADA POR EL USUARIO  
			v_Contrasana:= utl_i18n.string_to_raw(data =>dbms_obfuscation_toolkit.md5(input_string => p_Contrasena_Usuario));
			v_Contrasena_Nueva:= utl_i18n.string_to_raw(data =>dbms_obfuscation_toolkit.md5(input_string => p_Contrasena_Usuario_Nueva));
		
			--HACE UNA CONSULTA EN LA TABLA US_USRI CON EL NOMBRE DE USUARIO Y CONTRASEÑA INGRESADA POR EL USUARIO
			SELECT USRI_NUSR,USRI_CTUS INTO v_Nombre_Usuario,v_Contrasena_Consulta FROM US_USRI WHERE USRI_NUSR = p_Nombre_Usuario AND USRI_CTUS = v_Contrasana;
					
				--HACE LA COMPARACION CON LOS DATOS INGRESADOS CONTRA LA TABLA US_USRI 	
				IF v_Nombre_Usuario = p_Nombre_Usuario AND  v_Contrasena_Consulta = v_Contrasana THEN
				
					UPDATE US_USRI
						SET USRI_CTUS   =   v_Contrasena_Nueva;
						cod_respuesta:='OK';
						msg_respuesta:='SU CONTRASEÑA SE HA ACTUALIZADO EN EL SISTEMA';
				ELSE
				
						cod_respuesta:='ERROR';
						msg_respuesta:='CONTRASEÑA O NOMBRE DE USUARIO INCORRECTO';				
				
				END IF;
	
		END;
--------------------------------------------------------------------TERMINA PROCESO PARA LA ACTUALIZACION DE CONTRASEÑA-----------------------------------------------------------	
--================================================================================================================================================================================

END FS_ADDEP_US.US_QUSRI;