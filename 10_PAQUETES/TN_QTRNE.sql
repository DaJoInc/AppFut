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
	
END TN_QTRNE;

 /

prompt
prompt PACKAGE BODY: TN_QTRNE
prompt

create or replace PACKAGE BODY TN_QTRNE AS

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


END TN_QTRNE;