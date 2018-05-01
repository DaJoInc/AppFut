CREATE OR REPLACE PACKAGE US_QVLEQ AS

	PROCEDURE VALIDACION_EQUIPO
	(
		p_Id_Usuario IN number,
				
		cod_respuesta        		 OUT VARCHAR,
		msg_respuesta        		 OUT VARCHAR     	
	
	);
	
END US_QVLEQ;	

/

prompt
prompt PACKAGE BODY: US_QVLEQ
prompt

create or replace PACKAGE BODY US_QVLEQ AS

	PROCEDURE VALIDACION_EQUIPO
	(
		p_Id_Usuario IN number,
				
		cod_respuesta        		 OUT VARCHAR,
		msg_respuesta        		 OUT VARCHAR  	
	
	)IS
		v_Usuario_Unico number;
		v_Id_Rol number;
	
		BEGIN
		
			SELECT COUNT (*) INTO v_Usuario_Unico FROM US_DTEQ WHERE DTEQ_USRI = p_Id_Usuario;
			SELECT USRS_ROLS INTO v_Id_Rol FROM US_USRS WHERE USRS_USRI = v_Id_Usuario;	
			
			IF(v_Usuario_Unico = 0 AND v_Id_Rol = 2)THEN
			
				cod_respuesta:='OK';
			ELSE

				cod_respuesta:='ERROR';
				msg_respuesta:='SU USUARIO YA TIENE UN EQUIPO REGISTRADO O NO TIENE PERMISO';
			END IF;
		
END US_QVLEQ;		