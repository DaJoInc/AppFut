CREATE OR REPLACE PACKAGE US_QVALI AS

	PROCEDURE VALIDACION_USUARIO
	(
		p_Documento_Persona			 IN NUMBER,
		p_Nombre_Usuario			 IN US_USRI.USRI_NUSR%type,
		cod_respuesta        		 OUT VARCHAR,
		msg_respuesta        		 OUT VARCHAR		
	
	);
	
END US_QVALI;	

/

prompt
prompt PACKAGE BODY: US_QVALI
prompt

create or replace PACKAGE BODY US_QVALI AS

	PROCEDURE VALIDACION_USUARIO
	(
		p_Documento_Persona			 IN NUMBER,
		p_Nombre_Usuario			 IN US_USRI.USRI_NUSR%type,
		cod_respuesta        		 OUT VARCHAR,
		msg_respuesta        		 OUT VARCHAR		
	
	)IS
		v_Nombre_Usuario  number;
		v_Documento_Unico number;
	
		BEGIN
		
			SELECT COUNT(*) INTO v_Documento_Unico FROM US_PSNA  WHERE PSNA_DOTO = p_Documento_Persona;
			SELECT COUNT(*) INTO v_Nombre_usuario FROM US_USRI WHERE USRI_NUSR = p_Nombre_Usuario;
			
			IF(v_Documento_Unico = 0 AND v_Nombre_usuario = 0)THEN
			
				cod_respuesta:='OK';
				msg_respuesta:='EL USUARIO FUE REGISTRADA EN EL SISTEMA';
			END IF;
			
			IF(v_Documento_Unico = 1)THEN
			
				cod_respuesta:='ERROR';
				msg_respuesta:='EL DOCUEMNTO YA SE ENCUENTRA REGISTRADO EN EL SISTEMA';
			
			ELSIF(v_Nombre_usuario = 1)THEN
			
				cod_respuesta:='ERROR';
				msg_respuesta:='EL NOMBRE DE USUARIO YA SE ENCUENTRA REGISTRADO EN EL SISTEMA';
			END IF;
		
		END;
		
END US_QVALI;		