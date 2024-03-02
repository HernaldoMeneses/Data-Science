select tab4.*,
       :DTINICIO DT_INICIO,
       :DTFIM DT_FIM,
       :COD_FILIAL filial,
       tab4.total_geral-tab4.comissaoliquidez diferenca
       from (
select tab3.*, 
       vlr_meta_fin+vlr_meta_forn_pos+vlr_inad+vlr_meta_forn_fin+vlr_meta_lucro total_recibo,
       vlr_meta_fin+vlr_meta_forn_pos+vlr_inad+vlr_meta_forn_fin+vlr_meta_lucro+sal_fixoinss total_com_mes,
       ((tab3.sal_fixo*(133/100))/12) ferias,
       (tab3.sal_fixo/12) d13,
       ((tab3.sal_fixo*(8/100))) fgts,
       (vlr_meta_fin+vlr_meta_forn_pos+vlr_inad+vlr_meta_forn_fin+vlr_meta_lucro+sal_fixoinss)
          +
        ((tab3.sal_fixo*(133/100))/12)
         +
         (tab3.sal_fixo/12) 
         +
         ((tab3.sal_fixo*(8/100))) total_geral
        
      from 
         (
select tab2.*,
        case when tab2.perc_meta_fin between tab2.perc_min_meta_fin and tab2.perc_max_meta_fin then
               
       ((tab2.comissaoliquidez-tab2.sal_fixo)*(tab2.peso_meta_fin/100))*(tab2.perc_meta_fin/100) 
              when tab2.perc_meta_fin>tab2.perc_max_meta_fin then
          ((tab2.comissaoliquidez-tab2.sal_fixo)*(tab2.peso_meta_fin/100))*( tab2.perc_max_meta_fin/100) 
         else 0 end vlr_meta_fin,
       case when tab2.perc_cob_forn_pos between tab2.PERC_MIN_META_POS_FOR and tab2.PERC_MAX_META_POS_FOR then
       ((tab2.comissaoliquidez-tab2.sal_fixo)*(tab2.PESO_META_POS_FOR/100))*(tab2.perc_cob_forn_pos/100) 
             when tab2.perc_cob_forn_pos>tab2.PERC_MAX_META_POS_FOR then
       ((tab2.comissaoliquidez-tab2.sal_fixo)*(tab2.PESO_META_POS_FOR/100))*(tab2.PERC_MAX_META_POS_FOR/100)
         else 0 end vlr_meta_forn_pos,
       case when tab2.perc_inad<=5 then
       ((tab2.comissaoliquidez-tab2.sal_fixo)*(tab2.PESO_INAD/100))*(100/100)
        when tab2.perc_inad between 5.01 and 7 then
       ((tab2.comissaoliquidez-tab2.sal_fixo)*(tab2.PESO_INAD/100))*(75/100)
        when tab2.perc_inad between 7.01 and 10 then
       ((tab2.comissaoliquidez-tab2.sal_fixo)*(tab2.PESO_INAD/100))*(50/100)
        else 0 end vlr_inad,
       case when tab2.perc_cob_forn_fin between tab2.PERC_MIN_META_fin_FOR and tab2.PERC_MAX_META_fin_FOR then
       ((tab2.comissaoliquidez-tab2.sal_fixo)*(tab2.PESO_META_fin_FOR/100))*(tab2.perc_cob_forn_fin/100)
         when tab2.perc_cob_forn_fin>tab2.PERC_MAX_META_fin_FOR then
       ((tab2.comissaoliquidez-tab2.sal_fixo)*(tab2.PESO_META_fin_FOR/100))*(tab2.PERC_MAX_META_fin_FOR/100)  
         else 0 end vlr_meta_forn_fin,
       
        case when tab2.perc_cob_lucro between tab2.PERC_MIN_LUCRO and tab2.PERC_MAX_LUCRO then
       ((tab2.comissaoliquidez-tab2.sal_fixo)*(tab2.PESO_LUCRO/100))*(tab2.perc_cob_LUCRO/100) 
            when tab2.perc_cob_lucro>tab2.PERC_MAX_LUCRO  then
              ((tab2.comissaoliquidez-tab2.sal_fixo)*(tab2.PESO_LUCRO/100))*(tab2.PERC_MAX_LUCRO/100)  
         else 0 end vlr_meta_lucro,    
         
       tab2.sal_fixo-(tab2.sal_fixo*(INSS/100)) sal_fixoinss
             
                   
      from (
select
       TAB1.*,
       CASE when tab1.vlmetatotal>0 then round(((tab1.vlvenda/tab1.vlmetatotal)*100),2) 
            else 0 end perc_meta_fin,
       tab1.FIXO SAL_FIXO,
       :INSS INSS,
       
       :PERC_MIN_META_FIN PERC_MIN_META_FIN,
       :PERC_MAX_META_FIN PERC_MAX_META_FIN,
       :PESO_META_FIN PESO_META_FIN,
       
       :PERC_MIN_META_FIN_FOR PERC_MIN_META_FIN_FOR,
       :PERC_MAX_META_FIN_FOR PERC_MAX_META_FIN_FOR,
       :PESO_META_FIN_FOR PESO_META_FIN_FOR,
       
       :PERC_MIN_META_POS_FOR PERC_MIN_META_POS_FOR,
       :PERC_MAX_META_POS_FOR PERC_MAX_META_POS_FOR,
       :PESO_META_POS_FOR PESO_META_POS_FOR,
       
       :PERC_MIN_INAD PERC_MIN_INAD,
       :PERC_MAX_INAD PERC_MAX_INAD,
       :PESO_INAD PESO_INAD,
       
       :PERC_MIN_LUCRO PERC_MIN_LUCRO,
       :PERC_MAX_LUCRO PERC_MAX_LUCRO,
       :PESO_LUCRO PESO_LUCRO,
       
       
       fnc_wn_premiacao_comissao(:COD_FILIAL, TAB1.CODUSUR, to_date(:DTINICIO,'dd-mm-rrrr'), to_date(:DTFIM,'dd-mm-rrrr'), 1) LIQUIDEZ,
       fnc_wn_premiacao_comissao(:COD_FILIAL, TAB1.CODUSUR, to_date(:DTINICIO,'dd-mm-rrrr'), to_date(:DTFIM,'dd-mm-rrrr'), 2) COMISSAOLIQUIDEZ,
       fnc_wn_premiacao_comissao(:COD_FILIAL, TAB1.CODUSUR, to_date(:DTINICIO,'dd-mm-rrrr'), to_date(:DTFIM,'dd-mm-rrrr'), 3) PERC_INAD,
       fnc_wn_premiacao_comissao(:COD_FILIAL, TAB1.CODUSUR, to_date(:DTINICIO,'dd-mm-rrrr'), to_date(:DTFIM,'dd-mm-rrrr'), 4) PERC_COB_FORN_FIN,
       fnc_wn_premiacao_comissao(:COD_FILIAL, TAB1.CODUSUR, to_date(:DTINICIO,'dd-mm-rrrr'), to_date(:DTFIM,'dd-mm-rrrr'), 5) PERC_COB_FORN_POS,  
       fnc_wn_premiacao_comissao(:COD_FILIAL, TAB1.CODUSUR, to_date(:DTINICIO,'dd-mm-rrrr'), to_date(:DTFIM,'dd-mm-rrrr'), 6) PERC_COB_LUCRO,
       fnc_wn_premiacao_comissao(:COD_FILIAL, TAB1.CODUSUR, to_date(:DTINICIO,'dd-mm-rrrr'), to_date(:DTFIM,'dd-mm-rrrr'), 7) META_LUCRO,
       fnc_wn_premiacao_comissao(:COD_FILIAL, TAB1.CODUSUR, to_date(:DTINICIO,'dd-mm-rrrr'), to_date(:DTFIM,'dd-mm-rrrr'), 8) PERC_LUCRO
       from ( 
     
SELECT pcusuari.codsupervisor,
      
       pcsuperv.nome AS nomesup, 
       pcusuari.codusur, 
       pcusuari.nome, 
        nvl(pcusuari.comissaofixa,0) FIXO, 
       NVL ((SELECT SUM (pcmetarca.vlvendaprev)
               FROM pcmetarca
              WHERE pcmetarca.codusur = pcusuari.codusur
                AND pcmetarca.codfilial IN (:COD_FILIAL)
                AND pcmetarca.DATA BETWEEN TRUNC(to_date(:DTINICIO,'dd-mm-rrrr'),'mm') AND LAST_DAY(to_date(:DTFIM,'dd-mm-rrrr'))),
            0
           ) AS vlmetatotal,
       NVL (vendas.vlvenda, 0) vlvenda, 
       (  (SELECT COUNT(DISTINCT(PCCLIENT.CODCLI)) 
             FROM pcclient 
            WHERE pcclient.codusur1 = pcusuari.codusur
)
        + (SELECT COUNT(DISTINCT(PCCLIENT.CODCLI)) 
             FROM pcclient
            WHERE pcclient.codusur2 = pcusuari.codusur
            AND NVL(PCCLIENT.codusur1,0) <> NVL(PCCLIENT.codusur2,0) 
)
        + (SELECT COUNT(DISTINCT(PCCLIENT.CODCLI))
             FROM pcusurcli, pcclient
            WHERE pcusurcli.codusur = pcusuari.codusur
              AND pcusurcli.codcli = pcclient.codcli
              AND PCUSURCLI.CODUSUR <> NVL(PCCLIENT.CODUSUR1, 0)
              AND PCUSURCLI.CODUSUR <> NVL(PCCLIENT.CODUSUR2, 0)
)
       ) clqtclicad,
      
( SELECT COUNT(DISTINCT(PCCLIENT.CODCLI)) QTCLIATIVOS FROM PCCLIENT
WHERE ( (PCCLIENT.CODUSUR1 = PCUSUARI.CODUSUR)  OR ( (PCCLIENT.CODUSUR2 = PCUSUARI.CODUSUR ) AND ( NVL(PCCLIENT.codusur1,0) <> NVL(PCCLIENT.codusur2,0)) )  OR
         EXISTS (SELECT PCUSURCLI.CODUSUR
                   FROM PCUSURCLI
                  WHERE PCUSURCLI.CODUSUR = PCUSUARI.CODUSUR
                  AND NVL(PCUSURCLI.CODUSUR,0) <> NVL(PCCLIENT.codusur1,0)
                   AND NVL(PCUSURCLI.CODUSUR,0) <> NVL(PCCLIENT.codusur2,0)
                    AND PCUSURCLI.CODCLI  = PCCLIENT.CODCLI))
AND ( PCCLIENT.DTULTCOMP >= trunc(sysdate - (SELECT nvl(numdiascliinativ,0) FROM pcconsum) ) )
  ) clqtcliativ
  
  FROM pcusuari, 
       pcsuperv, 
       (SELECT   pcpedc.codusur, 
      SUM(ROUND(DECODE(PCPEDC.CONDVENDA,5,0,6,0,11,0,12,0,NVL(PCPEDI.PVENDA, 0) * NVL(PCPEDI.QT, 0)),2)) AS vlvenda,
                 COUNT(DISTINCT(PCPEDC.NUMPED)) QTNF,
                 COUNT(PCPEDI.CODPROD) NUMITENS,
                 SUM(NVL(PCPEDI.PBASERCA, NVL(PCPEDI.PTABELA, 0)) * NVL(PCPEDI.QT, 0)) AS vltabela,
                 SUM(NVL(PCPEDC.PRAZOMEDIO, 0) *  (NVL(PCPEDI.QT, 0) * NVL(PCPEDI.PVENDA,0)) ) AS prazomedio,
      SUM(ROUND(DECODE(PCPEDC.CONDVENDA,5,0,6,0,11,0,12,0,NVL(PCPEDI.PVENDA, 0) * NVL(PCPEDI.QT, 0)),2)) AS VLVENDA1,
                 COUNT (DISTINCT (pcpedc.codcli)) qtcli
          FROM PCPEDI,
               PCPEDC,
               PCPRODUT,
               PCFORNEC,
               PCDEPTO,
               PCCLIENT,
               PCUSUARI,
               PCSUPERV,
               PCATIVI,
               PCPRACA, PCCIDADE
         WHERE PCPEDI.NUMPED = PCPEDC.NUMPED
AND PCCLIENT.CODCIDADE = PCCIDADE.CODCIDADE(+)
           AND PCPEDC.CODCLI = PCCLIENT.CODCLI
           AND PCCLIENT.CODATV1 = PCATIVI.CODATIV(+)
           AND PCPEDC.DTCANCEL IS NULL
           AND PCPEDI.CODPROD = PCPRODUT.CODPROD
           AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO
           AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC
           AND PCPEDC.CODUSUR = PCUSUARI.CODUSUR
           AND PCPEDC.CODSUPERVISOR = PCSUPERV.CODSUPERVISOR
           AND PCPEDC.CODPRACA = PCPRACA.CODPRACA
AND PCPEDC.CONDVENDA IN (1, 2, 3, 7, 9, 14, 15, 17, 18, 19, 98)
             AND pcpedc.dtcancel IS NULL
                      AND pcpedc.vlatend > 0 
             AND pcpedc.codfilial IN (:COD_FILIAL)
             AND pcpedc.DATA BETWEEN to_date(:DTINICIO,'dd-mm-rrrr') AND to_date(:DTFIM, 'dd-mm-rrrr')
        GROUP BY pcpedc.codusur) vendas,
       (SELECT   pcprest.codusur, (SUM(PCPREST.VALOR) ) valor,
                 COUNT (*) qtpend 
            FROM pcprest, pcusuari
           WHERE pcprest.dtpag IS NULL
             AND pcprest.codusur = pcusuari.codusur
           AND pcprest.codfilial IN (:COD_FILIAL)
        GROUP BY pcprest.codusur) financ,
 (SELECT pcprest.codusur, SUM(VALOR) vpago
    FROM PCPREST, PCCLIENT, PCUSUARI, PCSUPERV, PCCOB
   WHERE PCPREST.CODCLI = PCCLIENT.CODCLI
     and PCPREST.CODUSUR = PCUSUARI.CODUSUR
     and PCUSUARI.CODSUPERVISOR = PCSUPERV.CODSUPERVISOR
     and PCPREST.CODCOB = PCCOB.CODCOB
     and PCPREST.CODCOB not in ('DEVP', 'DEVT', 'BNF', 'BNFT', 'BNFR', 'BNTR', 'BNRP', 'CRED')
     and PCPREST.DTPAG is NULL
     and (PCPREST.DTVENC + NVL(PCCOB.DIASCARENCIA,0)) <= (TRUNC(SYSDATE) - 1)
and (Pcprest.CODFILIAL IN (:COD_FILIAL))
 GROUP BY pcprest.codusur) inandimp,
       (SELECT PCPEDC.CODUSUR,COUNT(DISTINCT(PCPEDI.CODPROD)) AS QTMIX
          FROM PCPEDI, PCUSUARI, PCSUPERV, PCPEDC
         WHERE PCPEDI.NUMPED = PCPEDC.NUMPED
           AND PCPEDC.CODUSUR = PCUSUARI.CODUSUR
           AND PCPEDC.DATA BETWEEN to_date(:DTINICIO,'dd-mm-rrrr') AND to_date(:DTFIM,'dd-mm-rrrr') 
AND PCPEDC.CONDVENDA IN (1, 2, 3, 7, 9, 14, 15, 17, 18, 19, 98)
           AND PCPEDC.DTCANCEL IS NULL
                      AND pcpedc.vlatend > 0 
           AND PCUSUARI.CODSUPERVISOR = PCSUPERV.CODSUPERVISOR
           AND PCPEDC.CODFILIAL IN (:COD_FILIAL)
        GROUP BY PCPEDC.codusur) MIX
 WHERE pcusuari.codsupervisor = pcsuperv.codsupervisor
   AND pcusuari.codusur = vendas.codusur(+)
   AND pcusuari.codusur = financ.codusur(+)
   AND pcusuari.codusur = inandimp.codusur(+)
   AND pcusuari.codusur = mix.codusur(+)
   AND pcusuari.codusur in (:COD_RCA)
   AND PCUSUARI.CODSUPERVISOR in (:Cod_Super)

 AND NVL(VLVENDA, 0) <> 0 
ORDER BY PCUSUARI.CODSUPERVISOR,VLVENDA DESC
   ) tab1
)tab2
) tab3
) tab4


