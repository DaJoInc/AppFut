CREATE OR REPLACE PACKAGE US_QUSRI AS

	PROCEDURE REGISTRO_PERSONA(
            p_Id_Persona         		 IN US_PSNA.PSNA_PSNA%type,
            p_Nombre_Persona			 IN US_PSNA.PSNA_NOBR%type,
			p_Apellido_Persona		 	 IN US_PSNA.PSNA_APDO%type,
			p_Tipo_Documento		     IN US_PSNA.PSNA_TPDOC%type,
			p_Documento_Persona		 	 IN US_PSNA.PSNA_DOTO%type,
			p_Fecha_Nacimiento		 	 IN US_PSNA.PSNA_FCNA%type,
			cod_respuesta        		 OUT VARCHAR,
			msg_respuesta        		 OUT VARCHAR
	);
  
    PROCEDURE REGISTRO_USUARIO(
            p_Id_Usuario         		 IN US_USRI.USRI_USRI%type,
            p_Nombre_Usuario			 IN US_USRI.USRI_NUSR%type,
			p_Contrasena_Usuario	 	 IN US_USRI.USRI_CTUS%type,
			p_Estado				     IN US_USRI.USRI_ESDO%type,
			p_Id_Persona	 			 IN US_USRI.USRI_PSNA%type,
			cod_respuesta        		 OUT VARCHAR,
			msg_respuesta        		 OUT VARCHAR
	);
	
	    PROCEDURE ACTUALIZAR_USUARIO(
            p_Id_Usuario         		 	 IN US_USRI.USRI_USRI%type,
            p_Nombre_Usuario			 	 IN US_USRI.USRI_NUSR%type,
			p_Contrasena_Usuario	 	 	 IN US_USRI.USRI_CTUS%type,
			p_Contrasena_Usuario_Nueva	 	 IN US_USRI.USRI_CTUS%type,
			cod_respuesta        		 	 OUT VARCHAR,
			msg_respuesta        		 	 OUT VARCHAR
	);

END US_QUSRI;

 /

prompt
prompt PACKAGE BODY: US_QUSRI
prompt

create or replace PACKAGE BODY US_QUSRI AS

