--------------------------------------------PAQUETE PARA LA CREACION DE TORNEOS E INVITACION DE EQUIPOS------------------------------------------------------
--CONTIENE LOS SIGUIENTES PROCESOS
----------------------------------REGISTRO TORNEO
----------------------------------REGISTRO EQUIPO TORNEOS
--===========================================================================================================================================================
CREATE OR REPLACE PACKAGE TN_QTRNE AS

PROCEDURE REGISTRAR_TORNEO
(
		p_Id_Torne    	  	IN TN_TRNE.TRNE_TRNE%TYPE,
		p_Nombre_Torneo   	IN TN_TRNE.TRNE_TRNB%TYPE,
		p_Numero_equipos   	IN TN_TRNE.TRNE_NMEQ%TYPE,
		p_Estado_Equipo		IN TN_TRNE.TRNE_ESDO%TYPE,
		
		cod_respuesta        		 OUT VARCHAR,
		msg_respuesta        		 OUT VARCHAR

);

PROCEDURE REGISTRO_EQUIPO_TORNEO
(
		p_Id_Equipo_Torneo  IN TN_TREQ.TREQ_TREQ%TYPE,
		p_Id_Equipo  		IN TN_TREQ.TREQ_EQPO%TYPE,
		p_Id_Torneo  	IN TN_TREQ.TREQ_TRNE%TYPE,
		
		cod_respuesta        		 OUT VARCHAR,
		msg_respuesta        		 OUT VARCHAR
		
);
	
END TN_QTRNE;

 /

prompt
prompt PACKAGE BODY: TN_QTRNE
prompt

create or replace PACKAGE BODY TN_QTRNE AS
--===============================================================================================================================================
-----------------------------------------------------PROCESO REGISTRO TORNEO--------------------------------------------------------------------

PROCEDURE REGISTRAR_TORNEO
(
		p_Id_Torne    	  	IN TN_TRNE.TRNE_TRNE%TYPE,
		p_Nombre_Torneo   	IN TN_TRNE.TRNE_TRNB%TYPE,
		p_Numero_Equipos   	IN TN_TRNE.TRNE_NMEQ%TYPE,
		p_Estado_Equipo		IN TN_TRNE.TRNE_ESDO%TYPE,
		
		cod_respuesta        		 OUT VARCHAR,
		msg_respuesta        		 OUT VARCHAR

)IS
	v_Numero_Torneos number;
	
	BEGIN
		
		SELECT COUNT(*) INTO v_Numero_Torneos FROM TN_TRNE;
		
		IF(v_Numero_Torneos >= 0)THEN
		
			INSERT INTO
				TN_TRNE(TRNE_TRNE,TRNE_TRNB,TRNE_NMEQ,TRNE_ESDO)
			VALUES(p_Id_Torne,p_Nombre_Torneo,p_Numero_Equipos,p_Estado_Equipo);
			
			cod_respuesta:='OK';
			msg_respuesta:='TORNEO REGISTRADO';
			
		END IF ;
		
	END;
--------------------------------------------------------TERMINA PROCESO REGISTRO TORNEO---------------------------------------------------------------------
--==========================================================================================================================================================
--------------------------------------------------------PROCESO REGISTRO EQUIPO TORNEO----------------------------------------------------------------------
	PROCEDURE REGISTRO_EQUIPO_TORNEO
(
		p_Id_Equipo_Torneo  IN TN_TREQ.TREQ_TREQ%TYPE,
		p_Id_Equipo  		IN TN_TREQ.TREQ_EQPO%TYPE,
		p_Id_Torneo  		IN TN_TREQ.TREQ_TRNE%TYPE,
		
		cod_respuesta        		 OUT VARCHAR,
		msg_respuesta        		 OUT VARCHAR
		
)IS

	v_Numero_Equipo_Torneo number;
	v_Numero_Participantes number;
	
	BEGIN
	
		
		--CONSULTA EL NUMERO DE EQUIPOS QUE PUEDEN PARTICIPAR EN UN TORNEO
		SELECT TRNE_NMEQ INTO v_Numero_Participantes FROM TN_TRNE WHERE TRNE_TRNE = p_Id_Torneo ;
		--CONSULTA EN NUMERO DE EQUIPOS REGISTRADOS EN EL TORNEO
		SELECT COUNT(*) INTO v_Numero_Equipo_Torneo FROM TN_TREQ WHERE TREQ_TRNE = p_Id_Torneo ;
		
		--TOMA EL VALOR DE REGISTROS POR TONEO Y SI ES MENOR QUE EL NUMERO DE PARTICIPANTES HACE EL REGISTRO
		IF(v_Numero_Equipo_Torneo >= 0 and v_Numero_Equipo_Torneo < v_Numero_Participantes)THEN
		
			INSERT INTO
				TN_TREQ(TREQ_TREQ,TREQ_EQPO,TREQ_TRNE)
			VALUES(p_Id_Equipo_Torneo,p_Id_Equipo,p_Id_Torneo);
			
			cod_respuesta:='OK';
			msg_respuesta:='EQUIPO REGISTRADO AL TORNEO';
			
		ELSE
		
			cod_respuesta:='ERROR';
			msg_respuesta:='SE ALCANZO EL LIMITE DE EQUIPOS PERMITIDOS';
		END IF;
		
	END;
-------------------------------------------------------------FINAL PROCESO REGISTRO EQUIPO TORNEO------------------------------------------------------------------------------
--=============================================================================================================================================================================
END TN_QTRNE;