-- Incluso Manualmente codigo da fnc_wn_premiacao_comissao para comparação By H.meneses


create or replace function FNC_WN_PREMIACAO_COMISSAO
(
  P_FILIAL     IN NUMBER,
  P_RCA        in NUMBER,
  P_DATA_INI       IN DATE,
  P_DATA_FIM       IN DATE,
  P_OPCAO      IN INTEGER,
  P_VENDA      IN NUMBER default 0,
  P_TABELA     in integer default 0,
  P_PERC_ALT   IN NUMBER default 0,
  P_PERC_REAL  IN NUMBER default 0,
  P_PERC_COM_ALT IN NUMBER default 0,
  P_PERC_MIN IN NUMBER default 0,
  P_PERC_MAX IN NUMBER default 0,
  P_VLR_COM  IN NUMBER default 0
  

)
return number
is

  V_RETORNO                 NUMBER(15,2):=0;
  V_PERC                    NUMBER(15,2):=0;
  V_PERC2                    NUMBER(15,2):=0;
  V_VENDA                   NUMBER(15,2):=0;
  V_META                   NUMBER(15,2):=0;
  V_TIPO_RCA               VARCHAR2(5);
  V_PERC_ALT                NUMBER(15,2):=0;
  V_PERC_COM_ALT            NUMBER(15,2):=0;
  V_COMISSAO_FIXA           NUMBER(15,2):=0;
  v_depto                  integer:=0;
  V_FRACAO_META       NUMBER(15,2):=0;
  v_qtde_meta_prod    integer;
  v_perc_meta_prod    NUMBER(15,2):=0;
  v_tot_prem_meta_prod NUMBER(15,2):=0;

begin

/*
COMPOSIÇÃO DA COMISSÃO DOS REPRESENTANTES E SUPERVISORES;


---COMISSÃO DEPENDE DO TIPO DE RCA (VAREJO OU REDE)


*/


if P_OPCAO = 1 then --- RETORNA A LIQUEDEZ DO RCA
/*  
begin
   select lk.tnumber2
          into
          V_RETORNO
        from wntemp3 lk
           where lk.tinteger1=P_RCA;
   exception 
       when others then
     --  V_RETORNO:=100;      
   --end;  
   */            
begin
       SELECT
        TAB2.VALOR
        INTO
        V_RETORNO

