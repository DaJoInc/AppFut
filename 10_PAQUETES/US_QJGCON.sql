CREATE OR REPLACE PACKAGE US_QJGCON AS


	
	PROCEDURE MOSTRAR_CONVOCATORIA
	(
		 p_Lista_Convocatorias OUT TT_LTCV
	
	);
	
END US_QJGCON;	

/

prompt
prompt PACKAGE BODY: US_QJGCON
prompt

create or replace PACKAGE BODY US_QJGCON AS

	PROCEDURE MOSTRAR_CONVOCATORIA
	(
		 p_Lista_Convocatorias OUT TT_LTCV
	
	)IS
	CURSOR convocatoria IS
		SELECT EQ_CVCT.CVCT_CVCT,
               EQ_CVCT.CVCT_EQPO,
               EQ_EQPO.EQPO_NBEQ
		FROM EQ_CVCT
		INNER JOIN EQ_EQPO ON EQ_CVCT.CVCT_EQPO = EQ_EQPO.EQPO_EQPO;
        
        
		 v_Lista_Convocatoria TO_LTCV; 
         v_TT_Lista_Convocatoria TT_LTCV := TT_LTCV();
	BEGIN
       
       
         
             FOR i IN convocatoria LOOP
         
                v_Lista_Convocatoria:=TO_LTCV(i.CVCT_CVCT,i.CVCT_EQPO,i.EQPO_NBEQ);
                v_TT_Lista_Convocatoria.extend;
                v_TT_Lista_Convocatoria(v_TT_Lista_Convocatoria.count):=v_Lista_Convocatoria;
         
             END LOOP;
         
             p_Lista_Convocatorias:=v_TT_Lista_Convocatoria;
                 

end;	