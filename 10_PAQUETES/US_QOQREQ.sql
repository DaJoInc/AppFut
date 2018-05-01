CREATE OR REPLACE PACKAGE US_QOQREQ AS

	PROCEDURE REGISTRO_EQUIPO
	(
		p_Id_Usuario IN number,
		
		p_Id_Equipo   		IN EQ_EQPO.EQPO_EQPO%type,
		p_Nombre_Equipo		IN EQ_EQPO.EQPO_NBEQ%type,
		p_Estado_Equipo		IN EQ_EQPO.EQPO_ESDO%type,
		
		p_Id_Dt_Equipo  	IN US_DTEQ.DTEQ_DTEQ%type,
				
		cod_respuesta        		 OUT VARCHAR,
		msg_respuesta        		 OUT VARCHAR     	
	
	);
	
	PROCEDURE REGISTRO_CONVOCATORIA
	(
		p_Id_Usuario IN number,
		p_Id_Convocatoria  	IN EQ_CVCT.CVCT_CVCT%type,
		p_Id_Equipo			IN EQ_CVCT.CVCT_CVCT%type,
		p_Estado			IN EQ_CVCT.CVCT_ESDO%type,
		
		cod_respuesta        		 OUT VARCHAR,
		msg_respuesta        		 OUT VARCHAR    	
	
	);
	
END US_QOQREQ;	

/

prompt
prompt PACKAGE BODY: US_QOQREQ
prompt

create or replace PACKAGE BODY US_QOQREQ AS

	PROCEDURE REGISTRO_EQUIPO
	(
		p_Id_Usuario IN number,
		
		p_Id_Equipo   		IN EQ_EQPO.EQPO_EQPO%type,
		p_Nombre_Equipo		IN EQ_EQPO.EQPO_NBEQ%type,
		p_Estado_Equipo		IN EQ_EQPO.EQPO_ESDO%type,
		
		p_Id_Dt_Equipo  	IN US_DTEQ.DTEQ_DTEQ%type,
				
		cod_respuesta        		 OUT VARCHAR,
		msg_respuesta        		 OUT VARCHAR     	
	
	)IS
		v_Usuario_Unico number;
		v_Id_Rol number;
		
		v_Id_Equipo NUMBER;
		v_Dt_Equipo NUMBER;
		
		v_Estado_Equipo number;
		
		BEGIN
		
			v_Estado_Equipo:=0;
			v_Id_Equipo:=ID_EQUIPO.NextVal;
		    v_Dt_Equipo:=ID_DT_EQUIPO.NextVal; 
		
			US_QVLEQ.VALIDACION_EQUIPO(p_Id_Usuario,cod_respuesta,msg_respuesta);
		
			
			IF(cod_respuesta = 'OK')THEN
			
					EQ_QEQPO.REGISTRO_EQUIPO(v_Id_Equipo,p_Nombre_Equipo,v_Estado_Equipo,p_Id_Usuario,cod_respuesta,msg_respuesta);
					
					EQ_QEQPO.REGISTRO_DIRECTIVO_EQUIPO(v_Dt_Equipo,v_Id_Equipo,v_Estado_Equipo,p_Id_Usuario);
			ELSE

				cod_respuesta:='ERROR';
				msg_respuesta:='SU USUARIO YA TIENE UN EQUIPO REGISTRADO O NO TIENE PERMISO';
			END IF;
		END;
		
		
		PROCEDURE REGISTRO_CONVOCATORIA
	(
		p_Id_Usuario IN number,
		p_Id_Convocatoria  	IN EQ_CVCT.CVCT_CVCT%type,
		p_Id_Equipo			IN EQ_CVCT.CVCT_CVCT%type,
		p_Estado			IN EQ_CVCT.CVCT_ESDO%type,
		
		cod_respuesta        		 OUT VARCHAR,
		msg_respuesta        		 OUT VARCHAR    	
	
	)IS
	
	v_Id_Equipo number;
	v_Estado number;
	v_Id_Convocatoria number;
	BEGIN
		v_Id_Convocatoria:=ID_CONVOCATORIA.NextVal;
		v_Estado:=0;
		SELECT DTEQ_EQPO INTO v_Id_Equipo FROM US_DTEQ WHERE DTEQ_USRI = p_Id_Usuario;
		
		IF(v_Id_Equipo=1)THEN
			EQ_QEQPO.REGISTRO_CONVOCATORIA(v_Id_Convocatoria,v_Id_Equipo,v_Estado,cod_respuesta,msg_respuesta);
		END IF;
	
	
	END;
END US_QOQREQ;		