FROM (
      SELECT  TAB1.CODUSUR,
        TAB1.RCA RCA,
        TAB1.VALOR VALOR,
        TAB1.VALORCOMISSAO
     FROM (
SELECT NVL(G.VALORCOMISSAO, 0) VALORCOMISSAOARECEBER,                             
(T.VALORCOMISSAO-T.VALES-DECODE('N','S',T.VALORESTORNO,0)) COMISSAOLIQUIDA,
ROUND(CASE WHEN NVL(T.VALOR,0)>0 THEN
T.VALORCOMISSAO/T.VALOR*100                                                       
ELSE 0                                                                            
END,4) PERCOM                                                                     
, T.*                                                                             
FROM (SELECT COUNT(PCPREST.NUMTRANSVENDA || PCPREST.PREST) QTTITULOS,             
             PCUSUARI.CODUSUR,                                                    
             PCUSUARI.PERCENT,                                                    
             PCUSUARI.PERCENT2,                                                   
             PCUSUARI.NOME RCA,                                                       
             PCUSUARI.TIPOVEND,                                                   
             PCUSUARI.EMAIL,                                                      
             PCUSUARI.CGC,                                                        
             PCUSUARI.BLOQCOMIS,                                                  
             PCUSUARI.NUMBANCO,                                                   
             PCUSUARI.NUMAGENCIA,                                                 
             PCUSUARI.NUMCCORRENTE,                                               
             PCUSUARI.NUMDVCCORRENTE,                                             
             PCUSUARI.INDICERATEIOCOMISSAO,                                       
             PCSUPERV.CODSUPERVISOR,                                              
             PCSUPERV.NOME AS NOMESUPERVISOR,                                     
             --------------VALOR COMISSÃO POR NOTA OU POR TITULO------------------
             ROUND(SUM(NVL(DECODE('P',                                    
                        'P',                                                    
                        DECODE('NF',                                     
                               'NF',                                            
PCPREST.VALOR 
*(PCNFSAID.COMISSAO/
DECODE(NVL(PCNFSAID.VLTOTGER,0),0,1,PCNFSAID.VLTOTGER)
),
PCPREST.VALOR 
                                 * NVL(PCPREST.PERCOM,0)                           
                               /100 ),                                           
                 ----------COMISSAO POR RCA-------------                          
                 ROUND((
PCPREST.VALOR 
 * NVL(DECODE(PCNFSAID.TIPOVENDA,        
                                                             'VV',              
                                                             PCUSUARI.PERCENT,    
                                                             PCUSUARI.PERCENT2),  
                                                      0) / 100),                  
                       2)                                                         
                                                                                  
                       ),0)),2)                                                   
                                                                                  
             VALORCOMISSAO,                                                       
             ---------------------VALES--------------------                       
             NVL((SELECT SUM(DECODE(TIPOLANC, 'D', VALOR, VALOR * -1))          
                 FROM PCCORREN C1                                                 
                 WHERE C1.CODFUNC = PCUSUARI.CODUSUR                              
                 AND C1.TIPOFUNC = 'R'                                          
                 AND C1.CODFILIAL = P_FILIAL                                  
                 ),0) VALES,                                                        
             -------------Retornar Devolução---------------------------           
             NVL((SELECT SUM(E.VLESTORNO)                                         
                 FROM PCCRECLI C, PCESTCOM E                                      
                 WHERE C.DTDESCONTO BETWEEN P_DATA_INI AND P_DATA_FIM                     
                 AND C.CODFILIAL = P_FILIAL                                     
                 AND C.NUMTRANSENTDEVCLI IS NOT NULL                              
                 AND C.NUMTRANSENTDEVCLI = E.NUMTRANSENT                          
                 AND E.CODUSUR = PCUSUARI.CODUSUR),                               
                 0) VALORESTORNO,                                                 
             ------------------------------                                       
             ROUND(NVL(SUM(
                         PCNFSAID.VLTOTGER - (PCNFSAID.ICMSRETIDO + PCNFSAID.VLOUTRASDESP)),        
                       0),                                                        
                   0) VLTOTGERSEMSTVLOUTRASDESP,                                  
             ROUND(NVL(SUM(PCNFSAID.COMISSAO /                                    
                           DECODE((PCNFSAID.VLTOTGER -                            
                                  (PCNFSAID.ICMSRETIDO +                          
                                  PCNFSAID.VLOUTRASDESP)),                        
                                  0,                                              
                                  1,                                              
                                  (PCNFSAID.VLTOTGER - (PCNFSAID.ICMSRETIDO +     
                                  PCNFSAID.VLOUTRASDESP)))),                      
                       0) * 100,                                                  
                   2) PERCOMSEMSTVLOUTRASDESP,                                    
             ROUND(SUM(PCNFSAID.VLTOTGER * (NVL(PCUSUARI.PERCENT, 0) / 100)),     
                   2) AS VLCOMISSAORCA,                                           
             ROUND(SUM(PCNFSAID.VLTOTGER * (NVL(PCUSUARI.PERCENT2, 0) / 100)),    
                   2) AS VLCOMISSAORCA2,                                          
SUM(PCPREST.VALOR) VALOR 
      FROM PCPREST, PCNFSAID, PCUSUARI, PCSUPERV, PCCLIENT, PCCOB                 
      WHERE PCPREST.NUMTRANSVENDA = PCNFSAID.NUMTRANSVENDA                        
      AND PCPREST.CODUSUR = PCUSUARI.CODUSUR(+)                                   
      AND PCPREST.DTPAG IS NOT NULL                                               
      AND PCPREST.CODCOB = PCCOB.CODCOB                                           
      AND PCCOB.PAGCOMISSAO = 'S'                                               
      AND PCPREST.CODCOB NOT IN ('DESD', 'DEVP', 'DEVT', 'BNF')           
      AND PCUSUARI.CODSUPERVISOR = PCSUPERV.CODSUPERVISOR                         
      AND PCNFSAID.CODFISCAL IN (511, 611, 512, 612, 711, 712)                    
      AND PCNFSAID.CONDVENDA <> 4                                                 
      AND PCPREST.CODCLI = PCCLIENT.CODCLI                                        
      AND PCNFSAID.DTCANCEL IS NULL                                               
      AND ((NVL(PCPREST.PERMITEESTORNO, 'S') = 'S') OR                        
            (((NVL(PCPREST.PERMITEESTORNO, 'S') = 'N') AND                    
            (PCPREST.DTESTORNO IS NOT NULL) AND                                   
            (NVL(PCPREST.VALORESTORNO, 0) < NVL(PCPREST.VPAGO, 0)))))             
      AND NVL(PCUSUARI.BLOQCOMIS, 'N') <> 'S'                                 
AND PCPREST.DTPAGCOMISSAO IS NULL
AND PCPREST.Dtbaixa BETWEEN P_DATA_INI AND P_DATA_FIM
AND NVL(PCCOB.TIPOCOMISSAO,'A') IN ('L','A')
      AND (PCPREST.CODFILIAL = P_FILIAL) 
      GROUP BY PCUSUARI.CODUSUR,                                                  
               PCUSUARI.NOME,                                                     
                                                                                  
                PCUSUARI.PERCENT,                                                 
             PCUSUARI.PERCENT2,                                                   
               PCUSUARI.TIPOVEND,                                                 
               PCUSUARI.EMAIL,                                                    
               PCUSUARI.CGC,                                                      
               PCUSUARI.BLOQCOMIS,                                                
               PCUSUARI.NUMBANCO,                                                 
               PCUSUARI.NUMAGENCIA,                                               
               PCUSUARI.NUMCCORRENTE,                                             
               PCUSUARI.NUMDVCCORRENTE,                                           
               PCUSUARI.INDICERATEIOCOMISSAO,                                     
               PCSUPERV.CODSUPERVISOR,                                            
               PCSUPERV.NOME) T,                                                  
     (SELECT U.CODUSUR,                                                           
             U.NOME,                                                              
             COUNT(DISTINCT(P.NUMTRANSVENDA || P.PREST)) QTDOC,                   
             SUM(P.VALOR) VALORARECEBER,                                          
             -----------------------------------                                  
              --------------VALOR COMISSÃO POR NOTA OU POR TITULO-----------------
             ROUND(SUM(NVL(DECODE('P',                                    
                        'P',                                                    
                        DECODE('NF',                                     
                               'NF',                                            
                               P.VALOR* decode(nvl(F.VLTOTGER,0),0,1,(F.COMISSAO/F.VLTOTGER))  
                               ,                                                  
                               (NVL(P.VALOR,0) *                                  
                                  NVL(P.PERCOM,0)                                 
                               /100 )),                                           
                 ----------COMISSAO POR RCA-------------                          
                 ROUND((F.VLTOTGER * NVL(DECODE(F.TIPOVENDA,                      
                                                             'VV',              
                                                             U.PERCENT,           
                                                             U.PERCENT2),         
                                                      0) / 100),                  
                       2)                                                         
                                                                                  
                       ),0)),2)                                                   
                                                                                  
             VALORCOMISSAO,                                                       
                                                                                  
                                                                                  
             ROUND((SUM((P.VALOR * ROUND(NVL(DECODE('P',                  
                                                    'P',                        
                                                    P.PERCOM,                     
                                                    U.PERCENT2),                  
                                             0),                                  
                                         2) / 100) / CASE                         
                          WHEN P.VALOR <= 0 THEN                                  
                           1                                                      
                          ELSE                                                    
                           P.VALOR                                                
                        END * 100)),                                              
                   2) PERCOMISSAO                                                 
                                                                                  
      FROM PCPREST  P,                                                            
           PCNFSAID F,                                                            
           PCCOB    B,                                                            
                                                                                  
           PCUSUARI U                                                             
      WHERE P.NUMTRANSVENDA = F.NUMTRANSVENDA                                     
      AND P.CODUSUR = U.CODUSUR                                                   
                                                                                  
      AND P.DTPAG IS NULL                                                         
      AND P.CODCOB = B.CODCOB                                                     
      AND NVL(B.PAGCOMISSAO, 'N') = 'S'                                       
      AND NVL(U.BLOQCOMIS, 'N') = 'N'                                         
      AND F.CODFISCAL IN (511, 611, 512, 612, 711, 712)                           
      AND F.CONDVENDA NOT IN (4)                                                  
AND NVL(B.TIPOCOMISSAO,'A') IN ('L','A')
           ---------------------------------------------------                    
      AND P.CODFILIAL = P_FILIAL
      AND F.DTCANCEL IS NULL                                                      
      AND P.CODCOB NOT IN ('DESD', 'ESTR', 'DEVT', 'DEVP', 'BNF', 'CANC','CRED')
      GROUP BY U.CODUSUR, U.NOME) G                                               
WHERE T.CODUSUR = G.CODUSUR(+) 
  AND T.CODUSUR = P_RCA                                                   
ORDER BY T.CODSUPERVISOR, T.CODUSUR
) TAB1
      ) TAB2;
  exception when others then
       V_RETORNO := 0;
--  end;
end;

end if;


if P_OPCAO = 2 then --- RETORNA A COMISSÃO DE LIQUEDEZ DO RCA
  /*begin
   select lk.tnumber1
          into
          V_RETORNO
        from wntemp3 lk
           where lk.tinteger1=P_RCA;
   exception 
       when others then
     --  V_RETORNO:=100;      
   --end;   */           
   
begin
       SELECT
        TAB2.VALORCOMISSAO
        INTO
        V_RETORNO

