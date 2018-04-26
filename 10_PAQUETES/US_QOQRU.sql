----------------------------------PAQUETE ORQUESTADOR REGISTRO USUARIO-------------------------------------------------
create or replace PACKAGE US_QOQRU AS

PROCEDURE REGISTRO_USUARIO
(

		
        p_Id_Persona         		 IN US_PSNA.PSNA_PSNA%type,
        p_Nombre_Persona			 IN US_PSNA.PSNA_NOBR%type,
		p_Apellido_Persona		 	 IN US_PSNA.PSNA_APDO%type,
		p_Tipo_Documento		     IN US_PSNA.PSNA_TPDOC%type,
		p_Documento_Persona		 	 IN US_PSNA.PSNA_DOTO%type,
		p_Fecha_Nacimiento		 	 IN US_PSNA.PSNA_FCNA%type,
		
		p_Id_Usuario         		 IN US_USRI.USRI_USRI%type,
        p_Nombre_Usuario			 IN US_USRI.USRI_NUSR%type,
		p_Contrasena_Usuario	 	 IN US_USRI.USRI_CTUS%type,
		p_Estado				     IN US_USRI.USRI_ESDO%type,
		
		p_Id_Rol					 IN US_USRS.USRS_ROLS%type,
		
		cod_respuesta        		 OUT VARCHAR,
		msg_respuesta        		 OUT VARCHAR
		
);

END US_QOQRU;

 /

prompt
prompt PACKAGE BODY: US_QOQRU
prompt

create or replace PACKAGE BODY US_QOQRU AS

PROCEDURE REGISTRO_USUARIO
(

		
        p_Id_Persona         		 IN US_PSNA.PSNA_PSNA%type,
        p_Nombre_Persona			 IN US_PSNA.PSNA_NOBR%type,
		p_Apellido_Persona		 	 IN US_PSNA.PSNA_APDO%type,
		p_Tipo_Documento		     IN US_PSNA.PSNA_TPDOC%type,
		p_Documento_Persona		 	 IN US_PSNA.PSNA_DOTO%type,
		p_Fecha_Nacimiento		 	 IN US_PSNA.PSNA_FCNA%type,
		
		p_Id_Usuario         		 IN US_USRI.USRI_USRI%type,
        p_Nombre_Usuario			 IN US_USRI.USRI_NUSR%type,
		p_Contrasena_Usuario	 	 IN US_USRI.USRI_CTUS%type,
		p_Estado				     IN US_USRI.USRI_ESDO%type,
		
		p_Id_Rol					 IN US_USRS.USRS_ROLS%type,
		
		cod_respuesta        		 OUT VARCHAR,
		msg_respuesta        		 OUT VARCHAR
		
)IS

	BEGIN
	
		US_QVALI.VALIDACION_USUARIO(p_Documento_Persona,p_Nombre_Usuario,cod_respuesta,msg_respuesta);
		
		IF(cod_respuesta='OK') THEN
			
			US_QUSRI.REGISTRO_PERSONA(p_Id_Persona,p_Nombre_Persona,p_Apellido_Persona,p_Tipo_Documento,p_Documento_Persona,p_Fecha_Nacimiento,cod_respuesta,msg_respuesta);
			
			US_QUSRI.REGISTRO_USUARIO(p_Id_Usuario,p_Nombre_Usuario,p_Contrasena_Usuario,p_Estado,p_Id_Persona,cod_respuesta,msg_respuesta);

			US_QUSRI.REGISTRO_ROLES(p_Id_Rol,p_Id_Usuario);
			
			cod_respuesta:='OK';
            msg_respuesta:='EL USUARIO FUE REGISTRADA EN EL SISTEMA';

		END IF;
		
	END;
	
END US_QOQRU;