--============================================================================================================================================================
--------------------------------------------------------------------PROCESO PARA EL REGISTRO PERSONA----------------------------------------------------------
	PROCEDURE REGISTRO_PERSONA(
	
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
		
			--CONSULTA SI EXISTE UN REGISTRO EN LA TABLA US_PSNA
			SELECT COUNT(*) INTO v_Numero_Registro FROM US_PSNA; 										
			
			--CONSULTA SI EL DOCUMENTO YA SE ENCUENTRA REGISTRADO EN LA TABLA US_PSNA
			SELECT COUNT(*) INTO v_Documento_Unico FROM US_PSNA WHERE PSNA_DOTO = p_Tipo_Documento;		
			
			--IF PARA MANEJAR LA EXEPCION SI LA TABLA US_PSNA NO CONTIENE NINGUN DATO
			IF (v_Numero_Registro >= 0) THEN 																								
			
				INSERT INTO 
					US_PSNA(PSNA_PSNA,PSNA_NOBR,PSNA_APDO,PSNA_TPDOC,PSNA_DOTO,PSNA_FCNA) 
				VALUES(p_Id_Persona,p_Nombre_Persona,p_Apellido_Persona,p_Tipo_Documento,p_Documento_Persona,p_Fecha_Nacimiento);
				
					cod_respuesta:='OK';
					msg_respuesta:='LA PERSONA FUE REGISTRADA EN EL SISTEMA';	
					
			END IF;
			
			--SI EL DOCUMENTO NO EXISTE EN LA TABLA US_PSNA HACE EL REGISTRO Y AL FINALIZAR MUESTRA UN CODIGO DE OK CON UN MENSAJE
			IF(v_Documento_Unico = 0)THEN																
			
				INSERT INTO 
					US_PSNA(PSNA_PSNA,PSNA_NOBR,PSNA_APDO,PSNA_TPDOC,PSNA_DOTO,PSNA_FCNA) 
				VALUES(p_Id_Persona,p_Nombre_Persona,p_Apellido_Persona,p_Tipo_Documento,p_Documento_Persona,p_Fecha_Nacimiento);
				
					cod_respuesta:='OK';
					msg_respuesta:='LA PERSONA FUE REGISTRADA EN EL SISTEMA';
					
			--SI EL DOCUMENTO SI EXISTE MUESTRA UN CODIGO DE ERROR CON UN MENSAJE
			ELSE																						
					cod_respuesta:='ERROR';
					msg_respuesta:='EL NUMERO DE DOCUMENTO YA SE ENCUENTRA REGISTRADO EN EL SISTEMA';
			
			END IF;
		END;
--------------------------------------------------------------------TERMINA PROCESO PARA EL REGISTRO PERSONA----------------------------------------------------------
--====================================================================================================================================================================
--------------------------------------------------------------------PROCESO PARA EL REGISTRO DE USUARIO---------------------------------------------------------------

    PROCEDURE REGISTRO_USUARIO(
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
		BEGIN
		
			--CONSULTA SI EXISTE UN REGISTRO EN LA TABLA US_USRI
			SELECT COUNT(*) INTO v_Numero_Registro FROM US_USRI;
			
			--CONSULTA SI EL NOMBRE DE USUARIO  YA SE ENCUENTRA REGISTRADO EN LA TABLA US_USRI
			SELECT COUNT(*) INTO v_Nombre_usuario FROM US_USRI WHERE USRI_NUSR = p_Nombre_Usuario;
			
						--IF PARA MANEJAR LA EXEPCION SI LA TABLA US_USRI NO CONTIENE NINGUN DATOS
			IF (v_Numero_Registro >= 0) THEN 																								
			
				INSERT INTO 
					US_USRI(USRI_USRI,USRI_NUSR,USRI_CTUS,USRI_ESDO,USRI_PSNA) 
				VALUES(p_Id_Usuario,p_Nombre_Usuario,p_Contrasena_Usuario,p_Estado,p_Id_Persona);
				
					cod_respuesta:='OK';
					msg_respuesta:='EL USUARIO FUE REGISTRADO EN EL SITEMA';	
					
			END IF;
			
			--SI EL NOMBRE DE USUARIO  NO EXISTE EN LA TABLA US_USRI HACE EL REGISTRO Y AL FINALIZAR MUESTRA UN CODIGO DE OK CON UN MENSAJE
			IF(v_Nombre_Usuario = 0)THEN																
			
				INSERT INTO 
					US_USRI(USRI_USRI,USRI_NUSR,USRI_CTUS,USRI_ESDO,USRI_PSNA) 
				VALUES(p_Id_Usuario,p_Nombre_Usuario,p_Contrasena_Usuario,p_Estado,p_Id_Persona);
				
					cod_respuesta:='OK';
					msg_respuesta:='LA PERSONA FUE REGISTRADA EN EL SISTEMA';
					
			--SI EL NOMBRE DE USUARIO SI EXISTE MUESTRA UN CODIGO DE ERROR CON UN MENSAJE
			ELSE																						
					cod_respuesta:='ERROR';
					msg_respuesta:='EL NOMBRE DE USUARIO NO ESTA DISPONIBLE';
			
			END IF;
						
		END;
--------------------------------------------------------------------TERMINA PROCESO PARA EL REGISTRO DE USUARIO---------------------------------------------------------------
--============================================================================================================================================================================
--------------------------------------------------------------------PROCESO PARA LA ACTUALIZACION DE CONTRASEÑA---------------------------------------------------------------

	PROCEDURE ACTUALIZAR_USUARIO(
            p_Id_Usuario         		 	 IN US_USRI.USRI_USRI%type,
            p_Nombre_Usuario			 	 IN US_USRI.USRI_NUSR%type,
			p_Contrasena_Usuario	 	 	 IN US_USRI.USRI_CTUS%type,
			p_Contrasena_Usuario_Nueva	 	 IN US_USRI.USRI_CTUS%type,
			cod_respuesta        		 	 OUT VARCHAR,
			msg_respuesta        		 	 OUT VARCHAR
	)IS
	
		v_Contrsana varchar(255);
		v_Contrasena_Nueva varchar(255);
		
		v_Nombre_Usuario varchar(255);
		v_Contrasena_Consulta varchar(255);
		
		BEGIN
		
			--ENCRIPTA MD5 LA CONTRASEÑA INGRESADA POR EL USUARIO  
			v_Contrasena:= utl_i18n.string_to_raw(data =>dbms_obfuscation_toolkit.md5(input_string => p_Contrasena_Usuario));
			v_Contrasena_Nueva:= utl_i18n.string_to_raw(data =>dbms_obfuscation_toolkit.md5(input_string => p_Contrasena_Usuario_Nueva));
		
			--HACE UNA CONSULTA EN LA TABLA US_USRI CON EL NOMBRE DE USUARIO Y CONTRASEÑA INGRESADA POR EL USUARIO
			SELECT USRI_NUSR,USRI_CTUS INTO v_Nombre_Usuario,v_Contrasena_Consulta FROM US_USRI WHERE USRI_NUSR = p_Nombre_Usuario AND USRI_CTUS = v_contrasena;
					
				--HACE LA COMPARACION CON LOS DATOS INGRESADOS CONTRA LA TABLA US_USRI 	
				IF v_Nombre_Usuario = p_Nombre_Usuario AND  v_Contrasena_Consulta = v_Contrasena THEN
				
					UPDATE USRI_NUSR
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

END US_QUSRI;