FROM (
      SELECT  TAB1.CODUSUR,
        TAB1.RCA RCA,
        TAB1.VALOR VALOR,
        TAB1.VALORCOMISSAO
     FROM (
SELECT NVL(G.VALORCOMISSAO, 0) VALORCOMISSAOARECEBER,                             
(T.VALORCOMISSAO-T.VALES-DECODE('N','S',T.VALORESTORNO,0)) COMISSAOLIQUIDA,
ROUND(CASE WHEN NVL(T.VALOR,0)>0 THEN
T.VALORCOMISSAO/T.VALOR*100                                                       
ELSE 0                                                                            
END,4) PERCOM                                                                     
, T.*                                                                             
FROM (SELECT COUNT(PCPREST.NUMTRANSVENDA || PCPREST.PREST) QTTITULOS,             
             PCUSUARI.CODUSUR,                                                    
             PCUSUARI.PERCENT,                                                    
             PCUSUARI.PERCENT2,                                                   
             PCUSUARI.NOME RCA,                                                       
             PCUSUARI.TIPOVEND,                                                   
             PCUSUARI.EMAIL,                                                      
             PCUSUARI.CGC,                                                        
             PCUSUARI.BLOQCOMIS,                                                  
             PCUSUARI.NUMBANCO,                                                   
             PCUSUARI.NUMAGENCIA,                                                 
             PCUSUARI.NUMCCORRENTE,                                               
             PCUSUARI.NUMDVCCORRENTE,                                             
             PCUSUARI.INDICERATEIOCOMISSAO,                                       
             PCSUPERV.CODSUPERVISOR,                                              
             PCSUPERV.NOME AS NOMESUPERVISOR,                                     
             --------------VALOR COMISSÃO POR NOTA OU POR TITULO------------------
             ROUND(SUM(NVL(DECODE('P',                                    
                        'P',                                                    
                        DECODE('NF',                                     
                               'NF',                                            
PCPREST.VALOR 
*(PCNFSAID.COMISSAO/
DECODE(NVL(PCNFSAID.VLTOTGER,0),0,1,PCNFSAID.VLTOTGER)
),
PCPREST.VALOR 
                                 * NVL(PCPREST.PERCOM,0)                           
                               /100 ),                                           
                 ----------COMISSAO POR RCA-------------                          
                 ROUND((
PCPREST.VALOR 
 * NVL(DECODE(PCNFSAID.TIPOVENDA,        
                                                             'VV',              
                                                             PCUSUARI.PERCENT,    
                                                             PCUSUARI.PERCENT2),  
                                                      0) / 100),                  
                       2)                                                         
                                                                                  
                       ),0)),2)                                                   
                                                                                  
             VALORCOMISSAO,                                                       
             ---------------------VALES--------------------                       
             NVL((SELECT SUM(DECODE(TIPOLANC, 'D', VALOR, VALOR * -1))          
                 FROM PCCORREN C1                                                 
                 WHERE C1.CODFUNC = PCUSUARI.CODUSUR                              
                 AND C1.TIPOFUNC = 'R'                                          
                 AND C1.CODFILIAL = P_FILIAL                                  
                 ),0) VALES,                                                        
             -------------Retornar Devolução---------------------------           
             NVL((SELECT SUM(E.VLESTORNO)                                         
                 FROM PCCRECLI C, PCESTCOM E                                      
                 WHERE C.DTDESCONTO BETWEEN P_DATA_INI AND P_DATA_FIM                     
                 AND C.CODFILIAL = P_FILIAL                                     
                 AND C.NUMTRANSENTDEVCLI IS NOT NULL                              
                 AND C.NUMTRANSENTDEVCLI = E.NUMTRANSENT                          
                 AND E.CODUSUR = PCUSUARI.CODUSUR),                               
                 0) VALORESTORNO,                                                 
             ------------------------------                                       
             ROUND(NVL(SUM(
                         PCNFSAID.VLTOTGER - (PCNFSAID.ICMSRETIDO + PCNFSAID.VLOUTRASDESP)),        
                       0),                                                        
                   0) VLTOTGERSEMSTVLOUTRASDESP,                                  
             ROUND(NVL(SUM(PCNFSAID.COMISSAO /                                    
                           DECODE((PCNFSAID.VLTOTGER -                            
                                  (PCNFSAID.ICMSRETIDO +                          
                                  PCNFSAID.VLOUTRASDESP)),                        
                                  0,                                              
                                  1,                                              
                                  (PCNFSAID.VLTOTGER - (PCNFSAID.ICMSRETIDO +     
                                  PCNFSAID.VLOUTRASDESP)))),                      
                       0) * 100,                                                  
                   2) PERCOMSEMSTVLOUTRASDESP,                                    
             ROUND(SUM(PCNFSAID.VLTOTGER * (NVL(PCUSUARI.PERCENT, 0) / 100)),     
                   2) AS VLCOMISSAORCA,                                           
             ROUND(SUM(PCNFSAID.VLTOTGER * (NVL(PCUSUARI.PERCENT2, 0) / 100)),    
                   2) AS VLCOMISSAORCA2,                                          
SUM(PCPREST.VALOR) VALOR 
      FROM PCPREST, PCNFSAID, PCUSUARI, PCSUPERV, PCCLIENT, PCCOB                 
      WHERE PCPREST.NUMTRANSVENDA = PCNFSAID.NUMTRANSVENDA                        
      AND PCPREST.CODUSUR = PCUSUARI.CODUSUR(+)                                   
      AND PCPREST.DTPAG IS NOT NULL                                               
      AND PCPREST.CODCOB = PCCOB.CODCOB                                           
      AND PCCOB.PAGCOMISSAO = 'S'                                               
      AND PCPREST.CODCOB NOT IN ('DESD', 'DEVP', 'DEVT', 'BNF')           
      AND PCUSUARI.CODSUPERVISOR = PCSUPERV.CODSUPERVISOR                         
      AND PCNFSAID.CODFISCAL IN (511, 611, 512, 612, 711, 712)                    
      AND PCNFSAID.CONDVENDA <> 4                                                 
      AND PCPREST.CODCLI = PCCLIENT.CODCLI                                        
      AND PCNFSAID.DTCANCEL IS NULL                                               
      AND ((NVL(PCPREST.PERMITEESTORNO, 'S') = 'S') OR                        
            (((NVL(PCPREST.PERMITEESTORNO, 'S') = 'N') AND                    
            (PCPREST.DTESTORNO IS NOT NULL) AND                                   
            (NVL(PCPREST.VALORESTORNO, 0) < NVL(PCPREST.VPAGO, 0)))))             
      AND NVL(PCUSUARI.BLOQCOMIS, 'N') <> 'S'                                 
AND PCPREST.DTPAGCOMISSAO IS NULL
AND PCPREST.Dtbaixa BETWEEN P_DATA_INI AND P_DATA_FIM
AND NVL(PCCOB.TIPOCOMISSAO,'A') IN ('L','A')
      AND (PCPREST.CODFILIAL = P_FILIAL) 
      GROUP BY PCUSUARI.CODUSUR,                                                  
               PCUSUARI.NOME,                                                     
                                                                                  
                PCUSUARI.PERCENT,                                                 
             PCUSUARI.PERCENT2,                                                   
               PCUSUARI.TIPOVEND,                                                 
               PCUSUARI.EMAIL,                                                    
               PCUSUARI.CGC,                                                      
               PCUSUARI.BLOQCOMIS,                                                
               PCUSUARI.NUMBANCO,                                                 
               PCUSUARI.NUMAGENCIA,                                               
               PCUSUARI.NUMCCORRENTE,                                             
               PCUSUARI.NUMDVCCORRENTE,                                           
               PCUSUARI.INDICERATEIOCOMISSAO,                                     
               PCSUPERV.CODSUPERVISOR,                                            
               PCSUPERV.NOME) T,                                                  
     (SELECT U.CODUSUR,                                                           
             U.NOME,                                                              
             COUNT(DISTINCT(P.NUMTRANSVENDA || P.PREST)) QTDOC,                   
             SUM(P.VALOR) VALORARECEBER,                                          
             -----------------------------------                                  
              --------------VALOR COMISSÃO POR NOTA OU POR TITULO-----------------
             ROUND(SUM(NVL(DECODE('P',                                    
                        'P',                                                    
                        DECODE('NF',                                     
                               'NF',                                            
                               P.VALOR* decode(nvl(F.VLTOTGER,0),0,1,(F.COMISSAO/F.VLTOTGER))  
                               ,                                                  
                               (NVL(P.VALOR,0) *                                  
                                  NVL(P.PERCOM,0)                                 
                               /100 )),                                           
                 ----------COMISSAO POR RCA-------------                          
                 ROUND((F.VLTOTGER * NVL(DECODE(F.TIPOVENDA,                      
                                                             'VV',              
                                                             U.PERCENT,           
                                                             U.PERCENT2),         
                                                      0) / 100),                  
                       2)                                                         
                                                                                  
                       ),0)),2)                                                   
                                                                                  
             VALORCOMISSAO,                                                       
                                                                                  
                                                                                  
             ROUND((SUM((P.VALOR * ROUND(NVL(DECODE('P',                  
                                                    'P',                        
                                                    P.PERCOM,                     
                                                    U.PERCENT2),                  
                                             0),                                  
                                         2) / 100) / CASE                         
                          WHEN P.VALOR <= 0 THEN                                  
                           1                                                      
                          ELSE                                                    
                           P.VALOR                                                
                        END * 100)),                                              
                   2) PERCOMISSAO                                                 
                                                                                  
      FROM PCPREST  P,                                                            
           PCNFSAID F,                                                            
           PCCOB    B,                                                            
                                                                                  
           PCUSUARI U                                                             
      WHERE P.NUMTRANSVENDA = F.NUMTRANSVENDA                                     
      AND P.CODUSUR = U.CODUSUR                                                   
                                                                                  
      AND P.DTPAG IS NULL                                                         
      AND P.CODCOB = B.CODCOB                                                     
      AND NVL(B.PAGCOMISSAO, 'N') = 'S'                                       
      AND NVL(U.BLOQCOMIS, 'N') = 'N'                                         
      AND F.CODFISCAL IN (511, 611, 512, 612, 711, 712)                           
      AND F.CONDVENDA NOT IN (4)                                                  
AND NVL(B.TIPOCOMISSAO,'A') IN ('L','A')
           ---------------------------------------------------                    
      AND P.CODFILIAL = P_FILIAL
      AND F.DTCANCEL IS NULL                                                      
      AND P.CODCOB NOT IN ('DESD', 'ESTR', 'DEVT', 'DEVP', 'BNF', 'CANC','CRED')
      GROUP BY U.CODUSUR, U.NOME) G                                               
WHERE T.CODUSUR = G.CODUSUR(+) 
  AND T.CODUSUR = P_RCA                                                   
ORDER BY T.CODSUPERVISOR, T.CODUSUR
) TAB1
      ) TAB2;
  exception when others then
       V_RETORNO := 0;
  end;

 --end;   

end if;

if P_OPCAO = 3 then --- RETORNA A % de inadimplencia vide 1221

  select 
       round((sum(valor30)/(sum(valor30)+sum(valor5))*100),2) 
       into
       V_RETORNO
    from (
select
       valor valor5,
       0  valor30 
      from (
SELECT DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),5),5,5   
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),15),15,15      
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),30),30,30      
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),60),60,60      
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),90),90,90      
,91))))) DIASVENC,                                              
SUM(PCPREST.VALOR) VALOR, COUNT(*) QT                           
 FROM PCPREST 
 WHERE PCPREST.DTPAG IS NULL                                                                                  
   AND (PCPREST.CODFILIAL IN ( P_FILIAL )) 

   AND (PCPREST.CODUSUR IN ( P_RCA )) 


AND PCPREST.VALOR BETWEEN 0 AND 999999999                                                               
AND PCPREST.CODCOB NOT IN ('DEVP', 'DEVT', 'BNF',                                               
                           'BNFT', 'BNFR', 'BNTR',                                        
                           'BNRP', 'CRED', 'DESD')                                             
GROUP BY DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),5),5,5 
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),15),15,15      
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),30),30,30      
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),60),60,60      
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),90),90,90      
,91)))))
) tab1
where tab1.diasvenc=5

union all

select
       0 valor5,
       sum(valor)  valor30 
      from (
SELECT DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),5),5,5   
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),15),15,15      
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),30),30,30      
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),60),60,60      
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),90),90,90      
,91))))) DIASVENC,                                              
SUM(PCPREST.VALOR) VALOR, COUNT(*) QT                           
 FROM PCPREST 
 WHERE PCPREST.DTPAG IS NULL                                                                                  
   AND (PCPREST.CODFILIAL IN ( P_FILIAL )) 

   AND (PCPREST.CODUSUR IN ( P_RCA )) 


AND PCPREST.VALOR BETWEEN 0 AND 999999999                                                               
AND PCPREST.CODCOB NOT IN ('DEVP', 'DEVT', 'BNF',                                               
                           'BNFT', 'BNFR', 'BNTR',                                        
                           'BNRP', 'CRED', 'DESD')                                             
GROUP BY DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),5),5,5 
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),15),15,15      
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),30),30,30      
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),60),60,60      
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),90),90,90      
,91)))))
) tab1
where tab1.diasvenc>16
) tab2;

   /*
   begin
   select lk.tinteger2 
          into
          V_RETORNO
        from wntemp lk
           where lk.tinteger1=P_RCA;
   exception 
       when others then
       V_RETORNO:=100;      
   end;              
    */      

end if;

if P_OPCAO = 4 then --- RETORNA A % de cob de meta financeira vide 322
  select --case when count(*)>0 then sum(perc_meta)/count(*) 
         --else 0 end
       sum(perc_meta)/count(*) 
        --sum(perc_meta)
       into
       V_RETORNO
       from
      (
SELECT DISTINCT 
       PCPRODUT.CODFORNEC, 
       PCFORNEC.FORNECEDOR,
       NVL(VENDAS.PVENDA,0) PVENDA,
       NVL(METAS.VLMETA,0) VLMETA,
       case when NVL(METAS.VLMETA,0)=0 then 0
           else 
       round((NVL(VENDAS.PVENDA,0)/NVL(METAS.VLMETA,0)*100),2) end perc_meta,
       NVL(VENDAS.QTCLIPOS,0) QTCLIPOS,
       NVL(METAS.CLIPOSPREV,0) CLIPOSPREV,
       case when NVL(METAS.CLIPOSPREV,0)=0 then 0 
            else 
       round((NVL(VENDAS.QTCLIPOS,0)/NVL(METAS.CLIPOSPREV,0)*100),2) end perc_pos
FROM PCPRODUT, PCFORNEC,
( 
/* SQL UTILIZADO PELA ROTINA PCSIS322 RELATORIO(S) - 4 */ SELECT 
       PCPRODUT.CODFORNEC, 
       COUNT(DISTINCT(PCPEDC.CODCLI)) QTCLIPOS,
       SUM(ROUND(NVL(PCPEDI.QT,0)*NVL(PCPEDI.PVENDA,0),2)) PVENDA,
       SUM(PCPEDI.QT) QT,
       SUM(ROUND(NVL(PCPRODUT.PESOBRUTO,0)*NVL(PCPEDI.QT,0),2)) AS TOTPESO,
       SUM(NVL(PCPEDI.QT,0) / DECODE(NVL(PCPRODUT.QTUNIT,0),0,1,NVL(PCPRODUT.QTUNIT,1))) TOTQTUNIT,
       SUM(NVL(PCPEDI.QT,0) / DECODE(NVL(PCPRODUT.QTUNITCX,0),0,1,NVL(PCPRODUT.QTUNITCX,1))) TOTQTUNITCX,
       ROUND(SUM(NVL(PCPRODUT.VOLUME,0)*NVL(PCPEDI.QT,0)) ,2) Volume,
       ROUND(SUM(NVL(PCPRODUT.LITRAGEM, 0)*NVL(PCPEDI.QT,0)) ,2) LITRAGEM,
       COUNT(DISTINCT(PCPEDC.NUMPED)) AS QTPEDIDO,
       COUNT(DISTINCT(PCPEDI.CODPROD)) AS QTMIX,
       COUNT(PCPEDI.CODPROD) NUMITENS,
MAX((/* SQL UTILIZADO PELA ROTINA PCSIS322 RELATORIO(S) - 4 */ SELECT COUNT(P.CODPROD) FROM PCPRODUT P,PCDEPTO D WHERE P.CODEPTO = D.CODEPTO
   AND P.CODFORNEC = PCFORNEC.CODFORNEC
   AND NVL(P.OBS2,'  ') <> ('FL'))) AS QTMIXCAD
FROM PCPEDI, PCPEDC, PCPRODUT, PCFORNEC, PCDEPTO, PCCLIENT,
     PCUSUARI, PCATIVI, PCPRACA, PCCIDADE
WHERE PCPEDI.NUMPED = PCPEDC.NUMPED
AND PCUSUARI.CODSUPERVISOR NOT IN ('9999')
AND PCPEDC.DATA BETWEEN P_DATA_INI AND P_DATA_FIM
AND PCPEDC.CODFILIAL IN (P_FILIAL)
AND PCPEDC.CODUSUR IN (P_RCA)
AND PCPEDC.CONDVENDA IN (1, 2, 3, 7, 9, 14, 15, 17, 18, 19, 98)

--AND PCPRODUT.CODFORNEC IN (/* SQL UTILIZADO PELA ROTINA PCSIS322 PARA TODOS RELATORIO(S) */ SELECT CODIGON FROM PCLIB WHERE CODFUNC = 1 AND CODTABELA = 3)

AND PCCLIENT.CODCIDADE = PCCIDADE.CODCIDADE(+)
AND PCPEDC.CODCLI = PCCLIENT.CODCLI(+)
AND PCCLIENT.CODATV1 = PCATIVI.CODATIV(+)
AND PCPEDC.DTCANCEL IS NULL
AND PCPEDI.CODPROD = PCPRODUT.CODPROD(+)
AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO(+)
and nvl(PCCLIENT.Codrede,99) not in (1,2)
AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC(+)
AND PCPEDC.CODUSUR = PCUSUARI.CODUSUR(+)
AND PCPEDC.CODPRACA = PCPRACA.CODPRACA(+)
GROUP BY  
PCPRODUT.CODFORNEC
) VENDAS,
( 
     SELECT PCMETA.CODIGO,
       SUM(NVL(PCMETA.VLVENDAPREV,0)) VLMETA,
       SUM(NVL(PCMETA.CLIPOSPREV,0)) CLIPOSPREV
  FROM PCMETA, PCUSUARI 
         ,PCFORNEC 
WHERE PCMETA.CODUSUR = PCUSUARI.CODUSUR
AND PCUSUARI.CODSUPERVISOR NOT IN ('9999')
         AND PCMETA.TIPOMETA = 'F'
         AND PCFORNEC.CODFORNEC = PCMETA.CODIGO
 AND PCMETA.DATA BETWEEN P_DATA_INI AND P_DATA_FIM
 AND PCMETA.CODFILIAL IN (P_FILIAL)
AND PCUSUARI.CODUSUR IN(P_RCA)
 
GROUP BY PCMETA.CODIGO
) METAS
WHERE 
 PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC(+)
AND PCPRODUT.CODFORNEC = VENDAS.CODFORNEC(+)
AND PCPRODUT.CODFORNEC = METAS.CODIGO(+)
--and PCFORNEC.Codfornec in (1214, 1468, 976, 1360, 2591, 390, 4)
and PCFORNEC.Codfornec in (select p.codfornec from pcfornec p where p.wn_rel8008='S')
AND NVL(METAS.VLMETA,0) +  NVL(METAS.CLIPOSPREV,0) > 0

--AND PCPRODUT.CODFORNEC IN (/* SQL UTILIZADO PELA ROTINA PCSIS322 PARA TODOS RELATORIO(S) */ SELECT CODIGON FROM PCLIB WHERE CODFUNC = 1 AND CODTABELA = 3)
  
ORDER BY NVL(VENDAS.PVENDA,0) DESC
)tab1
where NVL(tab1.VLMETA,0) > 0
;

end if;

if P_OPCAO = 5 then --- RETORNA o % de cob de meta de positivacao vide 322
  select --case when count(*)>0 then sum(perc_pos)/count(*)
         --else 0 end
        sum(perc_pos)/count(*)
       
       into
       V_RETORNO
       from
      (
SELECT DISTINCT 
       PCPRODUT.CODFORNEC, 
       PCFORNEC.FORNECEDOR,
       NVL(VENDAS.PVENDA,0) PVENDA,
       NVL(METAS.VLMETA,0) VLMETA,
       case when NVL(METAS.VLMETA,0)=0 then 0
           else 
       round((NVL(VENDAS.PVENDA,0)/NVL(METAS.VLMETA,0)*100),2) end perc_meta,
       NVL(VENDAS.QTCLIPOS,0) QTCLIPOS,
       NVL(METAS.CLIPOSPREV,0) CLIPOSPREV,
       case when NVL(METAS.CLIPOSPREV,0)=0 then 0 
            else 
       round((NVL(VENDAS.QTCLIPOS,0)/NVL(METAS.CLIPOSPREV,0)*100),2) end perc_pos
FROM PCPRODUT, PCFORNEC,
( 
/* SQL UTILIZADO PELA ROTINA PCSIS322 RELATORIO(S) - 4 */ SELECT 
       PCPRODUT.CODFORNEC, 
       COUNT(DISTINCT(PCPEDC.CODCLI)) QTCLIPOS,
       SUM(ROUND(NVL(PCPEDI.QT,0)*NVL(PCPEDI.PVENDA,0),2)) PVENDA,
       SUM(PCPEDI.QT) QT,
       SUM(ROUND(NVL(PCPRODUT.PESOBRUTO,0)*NVL(PCPEDI.QT,0),2)) AS TOTPESO,
       SUM(NVL(PCPEDI.QT,0) / DECODE(NVL(PCPRODUT.QTUNIT,0),0,1,NVL(PCPRODUT.QTUNIT,1))) TOTQTUNIT,
       SUM(NVL(PCPEDI.QT,0) / DECODE(NVL(PCPRODUT.QTUNITCX,0),0,1,NVL(PCPRODUT.QTUNITCX,1))) TOTQTUNITCX,
       ROUND(SUM(NVL(PCPRODUT.VOLUME,0)*NVL(PCPEDI.QT,0)) ,2) Volume,
       ROUND(SUM(NVL(PCPRODUT.LITRAGEM, 0)*NVL(PCPEDI.QT,0)) ,2) LITRAGEM,
       COUNT(DISTINCT(PCPEDC.NUMPED)) AS QTPEDIDO,
       COUNT(DISTINCT(PCPEDI.CODPROD)) AS QTMIX,
       COUNT(PCPEDI.CODPROD) NUMITENS,
MAX((/* SQL UTILIZADO PELA ROTINA PCSIS322 RELATORIO(S) - 4 */ SELECT COUNT(P.CODPROD) FROM PCPRODUT P,PCDEPTO D WHERE P.CODEPTO = D.CODEPTO
   AND P.CODFORNEC = PCFORNEC.CODFORNEC
   AND NVL(P.OBS2,'  ') <> ('FL'))) AS QTMIXCAD
FROM PCPEDI, PCPEDC, PCPRODUT, PCFORNEC, PCDEPTO, PCCLIENT,
     PCUSUARI, PCATIVI, PCPRACA, PCCIDADE
WHERE PCPEDI.NUMPED = PCPEDC.NUMPED
AND PCUSUARI.CODSUPERVISOR NOT IN ('9999')
AND PCPEDC.DATA BETWEEN P_DATA_INI AND P_DATA_FIM
AND PCPEDC.CODFILIAL IN (P_FILIAL)
  AND PCPEDC.CODUSUR IN (P_RCA)
AND PCPEDC.CONDVENDA IN (1, 2, 3, 7, 9, 14, 15, 17, 18, 19, 98)

--AND PCPRODUT.CODFORNEC IN (/* SQL UTILIZADO PELA ROTINA PCSIS322 PARA TODOS RELATORIO(S) */ SELECT CODIGON FROM PCLIB WHERE CODFUNC = 1 AND CODTABELA = 3)

AND PCCLIENT.CODCIDADE = PCCIDADE.CODCIDADE(+)
AND PCPEDC.CODCLI = PCCLIENT.CODCLI(+)
AND PCCLIENT.CODATV1 = PCATIVI.CODATIV(+)
AND PCPEDC.DTCANCEL IS NULL
AND PCPEDI.CODPROD = PCPRODUT.CODPROD(+)
AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO(+)
AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC(+)
AND PCPEDC.CODUSUR = PCUSUARI.CODUSUR(+)
AND PCPEDC.CODPRACA = PCPRACA.CODPRACA(+)
GROUP BY  
PCPRODUT.CODFORNEC
) VENDAS,
( 
     SELECT PCMETA.CODIGO,
       SUM(NVL(PCMETA.VLVENDAPREV,0)) VLMETA,
       SUM(NVL(PCMETA.CLIPOSPREV,0)) CLIPOSPREV
  FROM PCMETA, PCUSUARI 
         ,PCFORNEC 
WHERE PCMETA.CODUSUR = PCUSUARI.CODUSUR
AND PCUSUARI.CODSUPERVISOR NOT IN ('9999')
         AND PCMETA.TIPOMETA = 'F'
         AND PCFORNEC.CODFORNEC = PCMETA.CODIGO
 AND PCMETA.DATA BETWEEN P_DATA_INI AND P_DATA_FIM
 AND PCMETA.CODFILIAL IN (P_FILIAL)
AND PCUSUARI.CODUSUR IN(P_RCA)
 
GROUP BY PCMETA.CODIGO
) METAS
WHERE 
 PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC(+)
AND PCPRODUT.CODFORNEC = VENDAS.CODFORNEC(+)
AND PCPRODUT.CODFORNEC = METAS.CODIGO(+)
--and PCFORNEC.Codfornec in (1214, 1468, 976, 1360, 2591, 390, 4)
and PCFORNEC.Codfornec in (select p.codfornec from pcfornec p where p.wn_rel8008='S')
AND NVL(METAS.VLMETA,0) +  NVL(METAS.CLIPOSPREV,0) > 0

--AND PCPRODUT.CODFORNEC IN (/* SQL UTILIZADO PELA ROTINA PCSIS322 PARA TODOS RELATORIO(S) */ SELECT CODIGON FROM PCLIB WHERE CODFUNC = 1 AND CODTABELA = 3)
  
ORDER BY NVL(VENDAS.PVENDA,0) DESC
)tab1
where NVL(tab1.VLMETA,0) > 0
;

end if;

if P_OPCAO = 6 then -- RETORNA O % DE COB DE META DE LUCRO DO RCA
  
 begin
  select round((tab2.per_lucro/tab2.margem_padrao)*100,2)
         into 
         V_RETORNO
     from (     
  select    
       (select v.comissaoservicoprestado from pcusuari v where v.codusur=tab.rca) margem_padrao,  
        case when (sum(tab.venda))<= 0 then 0 
                   else round((((sum(tab.venda)-sum(tab.dev))-sum(custofin))/(sum(tab.venda))*100),2)
                end  per_lucro
             from ( 
           
     

        --pedido a faturar tipo 1
       select p.CODUSUR rca, 
       p.CODSUPERVISOR sup, 
       sum(p.PVENDA) venda, 
       
       0 dev ,
       SUM(P.VLCUSTOFIN) custofin ,
       --(sum(p.vlcustofin)-(sum((select sum(pi.qt*nvl(pi.vlverbacmv,0))+sum(pi.qt*nvl(pi.vlrebaixacmv,0))+sum(pi.qt*nvl(pi.vlverbacmvcli,0)) from pcpedi pi where pi.numped=p.numped)))) custofin , 
       0 venda_afat
       from vw_vendaspedido_8022 p
         
                     where  TO_DATE(p.DATA, 'DD-MM-RRRR') between to_date(P_DATA_INI,'dd-mm-rrrr') and to_date(P_DATA_FIM,'dd-mm-rrrr')
                      --and p.DTCANCEL is null
                      and p.CODFILIAL=P_FILIAL
                      and p.CODUSUR in (P_RCA)
                      --and p.CODSUPERVISOR in (:SUP)  
                      --AND P.CONDVENDA IN (1)
                       
                        
                  group by p.CODUSUR, p.CODSUPERVISOR    
  
                      
       
              ) tab
                 group by tab.rca
              ) tab2  ;
  exception 
      when others then
          V_RETORNO:=0; 
        
  end;                  
          

end if;

if P_OPCAO = 7 then -- RETORNA O % DE META DE LUCRO DO RCA
  
 begin
  select tab2.margem_padrao
         into 
         V_RETORNO
     from (     
  select    
       (select v.comissaoservicoprestado from pcusuari v where v.codusur=tab.rca) margem_padrao,  
        case when (sum(tab.venda))<= 0 then 0 
                   else round((((sum(tab.venda)-sum(tab.dev))-sum(custofin))/(sum(tab.venda))*100),2)
                end  per_lucro
             from ( 
           
     

        --pedido a faturar tipo 1
       select p.CODUSUR rca, 
       p.CODSUPERVISOR sup, 
       sum(p.PVENDA) venda, 
       
       0 dev ,
       SUM(P.VLCUSTOFIN) custofin ,
       --(sum(p.vlcustofin)-(sum((select sum(pi.qt*nvl(pi.vlverbacmv,0))+sum(pi.qt*nvl(pi.vlrebaixacmv,0))+sum(pi.qt*nvl(pi.vlverbacmvcli,0)) from pcpedi pi where pi.numped=p.numped)))) custofin , 
       0 venda_afat
       from vw_vendaspedido_8022 p
         
                     where  TO_DATE(p.DATA, 'DD-MM-RRRR') between to_date(P_DATA_INI,'dd-mm-rrrr') and to_date(P_DATA_FIM,'dd-mm-rrrr')
                      --and p.DTCANCEL is null
                      and p.CODFILIAL=P_FILIAL
                      and p.CODUSUR in (P_RCA)
                      --and p.CODSUPERVISOR in (:SUP)  
                      --AND P.CONDVENDA IN (1)
                       
                        
                  group by p.CODUSUR, p.CODSUPERVISOR    
  
                      
       
              ) tab
                 group by tab.rca
              ) tab2  ;
  exception 
      when others then
          V_RETORNO:=0; 
        
  end;                  
          

end if;

if P_OPCAO = 8 then -- RETORNA O % DE LUCRO DO RCA
  
 begin
  select tab2.per_lucro
         into 
         V_RETORNO
     from (     
  select    
       (select v.comissaoservicoprestado from pcusuari v where v.codusur=tab.rca) margem_padrao,  
        case when (sum(tab.venda))<= 0 then 0 
                   else round((((sum(tab.venda)-sum(tab.dev))-sum(custofin))/(sum(tab.venda))*100),2)
                end  per_lucro
             from ( 
           
     

        --pedido a faturar tipo 1
       select p.CODUSUR rca, 
       p.CODSUPERVISOR sup, 
       sum(p.PVENDA) venda, 
       
       0 dev ,
       SUM(P.VLCUSTOFIN) custofin ,
       --(sum(p.vlcustofin)-(sum((select sum(pi.qt*nvl(pi.vlverbacmv,0))+sum(pi.qt*nvl(pi.vlrebaixacmv,0))+sum(pi.qt*nvl(pi.vlverbacmvcli,0)) from pcpedi pi where pi.numped=p.numped)))) custofin , 
       0 venda_afat
       from vw_vendaspedido_8022 p
         
                     where  TO_DATE(p.DATA, 'DD-MM-RRRR') between to_date(P_DATA_INI,'dd-mm-rrrr') and to_date(P_DATA_FIM,'dd-mm-rrrr')
                      --and p.DTCANCEL is null
                      and p.CODFILIAL=P_FILIAL
                      and p.CODUSUR in (P_RCA)
                      and p.CODFORNEC not in (3077, 3083)
                      --and p.CODSUPERVISOR in (:SUP)  
                      --AND P.CONDVENDA IN (1)
                       
                        
                  group by p.CODUSUR, p.CODSUPERVISOR    
  
                      
       
              ) tab
                 group by tab.rca
              ) tab2  ;
  exception 
      when others then
          V_RETORNO:=0; 
        
  end;                  
          

end if;

if P_OPCAO = 9 then -- RETORNA O % DE POS SOBRE A POR PRODUTO
  
begin
   select --case when count(*)>0 then sum(perc_pos)/count(*)
         --else 0 end
        --sum(perc_pos)/count(*)
       max(perc_pos)
      into
       V_RETORNO
       from
      (
SELECT DISTINCT 
       PCPRODUT.CODPROD, 
       PCPRODUT.DESCRICAO,
       NVL(VENDAS.PVENDA,0) PVENDA,
       NVL(METAS.VLMETA,0) VLMETA,
       case when NVL(METAS.VLMETA,0)=0 then 0
           else 
       round((NVL(VENDAS.PVENDA,0)/NVL(METAS.VLMETA,0)*100),2) end perc_meta,
       NVL(VENDAS.QTCLIPOS,0) QTCLIPOS,
       NVL(METAS.CLIPOSPREV,0) CLIPOSPREV,
       case when NVL(METAS.CLIPOSPREV,0)=0 then 0 
            else 
       round((NVL(VENDAS.QTCLIPOS,0)/NVL(METAS.CLIPOSPREV,0)*100),2) end perc_pos
FROM PCPRODUT, PCFORNEC,
( 
/* SQL UTILIZADO PELA ROTINA PCSIS322 RELATORIO(S) - 4 */ SELECT 
       PCPRODUT.Codprod, 
     --  PCPRODUT.Codfornec,
       COUNT(DISTINCT(PCPEDC.CODCLI)) QTCLIPOS,
       SUM(ROUND(NVL(PCPEDI.QT,0)*NVL(PCPEDI.PVENDA,0),2)) PVENDA,
       SUM(PCPEDI.QT) QT,
       SUM(ROUND(NVL(PCPRODUT.PESOBRUTO,0)*NVL(PCPEDI.QT,0),2)) AS TOTPESO,
       SUM(NVL(PCPEDI.QT,0) / DECODE(NVL(PCPRODUT.QTUNIT,0),0,1,NVL(PCPRODUT.QTUNIT,1))) TOTQTUNIT,
       SUM(NVL(PCPEDI.QT,0) / DECODE(NVL(PCPRODUT.QTUNITCX,0),0,1,NVL(PCPRODUT.QTUNITCX,1))) TOTQTUNITCX,
       ROUND(SUM(NVL(PCPRODUT.VOLUME,0)*NVL(PCPEDI.QT,0)) ,2) Volume,
       ROUND(SUM(NVL(PCPRODUT.LITRAGEM, 0)*NVL(PCPEDI.QT,0)) ,2) LITRAGEM,
       COUNT(DISTINCT(PCPEDC.NUMPED)) AS QTPEDIDO,
       COUNT(DISTINCT(PCPEDI.CODPROD)) AS QTMIX,
       COUNT(PCPEDI.CODPROD) NUMITENS,
MAX((/* SQL UTILIZADO PELA ROTINA PCSIS322 RELATORIO(S) - 4 */ SELECT COUNT(P.CODPROD) FROM PCPRODUT P,PCDEPTO D WHERE P.CODEPTO = D.CODEPTO
   AND P.CODFORNEC = PCFORNEC.CODFORNEC
   AND NVL(P.OBS2,'  ') <> ('FL'))) AS QTMIXCAD
FROM PCPEDI, PCPEDC, PCPRODUT, PCFORNEC, PCDEPTO, PCCLIENT,
     PCUSUARI, PCATIVI, PCPRACA, PCCIDADE
WHERE PCPEDI.NUMPED = PCPEDC.NUMPED
AND PCUSUARI.CODSUPERVISOR NOT IN ('9999')
AND PCPEDC.DATA BETWEEN P_DATA_INI AND P_DATA_FIM
AND PCPEDC.CODFILIAL IN (P_FILIAL)
  AND PCPEDC.CODUSUR IN (P_RCA)
AND PCPEDC.CONDVENDA IN (1, 2, 3, 7, 9, 14, 15, 17, 18, 19, 98)

--AND PCPRODUT.CODFORNEC IN (/* SQL UTILIZADO PELA ROTINA PCSIS322 PARA TODOS RELATORIO(S) */ SELECT CODIGON FROM PCLIB WHERE CODFUNC = 1 AND CODTABELA = 3)

AND PCCLIENT.CODCIDADE = PCCIDADE.CODCIDADE(+)
AND PCPEDC.CODCLI = PCCLIENT.CODCLI(+)
AND PCCLIENT.CODATV1 = PCATIVI.CODATIV(+)
AND PCPEDC.DTCANCEL IS NULL
AND PCPEDI.CODPROD = PCPRODUT.CODPROD(+)
AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO(+)
AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC(+)
AND PCPEDC.CODUSUR = PCUSUARI.CODUSUR(+)
AND PCPEDC.CODPRACA = PCPRACA.CODPRACA(+)
and  exists (select * from pcmeta m where 1=1 and m.codusur=P_RCA AND m.codigo=pcprodut.codprod and m.tipometa='P' and m.data between P_DATA_INI AND P_DATA_FIM and m.cliposprev>0)
GROUP BY  
PCPRODUT.Codprod--, PCPRODUT.Codfornec
) VENDAS,
( 
     SELECT PCMETA.CODIGO,
       SUM(NVL(PCMETA.VLVENDAPREV,0)) VLMETA,
       avg(NVL(PCMETA.CLIPOSPREV,0)) CLIPOSPREV
  FROM PCMETA, PCUSUARI 
         ,Pcprodut 
WHERE PCMETA.CODUSUR = PCUSUARI.CODUSUR
--AND PCUSUARI.CODSUPERVISOR NOT IN ('9999')
         AND PCMETA.TIPOMETA = 'P'
         AND Pcprodut.Codprod = PCMETA.CODIGO
 AND PCMETA.DATA BETWEEN P_DATA_INI AND P_DATA_FIM
 AND PCMETA.CODFILIAL IN (P_FILIAL)
AND PCUSUARI.CODUSUR IN(P_RCA)
and pcmeta.cliposprev>0
 
GROUP BY PCMETA.CODIGO
) METAS
WHERE 1=1 
and    PCPRODUT.Codprod = VENDAS.codprod(+)
AND PCPRODUT.Codprod = METAS.CODIGO(+)
AND NVL(METAS.VLMETA,0) +  NVL(METAS.CLIPOSPREV,0) > 0

  
ORDER BY NVL(VENDAS.PVENDA,0) DESC
)tab1;

  exception 
      when others then
          V_RETORNO:=0; 
        
  end;                                  
          

end if;

if P_OPCAO = 10 then -- RETORNA O % DE qtde SOBRE A POR PRODUTO
  
begin
  select --case when count(*)>0 then sum(perc_pos)/count(*)
         --else 0 end
        --sum(perc_meta)/count(*)
       max(perc_meta)
      into
       V_RETORNO
       from
      (
SELECT DISTINCT 
       PCPRODUT.CODPROD, 
       PCPRODUT.DESCRICAO,
       NVL(VENDAS.PVENDA,0) PVENDA,
       NVL(METAS.VLMETA,0) VLMETA,
       case when NVL(METAS.VLMETA,0)=0 then 0
           else 
       round((NVL(VENDAS.QT,0)/NVL(METAS.VLMETA,0)*100),2) end perc_meta,
       NVL(VENDAS.QTCLIPOS,0) QTCLIPOS,
       NVL(METAS.CLIPOSPREV,0) CLIPOSPREV,
       case when NVL(METAS.CLIPOSPREV,0)=0 then 0 
            else 
       round((NVL(VENDAS.QTCLIPOS,0)/NVL(METAS.CLIPOSPREV,0)*100),2) end perc_pos
FROM PCPRODUT, PCFORNEC,
( 
/* SQL UTILIZADO PELA ROTINA PCSIS322 RELATORIO(S) - 4 */ SELECT 
       PCPRODUT.Codprod, 
     --  PCPRODUT.Codfornec,
       COUNT(DISTINCT(PCPEDC.CODCLI)) QTCLIPOS,
       SUM(ROUND(NVL(PCPEDI.QT,0)*NVL(PCPEDI.PVENDA,0),2)) PVENDA,
       SUM(PCPEDI.QT) QT,
       SUM(ROUND(NVL(PCPRODUT.PESOBRUTO,0)*NVL(PCPEDI.QT,0),2)) AS TOTPESO,
       SUM(NVL(PCPEDI.QT,0) / DECODE(NVL(PCPRODUT.QTUNIT,0),0,1,NVL(PCPRODUT.QTUNIT,1))) TOTQTUNIT,
       SUM(NVL(PCPEDI.QT,0) / DECODE(NVL(PCPRODUT.QTUNITCX,0),0,1,NVL(PCPRODUT.QTUNITCX,1))) TOTQTUNITCX,
       ROUND(SUM(NVL(PCPRODUT.VOLUME,0)*NVL(PCPEDI.QT,0)) ,2) Volume,
       ROUND(SUM(NVL(PCPRODUT.LITRAGEM, 0)*NVL(PCPEDI.QT,0)) ,2) LITRAGEM,
       COUNT(DISTINCT(PCPEDC.NUMPED)) AS QTPEDIDO,
       COUNT(DISTINCT(PCPEDI.CODPROD)) AS QTMIX,
       COUNT(PCPEDI.CODPROD) NUMITENS,
MAX((/* SQL UTILIZADO PELA ROTINA PCSIS322 RELATORIO(S) - 4 */ SELECT COUNT(P.CODPROD) FROM PCPRODUT P,PCDEPTO D WHERE P.CODEPTO = D.CODEPTO
   AND P.CODFORNEC = PCFORNEC.CODFORNEC
   AND NVL(P.OBS2,'  ') <> ('FL'))) AS QTMIXCAD
FROM PCPEDI, PCPEDC, PCPRODUT, PCFORNEC, PCDEPTO, PCCLIENT,
     PCUSUARI, PCATIVI, PCPRACA, PCCIDADE
WHERE PCPEDI.NUMPED = PCPEDC.NUMPED
AND PCUSUARI.CODSUPERVISOR NOT IN ('9999')
AND PCPEDC.DATA BETWEEN P_DATA_INI AND P_DATA_FIM
AND PCPEDC.CODFILIAL IN (P_FILIAL)
  AND PCPEDC.CODUSUR IN (P_RCA)
AND PCPEDC.CONDVENDA IN (1, 2, 3, 7, 9, 14, 15, 17, 18, 19, 98)

--AND PCPRODUT.CODFORNEC IN (/* SQL UTILIZADO PELA ROTINA PCSIS322 PARA TODOS RELATORIO(S) */ SELECT CODIGON FROM PCLIB WHERE CODFUNC = 1 AND CODTABELA = 3)

AND PCCLIENT.CODCIDADE = PCCIDADE.CODCIDADE(+)
AND PCPEDC.CODCLI = PCCLIENT.CODCLI(+)
AND PCCLIENT.CODATV1 = PCATIVI.CODATIV(+)
AND PCPEDC.DTCANCEL IS NULL
AND PCPEDI.CODPROD = PCPRODUT.CODPROD(+)
AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO(+)
AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC(+)
AND PCPEDC.CODUSUR = PCUSUARI.CODUSUR(+)
AND PCPEDC.CODPRACA = PCPRACA.CODPRACA(+)
and  exists (select * from pcmeta m where 1=1 and m.codusur=P_RCA AND m.codigo=pcprodut.codprod and m.tipometa='P' and m.data between P_DATA_INI AND P_DATA_FIM and m.cliposprev>0)
GROUP BY  
PCPRODUT.Codprod--, PCPRODUT.Codfornec
) VENDAS,
( 
     SELECT PCMETA.CODIGO,
       SUM(NVL(PCMETA.Qtvendaprev,0)) VLMETA,
       SUM(NVL(PCMETA.CLIPOSPREV,0)) CLIPOSPREV
  FROM PCMETA, PCUSUARI 
         ,Pcprodut 
WHERE PCMETA.CODUSUR = PCUSUARI.CODUSUR
--AND PCUSUARI.CODSUPERVISOR NOT IN ('9999')
         AND PCMETA.TIPOMETA = 'P'
         AND Pcprodut.Codprod = PCMETA.CODIGO
 AND PCMETA.DATA BETWEEN P_DATA_INI AND P_DATA_FIM
 AND PCMETA.CODFILIAL IN (P_FILIAL)
AND PCUSUARI.CODUSUR IN(P_RCA)
and pcmeta.cliposprev>0
 
GROUP BY PCMETA.CODIGO
) METAS
WHERE 1=1 
and    PCPRODUT.Codprod = VENDAS.codprod(+)
AND PCPRODUT.Codprod = METAS.CODIGO(+)
AND NVL(METAS.VLMETA,0) +  NVL(METAS.CLIPOSPREV,0) > 0

  
ORDER BY NVL(VENDAS.PVENDA,0) DESC
)tab1;

 exception 
      when others then
          V_RETORNO:=0; 
        
  end;                                  
          

end if;

if P_OPCAO = 11 then -- RETORNA p valor de comissão DE qtde SOBRE A meta POR PRODUTO um por um 

select count(*)
       into
       v_qtde_meta_prod
     from pcmeta m 
         where 1=1 
         and m.codusur=P_RCA 
         and m.tipometa='P' 
         and m.data between P_DATA_INI AND P_DATA_FIM 
         and m.cliposprev>0; 
         
   
if v_qtde_meta_prod>0 then    
    V_FRACAO_META:=round(P_VLR_COM/v_qtde_meta_prod,2) ;     

--else

for c in (
     select * from pcmeta m where 1=1 and m.codusur=P_RCA and m.tipometa='P' and m.data between P_DATA_INI AND P_DATA_FIM and m.cliposprev>0 --and m.codigo=109698
        )
loop        
begin
  select --case when count(*)>0 then sum(perc_pos)/count(*)
         --else 0 end
        --sum(perc_meta)/count(*)
       max(perc_meta)
      into
       v_perc_meta_prod
       from
      (
SELECT DISTINCT 
       PCPRODUT.CODPROD, 
       PCPRODUT.DESCRICAO,
       NVL(VENDAS.PVENDA,0) PVENDA,
       NVL(METAS.VLMETA,0) VLMETA,
       case when NVL(METAS.VLMETA,0)=0 then 0
           else 
       round((NVL(VENDAS.QT,0)/NVL(METAS.VLMETA,0)*100),2) end perc_meta,
       NVL(VENDAS.QTCLIPOS,0) QTCLIPOS,
       NVL(METAS.CLIPOSPREV,0) CLIPOSPREV,
       case when NVL(METAS.CLIPOSPREV,0)=0 then 0 
            else 
       round((NVL(VENDAS.QTCLIPOS,0)/NVL(METAS.CLIPOSPREV,0)*100),2) end perc_pos
FROM PCPRODUT, PCFORNEC,
( 
/* SQL UTILIZADO PELA ROTINA PCSIS322 RELATORIO(S) - 4 */ SELECT 
       PCPRODUT.Codprod, 
     --  PCPRODUT.Codfornec,
       COUNT(DISTINCT(PCPEDC.CODCLI)) QTCLIPOS,
       SUM(ROUND(NVL(PCPEDI.QT,0)*NVL(PCPEDI.PVENDA,0),2)) PVENDA,
       SUM(PCPEDI.QT) QT,
       SUM(ROUND(NVL(PCPRODUT.PESOBRUTO,0)*NVL(PCPEDI.QT,0),2)) AS TOTPESO,
       SUM(NVL(PCPEDI.QT,0) / DECODE(NVL(PCPRODUT.QTUNIT,0),0,1,NVL(PCPRODUT.QTUNIT,1))) TOTQTUNIT,
       SUM(NVL(PCPEDI.QT,0) / DECODE(NVL(PCPRODUT.QTUNITCX,0),0,1,NVL(PCPRODUT.QTUNITCX,1))) TOTQTUNITCX,
       ROUND(SUM(NVL(PCPRODUT.VOLUME,0)*NVL(PCPEDI.QT,0)) ,2) Volume,
       ROUND(SUM(NVL(PCPRODUT.LITRAGEM, 0)*NVL(PCPEDI.QT,0)) ,2) LITRAGEM,
       COUNT(DISTINCT(PCPEDC.NUMPED)) AS QTPEDIDO,
       COUNT(DISTINCT(PCPEDI.CODPROD)) AS QTMIX,
       COUNT(PCPEDI.CODPROD) NUMITENS,
MAX((/* SQL UTILIZADO PELA ROTINA PCSIS322 RELATORIO(S) - 4 */ SELECT COUNT(P.CODPROD) FROM PCPRODUT P,PCDEPTO D WHERE P.CODEPTO = D.CODEPTO
   AND P.CODFORNEC = PCFORNEC.CODFORNEC
   AND NVL(P.OBS2,'  ') <> ('FL'))) AS QTMIXCAD
FROM PCPEDI, PCPEDC, PCPRODUT, PCFORNEC, PCDEPTO, PCCLIENT,
     PCUSUARI, PCATIVI, PCPRACA, PCCIDADE
WHERE PCPEDI.NUMPED = PCPEDC.NUMPED
AND PCUSUARI.CODSUPERVISOR NOT IN ('9999')
AND PCPEDC.DATA BETWEEN P_DATA_INI AND P_DATA_FIM
AND PCPEDC.CODFILIAL IN (P_FILIAL)
  AND PCPEDC.CODUSUR IN (P_RCA)
AND PCPEDC.CONDVENDA IN (1, 2, 3, 7, 9, 14, 15, 17, 18, 19, 98)

--AND PCPRODUT.CODFORNEC IN (/* SQL UTILIZADO PELA ROTINA PCSIS322 PARA TODOS RELATORIO(S) */ SELECT CODIGON FROM PCLIB WHERE CODFUNC = 1 AND CODTABELA = 3)

AND PCCLIENT.CODCIDADE = PCCIDADE.CODCIDADE(+)
AND PCPEDC.CODCLI = PCCLIENT.CODCLI(+)
AND PCCLIENT.CODATV1 = PCATIVI.CODATIV(+)
AND PCPEDC.DTCANCEL IS NULL
AND PCPEDI.CODPROD = PCPRODUT.CODPROD(+)
AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO(+)
AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC(+)
AND PCPEDC.CODUSUR = PCUSUARI.CODUSUR(+)
AND PCPEDC.CODPRACA = PCPRACA.CODPRACA(+)
and pcprodut.codprod=c.codigo --exists (select * from pcmeta m where 1=1 and m.codusur=P_RCA AND m.codigo=pcprodut.codprod and m.tipometa='P' and m.data between P_DATA_INI AND P_DATA_FIM and m.cliposprev>0)
GROUP BY  
PCPRODUT.Codprod--, PCPRODUT.Codfornec
) VENDAS,
( 
     SELECT PCMETA.CODIGO,
       SUM(NVL(PCMETA.Qtvendaprev,0)) VLMETA,
       SUM(NVL(PCMETA.CLIPOSPREV,0)) CLIPOSPREV
  FROM PCMETA, PCUSUARI 
         ,Pcprodut 
WHERE PCMETA.CODUSUR = PCUSUARI.CODUSUR
--AND PCUSUARI.CODSUPERVISOR NOT IN ('9999')
         AND PCMETA.TIPOMETA = 'P'
         AND Pcprodut.Codprod = PCMETA.CODIGO
 AND PCMETA.DATA BETWEEN P_DATA_INI AND P_DATA_FIM
 AND PCMETA.CODFILIAL IN (P_FILIAL)
AND PCUSUARI.CODUSUR IN(P_RCA)
and pcmeta.cliposprev>0
and pcmeta.codigo=c.codigo
 
GROUP BY PCMETA.CODIGO
) METAS
WHERE 1=1 
and    PCPRODUT.Codprod = VENDAS.codprod(+)
AND PCPRODUT.Codprod = METAS.CODIGO(+)
AND NVL(METAS.VLMETA,0) +  NVL(METAS.CLIPOSPREV,0) > 0

  
ORDER BY NVL(VENDAS.PVENDA,0) DESC
)tab1;

 exception 
      when others then
          V_RETORNO:=0; 
        
  end;                                  
     
  if v_perc_meta_prod>= P_PERC_MIN  and v_perc_meta_prod<= P_PERC_MAX then
       v_tot_prem_meta_prod:=v_tot_prem_meta_prod+((V_FRACAO_META)*(v_perc_meta_prod/100)); 
  elsif v_perc_meta_prod>P_PERC_MAX then
        v_tot_prem_meta_prod:=v_tot_prem_meta_prod+((V_FRACAO_META)*(P_PERC_MAX/100)); 
  else 
         v_tot_prem_meta_prod:= v_tot_prem_meta_prod+0; 
       
   end if; 
end loop;

end if;
   V_RETORNO:=v_tot_prem_meta_prod;
end if;

if P_OPCAO = 12 then -- RETORNA p valor de comissão DE pos SOBRE A meta POR PRODUTO um por um 

select count(*)
       into
       v_qtde_meta_prod
     from pcmeta m 
         where 1=1 
         and m.codusur=P_RCA 
         and m.tipometa='P' 
         and m.data between P_DATA_INI AND P_DATA_FIM 
         and m.cliposprev>0; 
         
   
if v_qtde_meta_prod>0 then    
    V_FRACAO_META:=round(P_VLR_COM/v_qtde_meta_prod,2) ;     

--else

for c in (
     select * from pcmeta m where 1=1 and m.codusur=P_RCA and m.tipometa='P' and m.data between P_DATA_INI AND P_DATA_FIM and m.cliposprev>0 --and m.codigo=109698
        )
loop        
begin
  select --case when count(*)>0 then sum(perc_pos)/count(*)
         --else 0 end
        --sum(perc_meta)/count(*)
       max(perc_pos)
      into
       v_perc_meta_prod
       from
      (
SELECT DISTINCT 
       PCPRODUT.CODPROD, 
       PCPRODUT.DESCRICAO,
       NVL(VENDAS.PVENDA,0) PVENDA,
       NVL(METAS.VLMETA,0) VLMETA,
       case when NVL(METAS.VLMETA,0)=0 then 0
           else 
       round((NVL(VENDAS.QT,0)/NVL(METAS.VLMETA,0)*100),2) end perc_meta,
       NVL(VENDAS.QTCLIPOS,0) QTCLIPOS,
       NVL(METAS.CLIPOSPREV,0) CLIPOSPREV,
       case when NVL(METAS.CLIPOSPREV,0)=0 then 0 
            else 
       round((NVL(VENDAS.QTCLIPOS,0)/NVL(METAS.CLIPOSPREV,0)*100),2) end perc_pos
FROM PCPRODUT, PCFORNEC,
( 
/* SQL UTILIZADO PELA ROTINA PCSIS322 RELATORIO(S) - 4 */ SELECT 
       PCPRODUT.Codprod, 
     --  PCPRODUT.Codfornec,
       COUNT(DISTINCT(PCPEDC.CODCLI)) QTCLIPOS,
       SUM(ROUND(NVL(PCPEDI.QT,0)*NVL(PCPEDI.PVENDA,0),2)) PVENDA,
       SUM(PCPEDI.QT) QT,
       SUM(ROUND(NVL(PCPRODUT.PESOBRUTO,0)*NVL(PCPEDI.QT,0),2)) AS TOTPESO,
       SUM(NVL(PCPEDI.QT,0) / DECODE(NVL(PCPRODUT.QTUNIT,0),0,1,NVL(PCPRODUT.QTUNIT,1))) TOTQTUNIT,
       SUM(NVL(PCPEDI.QT,0) / DECODE(NVL(PCPRODUT.QTUNITCX,0),0,1,NVL(PCPRODUT.QTUNITCX,1))) TOTQTUNITCX,
       ROUND(SUM(NVL(PCPRODUT.VOLUME,0)*NVL(PCPEDI.QT,0)) ,2) Volume,
       ROUND(SUM(NVL(PCPRODUT.LITRAGEM, 0)*NVL(PCPEDI.QT,0)) ,2) LITRAGEM,
       COUNT(DISTINCT(PCPEDC.NUMPED)) AS QTPEDIDO,
       COUNT(DISTINCT(PCPEDI.CODPROD)) AS QTMIX,
       COUNT(PCPEDI.CODPROD) NUMITENS,
MAX((/* SQL UTILIZADO PELA ROTINA PCSIS322 RELATORIO(S) - 4 */ SELECT COUNT(P.CODPROD) FROM PCPRODUT P,PCDEPTO D WHERE P.CODEPTO = D.CODEPTO
   AND P.CODFORNEC = PCFORNEC.CODFORNEC
   AND NVL(P.OBS2,'  ') <> ('FL'))) AS QTMIXCAD
FROM PCPEDI, PCPEDC, PCPRODUT, PCFORNEC, PCDEPTO, PCCLIENT,
     PCUSUARI, PCATIVI, PCPRACA, PCCIDADE
WHERE PCPEDI.NUMPED = PCPEDC.NUMPED
AND PCUSUARI.CODSUPERVISOR NOT IN ('9999')
AND PCPEDC.DATA BETWEEN P_DATA_INI AND P_DATA_FIM
AND PCPEDC.CODFILIAL IN (P_FILIAL)
  AND PCPEDC.CODUSUR IN (P_RCA)
AND PCPEDC.CONDVENDA IN (1, 2, 3, 7, 9, 14, 15, 17, 18, 19, 98)

--AND PCPRODUT.CODFORNEC IN (/* SQL UTILIZADO PELA ROTINA PCSIS322 PARA TODOS RELATORIO(S) */ SELECT CODIGON FROM PCLIB WHERE CODFUNC = 1 AND CODTABELA = 3)

AND PCCLIENT.CODCIDADE = PCCIDADE.CODCIDADE(+)
AND PCPEDC.CODCLI = PCCLIENT.CODCLI(+)
AND PCCLIENT.CODATV1 = PCATIVI.CODATIV(+)
AND PCPEDC.DTCANCEL IS NULL
AND PCPEDI.CODPROD = PCPRODUT.CODPROD(+)
AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO(+)
AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC(+)
AND PCPEDC.CODUSUR = PCUSUARI.CODUSUR(+)
AND PCPEDC.CODPRACA = PCPRACA.CODPRACA(+)
and pcprodut.codprod=c.codigo --exists (select * from pcmeta m where 1=1 and m.codusur=P_RCA AND m.codigo=pcprodut.codprod and m.tipometa='P' and m.data between P_DATA_INI AND P_DATA_FIM and m.cliposprev>0)
GROUP BY  
PCPRODUT.Codprod--, PCPRODUT.Codfornec
) VENDAS,
( 
     SELECT PCMETA.CODIGO,
       SUM(NVL(PCMETA.Qtvendaprev,0)) VLMETA,
       SUM(NVL(PCMETA.CLIPOSPREV,0)) CLIPOSPREV
  FROM PCMETA, PCUSUARI 
         ,Pcprodut 
WHERE PCMETA.CODUSUR = PCUSUARI.CODUSUR
--AND PCUSUARI.CODSUPERVISOR NOT IN ('9999')
         AND PCMETA.TIPOMETA = 'P'
         AND Pcprodut.Codprod = PCMETA.CODIGO
 AND PCMETA.DATA BETWEEN P_DATA_INI AND P_DATA_FIM
 AND PCMETA.CODFILIAL IN (P_FILIAL)
AND PCUSUARI.CODUSUR IN(P_RCA)
and pcmeta.cliposprev>0
and pcmeta.codigo=c.codigo
 
GROUP BY PCMETA.CODIGO
) METAS
WHERE 1=1 
and    PCPRODUT.Codprod = VENDAS.codprod(+)
AND PCPRODUT.Codprod = METAS.CODIGO(+)
AND NVL(METAS.VLMETA,0) +  NVL(METAS.CLIPOSPREV,0) > 0

  
ORDER BY NVL(VENDAS.PVENDA,0) DESC
)tab1;

 exception 
      when others then
          V_RETORNO:=0; 
        
  end;                                  
     
  if v_perc_meta_prod>= P_PERC_MIN  and v_perc_meta_prod<= P_PERC_MAX then
       v_tot_prem_meta_prod:=v_tot_prem_meta_prod+((V_FRACAO_META)*(v_perc_meta_prod/100)); 
  elsif v_perc_meta_prod>P_PERC_MAX then
        v_tot_prem_meta_prod:=v_tot_prem_meta_prod+((V_FRACAO_META)*(P_PERC_MAX/100)); 
  else 
         v_tot_prem_meta_prod:= v_tot_prem_meta_prod+0; 
       
   end if; 
end loop;

end if;
   V_RETORNO:=v_tot_prem_meta_prod;
end if;

return  V_RETORNO;

end;
