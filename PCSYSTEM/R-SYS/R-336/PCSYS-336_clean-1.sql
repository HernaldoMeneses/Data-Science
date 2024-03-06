
SELECT 0 as SELECIONADO, PCPEDC.AGRUPAMENTO, PCPEDC.NUMPED, PCPEDC.DATA, PCPEDC.HORA, PCPEDC.VLBONIFIC,                               
       PCPEDC.RESERVAESTOQUETV7,                                                                                                      
       NVL(PCCLIENT.ORIGEMPRECO, 'F') OrigemPreco_client, PCPEDC.CONTAORDEM, PCPEDC.CODCLITV8,                                      
       PCPEDC.DTLIMITEFAT, PCPEDC.ALTAPOSMAPASEP, PCPEDC.VLENTRADA, PCPLPAG.DESCENTLIMCREDCLI,                                        
       PCPEDC.FRETEREDESPACHO,                                                                                                        
       PCPEDC.MINUTO, PCPEDC.CODCLI, PCPEDC.cfopbnfdegusta,                                                                           
       FERRAMENTAS.VERIFICAR_FJ(PCPEDC.CODCLI) AS TIPO_PESSOA,                                                                        
       PCCLIENT.CLIENTE, PCPEDC.POSICAO, PCPEDC.CONDVENDA,                                                                            
       (SELECT PEDTV8.NUMPED                                                                                                          
          FROM PCPEDC PEDTV8                                                                                                          
         WHERE PEDTV8.NUMPEDENTFUT = PCPEDC.NUMPED AND ROWNUM = 1) PEDIDOTV8,                                                         
       PCPEDC.NUMITENS, PCPEDC.VLATEND, PCCLIENT.CODUSUR1,                                                                            
       PCPEDC.CODFILIAL, PCPEDC.CODUSUR, NVL(PCPEDC.ORIGEMPED, 'T') ORIGEMPED,                                                      
       PCPEDC.VLTOTAL, PCPEDC.VLTABELA, PCPEDC.VLCUSTOREAL,                                                                           
       PCPEDC.VLCUSTOFIN, PCPEDC.PRAZOMEDIO, PCCLIENT.CALCULAST,                                                                      
       PCPEDC.TOTPESO, PCPEDC.TOTVOLUME, PCPEDC.NUMITENS,                                                                             
       PCPEDC.VLATEND, PCPEDC.DTLIBERA, PCPEDC.DTENTREGA,                                                                             
       PCPEDC.OBSENTREGA1, PCPEDC.OBSENTREGA2, PCPEDC.OBSENTREGA3,                                                                    
       PCCOB_PED.CODCOB, PCCLIENT.BLOQUEIO, PCPLPAG.CODPLPAG, PCPLPAG.DESCRICAO,                                                      
       PCCLIENT.CODPLPAG CODPLPAG_CLI,                                                                                                
       PCPEDC.codfuncsep, pcpedc.dtinicialsep,                                                                                        
       PCPEDC.dtfinalsep, nvl(pcpedc.tipocontacorrente, 'R') tipocontacorrente,                                                     
       PCPLPAG_CLI.DESCRICAO DESCRICAO_CLI,                                                                                           
       PCPLPAG_CLI.NUMDIAS NUMDIAS_CLI,                                                                                               
       VLDESCABATIMENTO,                                                                                                              
       PCPEDC.CONDFINANC,                                                                                                             
       PCPEDC.PLANOSUPPLI,                                                                                                            
       NUMREGEXP,                                                                                                                     
       NUMCHAVEEXP,                                                                                                                   
       NUMDRAWBACK,                                                                                                                   
       NVL(PCPEDC.CODMOEDAESTRANGEIRA,0) CODMOEDAESTRANGEIRA,                                                                         
       PCPEDC.ROTINALANC, PCPEDC.ROTINALANCULTALT,                                                                                    
       PCPEDC.OBS, PCPEDC.OBS1, PCCLIENT.PERDESC PERDESC_CLI, PCCOB.NIVELVENDA, NVL(PCCOB_PED.CARTAO, 'N') CARTAO,                  
       PCPEDC.PERDESC,                                                                                                                
       PCCOB.CODCOB AS COBCLI, PCREGIAO.PERFRETE, PCPLPAG.NUMPR, PCCOB_PED.BOLETO,                                                    
       PCCLIENT.TIPOFJ, PCCLIENT.IEENT, PCCLIENT.CGCENT, PCUSUARI.TIPOVEND,                                                           
       PCCLIENT.EMITEDUP, PCPEDC.NUMCAR, NVL(PCPEDC.NUMREGIAO,PCPRACA.NUMREGIAO) NUMREGIAO,                                           
       PCPLPAG.PERTXFIM,PCPRACA.PRACA, PCPLPAG.VENDABK,                                                                               
       PCPEDC.PRAZO1, PCPEDC.PRAZO2, PCPEDC.PRAZO3,                                                                                   
       PCPEDC.PRAZO4, PCPEDC.PRAZO5, PCPEDC.PRAZO6,                                                                                   
       PCPEDC.PRAZO7, PCPEDC.PRAZO8, PCPEDC.PRAZO9,                                                                                   
       PCPEDC.PRAZO10, PCPEDC.PRAZO11, PCPEDC.PRAZO12,                                                                                
       PCPEDC.NUMNOTAMANIF, PCPEDC.SERIEMANIF, PCPEDC.ESPECIEMANIF,                                                                   
       PCPEDC.PERCVENDA, PCPEDC.CODFUNCLIBERA, PCPEDC.DTIMPORTACAO,                                                                   
       NVL(PCPEDC.VLOUTRASDESP, 0) VLOUTRASDESP, NVL(PCPEDC.VLFRETE, 0) VLFRETE, NVL(PCPEDC.VLDESCONTO,0) VLDESCONTO,                 
       NVL(PCCLIENT.TIPOCUSTOTRANSF, NVL(PCCONSUM.TIPOCUSTOTRANSF,'E')) TIPOCUSTOTRANSF,                                            
       PCCLIENT.PERACRESTRANSF, PCPEDC.CODEMITENTE,                                                                                   
       PCPEDC.VLCUSTOREP, PCPEDC.VLCUSTOCONT,                                                                                         
       PCPEDC.CODSUPERVISOR, PCPEDC.CODPRACA,NVL(PCPEDC.BLOQUEIOEDICAO,'N') BLOQUEIOEDICAO,                                         
       PCCLIENT.OBS OBS_CLI, PCCLIENT.OBS2 OBS2_CLI, PCCLIENT.OBS3 OBS3_CLI,                                                          
       PCCLIENT.ESTENT, PCPEDC.CODFILIALNF,                                                                                           
       NVL(PCPEDC.NUMVIASMAPASEP,0) NUMVIASMAPASEP,                                                                                   
       DECODE(PCPEDC.NUMCAR, 0, 0,                                                                                                    
              NVL((SELECT PCCARREG.NUMVIASMAPA FROM PCCARREG WHERE PCCARREG.NUMCAR = PCPEDC.NUMCAR), 0)) NUMVIASMAPA,                 
       NVL(PCPEDC.CODFUNCCONF,0) CODFUNCCONF, PCATIVI.PERCDESC PERDESCATIV,                                                           
       PCPEDC.NUMPEDENTFUT, PCCLIENT.SULFRAMA,                                                                                        
       PCPEDC.HORALIBERA, PCPEDC.MINUTOLIBERA,                                                                                        
       PCPEDC.CODFORNECREDESPACHO,                                                                                                    
       PCCLIENT.CODCLIPRINC, PCPEDC.OBS2,                                                                                             
       NVL(PCCLIENT.ISENTOIPI,'N') ISENTOIPI,                                                                                       
       NVL(PCCLIENT.CLIENTEFONTEST,'N') CLIENTEFONTEST,                                                                             
       NVL(PCCLIENT.ISENTOICMS,'N') ISENTOICMS,                                                                                     
       NVL(PCCLIENT.CONSUMIDORFINAL,'N') CONSUMIDORFINAL,                                                                           
       NVL(PCCLIENT.UTILIZAIESIMPLIFICADA,'N') UTILIZAIESIMPLIFICADA,                                                               
       PCCLIENT.TIPOEMPRESA, PCREGIAO.PERFRETEESPECIAL, PCREGIAO.PERFRETETERCEIROS,                                                   
       PCPEDC.TIPOCARGA, PCPLPAG.MARGEMMIN,                                                                                           
       PCPLPAG.TIPOVENDA,                                                                                                             
       PCFILIAL.percacrescimobalcao percacrescimobalcao_FILIAL,                                                                       
       PCPEDC.DTWMS, PCPEDC.CODDISTRIB                                                                                                
               , 0 vlipi                                                                                                              
               , 0 st                                                                                                                 
               , ( SELECT SUM ( ROUND ( NVL ( pcpedi.qt, 0 )                                                                          
                                * NVL ( pcpedi.vlipi, 0 ),2))                                                                         
                    FROM pcpedi                                                                                                       
                   WHERE pcpedi.numped = pcpedc.numped ) tot_vlipi                                                                    
               , ( SELECT SUM ( ROUND(  NVL ( pcpedi.qt, 0 )                                                                          
                                * NVL ( pcpedi.st, 0 ),2))                                                                            
                    FROM pcpedi                                                                                                       
                   WHERE pcpedi.numped = pcpedc.numped ) tot_vlst                                                                     
               , 0 stclientegnre                                                                                                      
               , ( SELECT SUM ( DECODE ( :abaterimpostoscomissaorca                                                                   
                     ,'N', (ROUND((pcpedi.qt * pcpedi.pvenda )                                                                      
                            * (NVL(pcpedi.percom, 0)                                                                                  
                                / 100 ),2))                                                                                           
                     , (ROUND((pcpedi.qt * (pcpedi.pvenda                                                                             
                               - (DECODE(FERRAMENTAS.F_BUSCARPARAMETRO_ALFA('IMPOSTOCOMISSAORCA',pcpedc.codfilial,'A'),           
                                 'A', (NVL(pcpedi.st,0) + NVL(pcpedi.vlipi,0) + NVL(pcpedi.stclientegnre,0) + NVL(pcpedi.vliss,
0)), 
                                 'I', (NVL(pcpedi.vlipi,0) + NVL(pcpedi.vliss,0)),                                                  
                                 'S', (NVL(pcpedi.st,0) + NVL(pcpedi.stclientegnre,0) + NVL(pcpedi.vliss,0)),                       
                                 0)                                                                                                   
                                 )                                                                                                    
                               )                                                                                                      
                           )                                                                                                          
                         * (   NVL ( pcpedi.percom, 0 )                                                                               
                             / 100 ),2)                                                                                               
                       )                                                                                                              
                    ))                                                                                                                
               FROM pcpedi                                                                                                            
               WHERE pcpedi.numped = pcpedc.numped ) valor_comissao,                                                                  
       0 AS LIMCRED,                                                                                                                  
       0 AS VLRECEBER,                                                                                                                
       (SELECT SUM(NVL(VALOR,0))                            
          FROM PCPREST                                      
         WHERE DTPAG IS NULL                                
           AND DTVENC < TRUNC(SYSDATE)                      
           AND CODCLI = PCCLIENT.CODCLI) VLRECEBER_VENCIDO, 
    (SELECT NVL(SUM(VALOR), 0)                                                 
          FROM PCPREST                                                         
         WHERE DTPAG IS NULL                                                   
           AND CODCLI = PCPEDC.CODCLI                                          
           AND codcob not IN ('BNF', 'DEVT', 'DEVP', 'CANC', 'DESD') 
           AND dtvenc >= trunc(SYSDATE)) VLTITAVENCER,                         
  0 AS VLFATURAR,                                                                                                          
  0 VLPENDENTE,                                                                                                            
  0 VLRECEBERCHEQUE,                                                                                                       
  PCFILIAL.UF UFFILIAL                                                                                                     
  ,NVL(PERMITIRVENDAINTERESTADUALPF,'S') PERMITIRVENDAINTERESTADUALPF                                                    
  ,NVL(PERMITIRVENDAESTADUALPFCOMIE,'S') PERMITIRVENDAESTADUALPFCOMIE                                                    
  ,NVL(PERMITIRVENDAESTADUALPFSEMIE,'S') PERMITIRVENDAESTADUALPFSEMIE                                                    
  ,NVL(PCPEDC.BROKER, 'N') BROKER                                                                                        
  ,PCPEDC.CODESTABELECIMENTO                                                                                               
  ,PCPEDC.NUMTABELA                                                                                                        
  ,NVL(PCPEDC.IMPORTADO,'N') IMPORTADO                                                                                   
  ,PCFILIAL.TIPOBROKER                                                                                                     
  ,PCPLPAG.OBS OBSPLPAG                                                                                                    
  ,PCPLPAG.TIPOPRAZO, PCPLPAG.FORMAPARCELAMENTO                                                                            
  ,PCPLPAG.TIPORESTRICAO                                                                                                   
  ,PCPLPAG.NUMDIAS                                                                                                         
  ,PCPEDC.MOTIVOPOSICAO                                                                                                    
  ,PCCLIENT.CLASSEVENDA                                                                                                    
  ,PCPEDC.FRETEDESPACHO                                                                                                    
  ,PCPEDC.CODMOTBLOQUEIO                                                                                                   
  ,PCCLIENT.PLPAGNEG                                                                                                       
  ,NVL(PCCLIENT.isentodifaliquotas, 'S') isentodifaliquotas                                                              
  ,PCPEDC.TIPOOPER                                                                                                         
  ,NVL(PCCLIENT.CONTRIBUINTE, 'N') CONTRIBUINTE                                                                          
  ,NVL(PCFILIAL.USAESTOQUEDEPFECHADO, 'N') USAESTOQUEDEPFECHADO                                                          
  ,NVL(PCPEDC.CONCILIAIMPORTACAO,'N') CONCILIAIMPORTACAO                                                                 
  ,PCPEDC.CODCONTRATO                                                                                                      
  ,NVL(PCCONTRATO.CONSISTIRDADOSNAVENDA,'N') CONSISTIRDADOSNAVENDA                                                       
  ,PCCONTRATO.ESPECIFICACAO                                                                                                
  ,PCCOB_PED.VLMINPEDIDO VLMINPEDIDO_COB                                                                                   
  ,PCPLPAG.VLMINPEDIDO VLMINPEDIDO_PLPAG                                                                                   
  ,PCCLIENT.CODATV1                                                                                                        
  ,PCATIVI.RAMO                                                                                                            
  ,PCPEDC.NUMNOTA                                                                                                          
  ,NVL(PCPEDC.PERDESCFIN, 0) PERDESCFIN                                                                                    
  ,PCCLIENT.PERDESCISENTOICMS                                                                                              
  ,NVL(PCCLIENT.TipoDescIsencao, 'N') TipoDescIsencao                                                                    
  ,NVL(PCPEDC.RESTRICAOTRANSP, 'N') RESTRICAOTRANSP                                                                      
  ,PCPLPAG.CODRESTRICAO                                                                                                    
  ,PCPEDC.CODFORNECFRETE                                                                                                   
  ,NVL(PCCLIENT.USAIVAFONTEDIFERENCIADO, 'N') USAIVAFONTEDIFERENCIADO                                                    
  ,PCCLIENT.IVAFONTE                                                                                                       
  ,DECODE(NVL(PCPEDC.UTILIZAVENDAPOREMBALAGEM,'X'),'X',                                                                
          NVL(PCFILIAL.UTILIZAVENDAPOREMBALAGEM, NVL(PCCONSUM.UTILIZAVENDAPOREMBALAGEM, 'N')),                           
          PCPEDC.UTILIZAVENDAPOREMBALAGEM) UTILIZAVENDAPOREMBALAGEM                                                        
  ,NVL(PCFILIAL.PRECOPOREMBALAGEM, NVL(PCCONSUM.PRECOPOREMBALAGEM, 'N')) PRECOPOREMBALAGEM                               
  ,PCPEDC.NUMPEDRCA                                                                                                        
  ,NVL(PCFILIAL.USAWMS, 'N') USAWMS                                                                                      
  ,NVL(VALIDARENDAPANHAAUTOSERVICO, 'S') VALIDARENDAPANHAAUTOSERVICO                                                     
  ,NVL(AUTOSERVICO, 'N') AUTOSERVICO                                                                                     
  ,PCPEDC.NUMCARMANIF                                                                                                      
  ,PCPEDC.NUMPEDBNF, PCPEDC.NUMPEDTV1                                                                                      
  ,PCPEDC.DTFINALCHECKOUT                                                                                                  
  ,PCPEDC.dtinicialcheckout                                                                                                
  ,NVL(PCFILIAL.CalcEstDispComQtMinAutoServ, 'N') CalcEstDispComQtMinAutoServ                                            
  ,NVL(PCFILIAL.TipoPrecificacao, 'P') TipoPrecificacao                                                                  
  ,NVL(PCPEDC.VENDAASSISTIDA, 'N') VENDAASSISTIDA                                                                        
  ,PCPEDC.CODMOTIVO                                                                                                        
  ,nvl(pkg_motivobloqueio.retornalistamotivos(pcpedc.numped), pcpedc.motivoposicao) motivobloqueio                         
  ,PCPEDC.LOG, PCPEDC.LOG1, PCPEDC.LOG2, PCPEDC.LOG3, PCPEDC.LOG4                                                          
  ,PCPEDC.DTEXPORTACAO                                                                                                     
  ,PCPEDC.NUMSEQENVIO                                                                                                      
  ,NVL(PCPRACA.PRIORIDADEENTREGA,'N') PRIORIDADEENTREGA                                                                  
  ,NVL(PCPEDC.UsaIntegracaoWMS, 'N') UsaIntegracaoWMS                                                                    
  ,PCPEDC.DTCALCFRETE, PCPEDC.CODFUNCCALCFRETE                                                                             
  ,NVL(PCFILIAL.TIPOFRETEAUTO, 'N') TIPOFRETEAUTO                                                                        
 ,DECODE(PCPEDC.POSICAO, 'M', PCPEDC.VLATEND,
                         'L', PCPEDC.VLATEND,
 (SELECT
             SUM(PCPEDI.PVENDA * --                    trunc(qtdisponivel/multiplo)*multiplo                   
                               LEAST(PCPEDI.QT, TRUNC( --Estoquedisponivel                                     
                                                     ( greatest(                                                                                                  
                                                      case when                                                                                                  
                                                            (select(DECODE((SELECT TIPOMERC FROM PCPRODUT WHERE CODPROD = 
PCEST.CODPROD),'CB', DECODE(FERRAMENTAS.F_BUSCARPARAMETRO_ALFA('FIL_MONTARKITAUTOMATICAMENTE',PCEST.CODFILIAL,'N'),'S',(SELECT 
QTDISP FROM TABLE(PKG_ESTOQUE.ESTOQUE_DISPONIVEL_CB(PCEST.CODPROD,PCEST.CODFILIAL))),0)+ (NVL(PCEST.QTESTGER,0) - 
NVL(PCEST.QTRESERV,0) - NVL(PCEST.QTBLOQUEADA,0)),(NVL(PCEST.QTESTGER,0) - NVL(PCEST.QTRESERV,0) - NVL(PCEST.QTBLOQUEADA,0) - 
NVL(PCEST.QTINDUSTRIA, 0)))
                                                                             )                                                                                   
                                                               FROM PCEST
                                                              WHERE CODPROD = PCPEDI.CODPROD
                                                                AND CODFILIAL = NVL(PCPEDI.CODFILIALRETIRA, PCPEDC.CODFILIAL)) 
                                                      >= (SELECT pcest.qtpendente FROM pcest WHERE codprod = pcpedi.codprod AND 
codfilial = nvl(pcpedi.codfilialretira, PCPEDC.CODFILIAL)) then 
                                                           (select(DECODE((SELECT TIPOMERC FROM PCPRODUT WHERE CODPROD = 
PCEST.CODPROD),'CB', DECODE(FERRAMENTAS.F_BUSCARPARAMETRO_ALFA('FIL_MONTARKITAUTOMATICAMENTE',PCEST.CODFILIAL,'N'),'S',(SELECT 
QTDISP FROM TABLE(PKG_ESTOQUE.ESTOQUE_DISPONIVEL_CB(PCEST.CODPROD,PCEST.CODFILIAL))),0)+ (NVL(PCEST.QTESTGER,0) - 
NVL(PCEST.QTRESERV,0) - NVL(PCEST.QTBLOQUEADA,0)),(NVL(PCEST.QTESTGER,0) - NVL(PCEST.QTRESERV,0) - NVL(PCEST.QTBLOQUEADA,0) - 
NVL(PCEST.QTINDUSTRIA, 0)) - DECODE(NVL(FERRAMENTAS.F_BUSCARPARAMETRO_ALFA('BLOQUEIAVENDAESTPENDENTE', PCEST.CODFILIAL, 'N'), 
'N'), 'S', NVL(PCEST.QTPENDENTE,0), 0) )
                        )
          FROM PCEST
         WHERE CODPROD = PCPEDI.CODPROD
           AND CODFILIAL = NVL(PCPEDI.CODFILIALRETIRA, PCPEDC.CODFILIAL))  
 else 
      (select(DECODE((SELECT TIPOMERC FROM PCPRODUT WHERE CODPROD = PCEST.CODPROD),'CB', 
DECODE(FERRAMENTAS.F_BUSCARPARAMETRO_ALFA('FIL_MONTARKITAUTOMATICAMENTE',PCEST.CODFILIAL,'N'),'S',(SELECT QTDISP FROM 
TABLE(PKG_ESTOQUE.ESTOQUE_DISPONIVEL_CB(PCEST.CODPROD,PCEST.CODFILIAL))),0)+ (NVL(PCEST.QTESTGER,0) - NVL(PCEST.QTRESERV,0) - 
NVL(PCEST.QTBLOQUEADA,0)),(NVL(PCEST.QTESTGER,0) - NVL(PCEST.QTRESERV,0) - NVL(PCEST.QTBLOQUEADA,0) - NVL(PCEST.QTINDUSTRIA, 
0)))
                        )
          FROM PCEST
         WHERE CODPROD = PCPEDI.CODPROD
           AND CODFILIAL = NVL(PCPEDI.CODFILIALRETIRA, PCPEDC.CODFILIAL)) 
 END 
                                                        ,0)  
                                                ) / (                                                          
                                                       decode(--se p cliente valida multiplo                   
                                                             (SELECT NVL(PCCLIENT.VALIDARMULTIPLOVENDA,        
                                                                        'N')                                 
                                                               FROM PCCLIENT                                   
                                                              WHERE CODCLI = PCPEDC.CODCLI),                   
                                                             'N',                                            
                                                             1,                                                
                                                             DECODE(--retorna o multplo da pcprodut se existir 
                                                                    (SELECT NVL(MULTIPLO,0)                    
                                                                          FROM PCPRODUT                        
                                                                         WHERE CODPROD =                       
                                                                               PCPEDI.CODPROD),                
                                                                    0,                                         
                                                                    1,                                         
                                                                    (SELECT NVL(MULTIPLO,0)                    
                                                                       FROM PCPRODUT                           
                                                                      WHERE CODPROD =                          
                                                                            PCPEDI.CODPROD)                    
                                                                    )                                          
                                                           ) )                                                 
                                                    )                                                          
                                                *                                                              
                                                decode(--se p cliente valida multiplo                          
                                                         (SELECT NVL(PCCLIENT.VALIDARMULTIPLOVENDA,            
                                                                    'N')                                     
                                                           FROM PCCLIENT                                       
                                                          WHERE CODCLI = PCPEDC.CODCLI),                       
                                                         'N',                                                
                                                         1,                                                    
                                                         DECODE(--retorna o multplo da pcprodut se existir     
                                                                (SELECT NVL(MULTIPLO,0)                        
                                                                      FROM PCPRODUT                            
                                                                     WHERE CODPROD =                           
                                                                           PCPEDI.CODPROD),                    
                                                                0,                                             
                                                                1,                                             
                                                                (SELECT NVL(MULTIPLO,0)                        
                                                                   FROM PCPRODUT                               
                                                                  WHERE CODPROD =                              
                                                                        PCPEDI.CODPROD)                        
                                                                )                                              
                                                       )                                                       
                                                                                                               
                                      )                                                                        
                   )                                                                                           
           from PCPEDI                                                                                         
          where PCPEDI.NUMPED = PCPEDC.NUMPED)) VLATEND_PREV                                                   
     ,DtAberturaPedPalm                                                                                                    
     ,NVL(PCCLIENT.VALIDARMULTIPLOVENDA, 'N') VALIDARMULTIPLOVENDA                                                       
     ,(SELECT NOME                                                                                                         
         FROM PCEMPR                                                                                                       
        WHERE MATRICULA = PCPEDC.CODFUNCLIBERA) clNOMEFUNCLIBERA                                                           
     ,PCPEDC.TIPOPRIORIDADEENTREGA                                                                                         
     ,NVL(PCFILIAL.CALCULARIPIVENDA, 'S') CALCULARIPIVENDA                                                               
     ,NVL(PCFILIAL.CANCELAPEDIDORETORNADOWMS, 'N') CANCELAPEDIDORETORNADOWMS                                             
     ,NVL(PCCLIENT.AceitaVendaFracao, 'N') AceitaVendaFracao                                                             
     ,NVL(PCFILIAL.ValidarPrecoVendaTV20, 'N') ValidarPrecoVendaTV20                                                     
     ,DECODE(PCPEDC.FRETEDESPACHO, 'C', 'CIF'                                                                          
                                 , 'F', 'FOB'                                                                          
                                 , 'G', 'Gratuito'                                                                     
                                 , 'N�o definido') Frete                                                                 
     ,NVL(PCClient.OrgaoPubFederal, 'N') OrgaoPubFederal                                                                 
     ,NVL(PCClient.OrgaoPub, 'N') OrgaoPub                                                                               
     ,PCPEDC.CODUSUR2                                                                                                      
     ,PCPEDC.CODUSUR3                                                                                                      
     ,PCPEDC.CODUSUR4                                                                                                      
     ,NVL(PCFilial.InformarProfissionalVenda, 'N') InformarProfissionalVenda                                             
     ,NVL(PCFilial.NumDiasMaximoLiberarPedido,0) NumDiasMaximoLiberarPedido                                                
     ,NVL(PCFILIAL.ValidarPrecoVendaTV8, 'N') ValidarPrecoVendaTV8                                                       
     ,PCClient.Fantasia                                                                                                    
     ,NVL( pcfilial.usacodclivenda, 'N' ) usacodclivenda                                                                 
     ,pcfilial.NumMaxItensNFe                                                                                              
     ,NVL(pcfilial.UtilizaNfe, 'N') UtilizaNfe                                                                           
     ,PCPEDC.CODCLINF                                                                                                      
     ,PCPEDC.NUMEMPENHO                                                                                                    
     ,NVL( pcpedc.UsaCredRca, NVL( pcconsum.UsaCredRca, 'N' )) UsaCredRca                                                
     ,NVL( pcpedc.usadebcredrca, 'N') UsaDebCredRca                                                                      
     ,NVL( pcpedc.Brinde, 'N') Brinde                                                                                    
     ,NVL( pcpedc.bonificaltdebcredrca, NVL( pcconsum.bonificaltdebcredrca, 'N' )) BonificAltDebCredRCA                  
     ,NVL( pcpedc.TrocaAltDebCredRCa, NVL( pcconsum.TrocaAltDebCredRCa, 'N' )) TrocaAltDebCredRCa                        
     ,NVL( pcpedc.BrokerAltDebCredRCA, NVL( pcconsum.BrokerAltDebCredRCA, 'N' )) BrokerAltDebCredRCA                     
     ,NVL( pcpedc.CRMAltDebCredRCA, NVL( pcconsum.CRMAltDebCredRCA, 'N' )) CRMAltDebCredRCA                              
     ,NVL( pcfilial.OrigemCustoFilialRetira, 'V' ) OrigemCustoFilialRetira                                               
     ,NVL( pcfilial.AlterarCobBKCHAutomatico, 'S' ) AlterarCobBKCHAutomatico                                             
     ,NVL( pcfilial.AceitaVendaAVistaCliBloq, 'N' ) AceitaVendaAVistaCliBloq                                             
     ,pcfilial.PercMaxDifProdSimil                                                                                         
     ,pcclient.NumRegistroImune                                                                                            
     ,NVL( pcfilial.perlimvendapf, pcconsum.perlimvendapf) perlimvendapf                                                   
     ,NVL( pcpedc.tipomovccrca, NVL( pcconsum.tipomovccrca, 'VV' )) tipomovccrca                                         
     ,(SELECT SUM(ROUND((CASE WHEN PCPEDC.CONDVENDA = 5 THEN                                                               
             CASE WHEN (FERRAMENTAS.F_BUSCARPARAMETRO_ALFA('USAPTABELACOMOBASE',                                         
                                                             '99',                                                       
                                                             'N')) = 'S' THEN                                          
                 (NVL(PCPEDI.PTABELA, 0) * NVL(PCPEDI.QT, 0)) * (-1)                                                       
                     ELSE                                                                                                  
                 (NVL(PCPEDI.PVENDA, 0) * NVL(PCPEDI.QT, 0)) * (-1)                                                        
              END                                                                                                          
              WHEN PCPEDC.CONDVENDA = 11 THEN                                                                              
                CASE WHEN (FERRAMENTAS.F_BUSCARPARAMETRO_ALFA('CON_TROCAALTDEBCREDRCA',                                  
                                                             '99',                                                       
                                                             'N')) = 'S' THEN                                          
                  CASE WHEN (FERRAMENTAS.F_BUSCARPARAMETRO_ALFA('USAPTABELACOMOBASE',                                    
                                                                '99',                                                    
                                                                'N')) = 'S' THEN                                       
                    (NVL(PCPEDI.PTABELA, 0) * NVL(PCPEDI.QT, 0)) * (-1)                                                    
                       ELSE                                                                                                
                    (NVL(PCPEDI.PVENDA, 0) * NVL(PCPEDI.QT, 0)) * (-1)                                                     
                     END                                                                                                   
                    ELSE                                                                                                   
                     0                                                                                                     
                 END                                                                                                       
                ELSE                                                                                                       
                 ((NVL(PCPEDI.PVENDA, 0) -                                                                                 
                  NVL(NVL(PCPEDI.PBASERCA, 0), NVL(PCPEDI.PTABELA, 0))) *                                                  
                  NVL(PCPEDI.QT, 0))                                                                                       
               END),                                                                                                       
               2))                                                                                                         
         FROM pcpedi                                                                                                       
        WHERE pcpedi.numped = pcpedc.numped                                                                                
          AND pcpedi.qt > 0                                                                                                
          AND pcpedi.posicao <> 'C') VLPBASERCA                                                                          
     ,NVL( pcpedc.usasaldocontacorrentedescfin, 'N') usasaldocontacorrentedescfin                                        
     ,pcpedc.valordescfin                                                                                                  
     ,NVL( pcpedc.vendatriangular, 'N') vendatriangular                                                                  
     ,DECODE(NVL(pcclient.analisecred, 'N'), 'N', 'N�o', 'Sim') analisecred                                        
     ,pcclient.dtultconsultaserasa                                                                                         
     ,pcclient.dtultconsultasci                                                                                            
     ,pcclient.dataconsultasintegra                                                                                        
     ,pcclient.DTULTCONSULTASINTEGRA                                                                                       
       ,CASE WHEN GREATEST(NVL(PCPEDC.VLATEND, 0)-nvl(pcpedc.vlfrete,0)-nvl(pcpedc.vloutrasdesp,0), 0) = 0 THEN -100 ELSE  
      DECODE (NVL (pcpedc.vlatend, 0)                                                                                      
                   ,0, 0                                                                                                   
                   ,ROUND (  (((pcpedc.vlatend-nvl(pcpedc.vlfrete,0)-nvl(pcpedc.vloutrasdesp,0)) -                         
                             nvl(pcpedc.vlcustofin,0)) / (pcpedc.vlatend-nvl(pcpedc.vlfrete,0)-nvl(pcpedc.vloutrasdesp,0)) 
                             )                                                                                             
                           * 100                                                                                           
                          ,2)                                                                                              
                   ) end as clperlucro                                                                                     
      ,coalesce(pcclient.prazomedioplpag, PCPLPAG_CLI.NUMDIAS,0) prazomedioplpag                                           
      ,pcpedc.custobonificacao                                                                                             
      ,pcpedc.codfornecbonific                                                                                             
      ,pcpedc.codbnf                                                                                                       
      , NVL ((SELECT NVL (valor                                                                                            
                              , NVL (pcconsum.verificaestoquecont, 'S'))                                                 
                FROM pcparamfilial                                                                                         
               WHERE nome = 'VERIFICAESTOQUECONT'                                                                        
                 AND pcparamfilial.codfilial = pcpedc.codfilial),                                                          
              NVL (pcconsum.verificaestoquecont, 'S')) verificaestoquecont                                               
      ,pcpedc.ufdesembaraco                                                                                                
      ,pcpedc.localdesembaraco                                                                                             
      ,pcpedc.tipodocumento                                                                                                
      ,pcclient.codrede codrede_client                                                                                     
      ,pcclient.DTVENCALVARA DTVENCALVARA_client                                                                           
      ,pcclient.DTVENCALVARAFUNC DTVENCALVARAFUNC_client                                                                   
      ,pcclient.DTVENCALVARAANVISA DTVENCALVARAANVISA_client                                                               
      ,pcclient.DTVENCCRF DTVENCCRF_client                                                                                 
      ,NVL(PCCLIENT.REPASSE, 'N') REPASSE_client                                                                         
      ,NVL(PCPEDC.VENDAEXPORTACAO, 'N') VENDAEXPORTACAO                                                                  
      ,pcpedc.TURNOENTREGA                                                                                                 
      ,pcpedc.CODENDENTCLI                                                                                                 
      ,PCPEDC.VLRMOEDAESTRANGEIRA                                                                                          
      ,PCPEDC.CODMOEDAESTRANGEIRA                                                                                          
      ,PCPEDC.TAXACASOMOEDAREAL                                                                                            
      ,PCPEDC.NUMPEDCLI                                                                                                    
      ,NVL(PCPEDC.VENDALOCESTRANG, 'N') VENDALOCESTRANG                                                                  
      ,PCPEDC.USACFOPVENDANATV10                                                                                           
      ,PCPEDC.FORNECENTREGA                                                                                                
      ,PCPEDC.TIPOCFOPTV4                                                                                                  
      ,PCPEDC.SERIEECF                                                                                                     
      ,PCPEDC.NUMNOTACONSIG                                                                                                
      ,PCPEDC.NUMPRECAR                                                                                                    
      ,PCPEDC.DERRUBADACARGA                                                                                               
      ,PCPEDC.DERRUBADACARGA                                                                                               
      ,PCPEDC.NUMPEDWEB                                                                                                    
      ,PCPEDC.NUMPEDMKTPLACE                                                                                               
      ,PCPEDC.VLDESCONTOCUPOM                                                                                              
      ,NVL(PCPEDC.PAGAMENTOAPROVADOCIASHOP, 'N') PAGAMENTOAPROVADOCIASHOP                                                
      ,PCPEDC.CODPLPAGANT                                                                                                  
      ,PCPEDC.RECALPRECOALTPLPAG                                                                                           
      ,PCPEDC.VLVERBACMVCLI                                                                                                
      ,PCPEDC.VLVERBACMV                                                                                                   
      ,(SELECT MAX(C.VLATEND)                                                                                              
          FROM PCPEDC C                                                                                                    
         WHERE C.CODCLI = PCPEDC.CODCLI                                                                                    
          AND C.POSICAO = 'F' AND C.DATA >= (TRUNC(SYSDATE)-365)) MAIORCOMPRAANO                                         
      ,PCREDECLIENTE.DESCRICAO AS REDECLI                                                                                  
      ,PCPEDC.INTEGRADORA                                                                                                  
      ,NVL(PCCLIENT.BLOQUEIOSEFAZPED, 'N') BLOQUEIOSEFAZPED                                                              
      ,PCCLIENT.DTVENCALVARAANVISA                                                                                         
      ,PCCLIENT.DTVENCALVARASUS                                                                                            
      ,PCCLIENT.DTVENCALVARAFUNC                                                                                           
      ,PCCLIENT.DTVENCALVARA                                                                                               
FROM PCPEDC
    ,PCFILIAL
    ,PCCLIENT
    ,PCUSUARI
    ,PCPLPAG
    ,PCPRACA
    ,PCREGIAO
    ,PCCOB
    ,PCROTAEXP
    ,PCATIVI
    ,PCCONTRATO
    ,PCCOB PCCOB_PED
    ,PCMOTBLOQUEIO
    ,PCCONSUM
    ,PCPLPAG PCPLPAG_CLI
    ,PCREDECLIENTE
WHERE  PCPEDC.CODFILIAL = PCFILIAL.CODIGO
AND    PCPEDC.CODMOTIVO = PCMOTBLOQUEIO.CODMOTIVO(+)
  AND  PCPEDC.CONDVENDA NOT IN (98)
  AND  PCPEDC.CODCLI = PCCLIENT.CODCLI
  AND  PCPEDC.CODUSUR = PCUSUARI.CODUSUR
  AND  PCPEDC.CODPLPAG = PCPLPAG.CODPLPAG
  AND  PCPEDC.CODPRACA = PCPRACA.CODPRACA
  AND  PCPRACA.NUMREGIAO = PCREGIAO.NUMREGIAO
  AND  PCCLIENT.CODREDE = PCREDECLIENTE.CODREDE(+)
  AND  PCCLIENT.CODATV1 = PCATIVI.CODATIV
  AND  PCCLIENT.CODCOB = PCCOB.CODCOB
  AND  PCPEDC.CODCOB = PCCOB_PED.CODCOB
  AND  PCPLPAG_CLI.CODPLPAG = PCCLIENT.CODPLPAG 
  AND  PCPRACA.ROTA = PCROTAEXP.CODROTA(+)
  AND  PCPEDC.CODCONTRATO = PCCONTRATO.CODCONTRATO(+)
AND NOT EXISTS( SELECT 1 FROM PCNFSAID WHERE PCNFSAID.NUMPED = PCPEDC.NUMPED)
  AND NVL(PCPEDC.AGRUPAMENTO,'N') = 'N'
  AND PCPEDC.DATA >= to_date('06/03/2024','dd/mm/yyyy') 
  AND PCPEDC.DATA <= to_date('06/03/2024','dd/mm/yyyy') 
AND PCPEDC.CODFILIAL IN ('2')
AND PCCLIENT.ESTENT = :ESTENT
AND ((PCUSUARI.CODSUPERVISOR IN (SELECT CODIGON FROM PCLIB WHERE PCLIB.CODTABELA = 7 AND CODIGON <> 9999 AND CODFUNC = 1261)) OR 
      EXISTS(SELECT CODIGON FROM PCLIB WHERE PCLIB.CODTABELA = 7 AND CODIGON = 9999 AND CODFUNC = 1261))
   AND PCPEDC.POSICAO IN ('B','P', 'L', 'M')
ORDER BY 
PCPEDC.NUMPED
 ,PCPEDC.CONDVENDA
abaterimpostoscomissaorca = 'S'
ESTENT = 'P'
----------------------------------
Timestamp: 10:20:11.342
SELECT DISTINCT
       PCPEDI.NUMPED,
       PCPEDI.CODPROD,
       PCPEDI.CODCONTRATO,
       PCPEDI.QTLITRAGEM,
       PCPRODUT.DESCRICAO,
       PCPRODUT.NumOriginal,
       PCPEDI.GERAGNRE_CNPJCLIENTE,
       PCPEDI.CODUSUR,
       PCPEDI.CODCLI,
       NVL(PCPEDI.DTCONSOLIDACAOAUXPRO, PCPEDI.DATA) DTCONSOLIDACAOAUXPRO,
       PCPEDI.DATA,
       PCPEDI.NUMPED,
       PCPEDI.NUMPEDRAS,
       PCPEDI.NUMSEQRAS,
       PCPEDI.EANCODPROD,
       ROUND(PCPEDI.QT * PCPEDI.PVENDA,2) VLTOTAL,
       PCPRODUT.CODFORNEC,
       PCPRODUT.EMBALAGEMMASTER DESCEMBALAGEMMASTER,
       PCPRODUT.descricao7,
       PCPEDI.DESCPRECOFAB,
       PCPEDI.PRECOMAXCONSUM,
       Decode(:UTILIZAVENDAPOREMBALAGEM,'S',PCEMBALAGEM.EMBALAGEM, PCPRODUT.EMBALAGEM) EMBALAGEM,
       Decode(:UTILIZAVENDAPOREMBALAGEM,'S',NVL(PCEMBALAGEM.QTUNIT,1), NVL(PCPRODUT.QTUNIT,1)) QTUNIT,
       PCPEDI.NUMSEQ,
       PCPRODUT.UNIDADE,
       DECODE((SELECT COUNT ( * )
                 FROM pcprodfilial
                WHERE codprod = PCPRODUT.CODPROD
                  AND codfilial = :CODFILIAL),0,DECODE(NVL(PCPRODUT.MULTIPLO, 0),0,1,PCPRODUT.MULTIPLO),
          NVL((SELECT MULTIPLO
                 FROM pcprodfilial
                WHERE codprod = PCPRODUT.CODPROD
                  AND codfilial = :CODFILIAL), DECODE(NVL(PCPRODUT.MULTIPLO, 0),0,1,PCPRODUT.MULTIPLO))) MULTIPLO,
       PCPEDI.POSICAO,
       NVL(PCPEDI.QT,0) QT,
       NVL(PCPEDI.PVENDA,0) PVENDA,
       NVL(PCPEDI.PTABELA,0) PTABELA,
 greatest( 
 case when  
       (select(PKG_ESTOQUE.ESTOQUE_DISPONIVEL(PCPEDI.CODPROD,NVL(PCPEDI.CODFILIALRETIRA,:CODFILIAL),'VP',null)
                        )
          FROM PCEST
         WHERE CODPROD = PCPEDI.CODPROD
           AND CODFILIAL = NVL(PCPEDI.CODFILIALRETIRA,:CODFILIAL)) 
 >= (SELECT pcest.qtpendente FROM pcest WHERE codprod = pcpedi.codprod AND codfilial = nvl(pcpedi.codfilialretira, :CODFILIAL)) 
then 
      (select(  PKG_ESTOQUE.ESTOQUE_DISPONIVEL(PCPEDI.CODPROD,NVL(PCPEDI.CODFILIALRETIRA,:CODFILIAL),'VA',null)
                        )
          FROM PCEST
         WHERE CODPROD = PCPEDI.CODPROD
           AND CODFILIAL = NVL(PCPEDI.CODFILIALRETIRA,:CODFILIAL))  
    + CASE WHEN PCPEDI.POSICAO IN ('P','B') THEN 
      DECODE(NVL(FERRAMENTAS.F_BUSCARPARAMETRO_ALFA('BLOQUEIAVENDAESTPENDENTE', nvl(pcpedi.codfilialretira, :CODFILIAL),
:CONSUMBLOQUEIAVENDAESTPENDENTE ),:CONSUMBLOQUEIAVENDAESTPENDENTE), 'S', PCPEDI.QT, 0) ELSE 0 END 
 else 
      (select(PKG_ESTOQUE.ESTOQUE_DISPONIVEL(PCPEDI.CODPROD,NVL(PCPEDI.CODFILIALRETIRA,:CODFILIAL),'VP',null)
                        )
          FROM PCEST
         WHERE CODPROD = PCPEDI.CODPROD
           AND CODFILIAL = NVL(PCPEDI.CODFILIALRETIRA,:CODFILIAL)) 
 END 
       ,0) QTDISPONIVEL,
       PCPEDI.QTFALTA,
       PCPEDI.NOMECONCORRENTE,
       PCPEDI.CODST,
       PCPEDI.VLCUSTOFIN,
       PCPEDI.VLCUSTOREAL,
       NVL(PCPEDI.STPTABELA, 0) STPTABELA, 
       NVL(PCPEDI.VLIPIPTABELA, 0) VLIPIPTABELA, 
       nvl(PCPEDI.ST,0) ST,
       nvl(PCPEDI.STCLIENTEGNRE,0) STCLIENTEGNRE,
       PCPEDI.PORIGINAL,
       PCPEDI.PERCIPI,
       nvl(PCPEDI.VLIPI,0) VLIPI,
       PCPEDI.CUSTOFINEST,
       PCPEDI.IVA,
       PCPEDI.PAUTA,
       PCPEDI.ALIQICMS1,
       PCPEDI.ALIQICMS2,
       PCPEDI.VLDESCSUFRAMA,
       PCPEDI.PERDESC,
       PCPEDI.PERCOM,
       DECODE(:ABATERIMPOSTOSCOMISSAORCA,
              'N',(ROUND((PCPEDI.QT * PCPEDI.PVENDA) * (NVL(PCPEDI.PERCOM, 0) / 100),2))
                   ,(ROUND((PCPEDI.QT *
                                        (PCPEDI.PVENDA - (DECODE(FERRAMENTAS.F_BUSCARPARAMETRO_ALFA('IMPOSTOCOMISSAORCA',
PCPEDC.CODFILIAL,'A'),
                                                                 'A', (NVL(PCPEDI.ST,0) + NVL(PCPEDI.VLIPI,0) + 
NVL(PCPEDI.STCLIENTEGNRE,0) + NVL(PCPEDI.VLISS,0)),
                                                                 'I', (NVL(PCPEDI.VLIPI,0) + NVL(PCPEDI.VLISS,0)),
                                                                 'S', (NVL(PCPEDI.ST,0) + NVL(PCPEDI.STCLIENTEGNRE,0) + 
NVL(PCPEDI.VLISS,0)),
                                                                 0))
                                         ) *
              (NVL(PCPEDI.PERCOM, 0) / 100)),2))) VALOR_COMISSAO,
       PCPRODUT.CODFAB,
       PCPEDI.PERCBASEREDST,
       PCPEDI.PERCBASEREDSTFONTE,
       PCPEDI.PERFRETECMV,
       PCPEDI.NUMCAR,
       PCPEDI.PERCISS,
       nvl(PCPEDI.VLISS,0) VLISS,
       PCPEDI.PVENDABASE,
       NVL(PCPEDI.PBASERCA, PCPEDI.PTABELA) PBASERCA
       ,PCPEDI.VLVERBACMV
       ,NUMVERBAREBCMV
       ,PCPEDI.BASEICST
       ,PCPEDI.QTCX
       ,PCPEDI.QTPECAS, 
       PCPEDI.NUMITEMPED, 
        NVL(PCPRODUT.TIPOESTOQUE,'PA') TIPOESTOQUE 
       ,PCPRODUT.UNIDADEMASTER, 
        GET_PRODUTO_PESO(PCPEDI.CODPROD, NVL(PCPEDI.CODFILIALRETIRA, :CODFILIAL)) PESOBRUTOMASTER, 
        GET_PRODUTO_PECA(PCPEDI.CODPROD, NVL(PCPEDI.CODFILIALRETIRA, :CODFILIAL)) PESOPECA, 
        PCPRODUT.PESOBRUTO
       ,PCPEDI.LETRACOMISS
       ,PCPEDI.VLCUSTOCONT
       ,PCPEDI.VLCUSTOREP
       ,PCPRODUT.DV
       ,NVL(PCPEDI.CODFILIALRETIRA, :CODFILIAL) CODFILIALRETIRA
       ,PCPEDI.VLDESCICMISENCAO
       ,PCPEDI.PERDESCISENTOICMS
       ,PCPEDI.CODAUXILIAR
       ,NVL(PCPRODUT.TIPOMERC, 'L') TIPOMERC
       ,PCPEDI.VLVERBACMVCLI
       ,PCPRODUT.CODEPTO
       ,PCPRODUT.CODSEC
       ,PCPEDI.PVENDA1
       ,PCPEDI.COMPLEMENTO
       ,PCPEDI.TXVENDA
       ,PCPEDI.PERDESCCUSTO
       ,PCPEDI.CODICMTAB
       ,PCPEDI.VLDESCCUSTOCMV
       ,NVL(PCPRODUT.ChecarMultiploVendaBNF, 'S') ChecarMultiploVendaBNF
       ,NVL(PCPEDI.QTNAOCOMPRA, 0) QTNAOCOMPRA
        ,PCPEDI.PERCDIFALIQUOTAS
        ,PCPEDI.BASEDIFALIQUOTAS
        ,PCPEDI.VLDIFALIQUOTAS
        ,PCPEDI.PRODDESCRICAOCONTRATO
        ,(select GREATEST(PCEST.QTEST,0) from PCEST where PCEST.CODPROD = PCPEDI.CODPROD and PCEST.CODFILIAL = 
NVL(PCPEDI.CODFILIALRETIRA, :CODFILIAL)) QTEST
        ,(select GREATEST(PCEST.QTRESERV,0) from PCEST where PCEST.CODPROD = PCPEDI.CODPROD and PCEST.CODFILIAL = 
NVL(PCPEDI.CODFILIALRETIRA, :CODFILIAL)) QTRESERV
        ,(select GREATEST(PCEST.QTBLOQUEADA,0) from PCEST where PCEST.CODPROD = PCPEDI.CODPROD and PCEST.CODFILIAL = 
NVL(PCPEDI.CODFILIALRETIRA, :CODFILIAL)) QTBLOQUEADA
        ,PCPEDI.CODFUNCULTALTER
        ,PCPEDI.ROTINAULTLALTER
        ,PCPEDI.DTULTLALTER
        ,PCPEDI.CODFUNCLANC
        ,PCPEDI.ROTINALANC
        ,PCPEDI.DTLANC
        ,PCPEDI.POLITICAPRIORITARIA
        ,PCPEDI.TIPOENTREGA
        ,DECODE((SELECT COUNT(*)
                   FROM PCRESTRICAODESCVALOR
                  WHERE PCRESTRICAODESCVALOR.CODPROD = PCPRODUT.CODPROD
                    AND ((PCRESTRICAODESCVALOR.CODFILIAL = :CODFILIAL) OR
                         (PCRESTRICAODESCVALOR.CODFILIAL IS NULL))
                    AND ((PCRESTRICAODESCVALOR.NUMREGIAO = :NUMREGIAO) OR
                         (PCRESTRICAODESCVALOR.NUMREGIAO IS NULL)))
                ,0,0,1) ProdutoPolDeptoSec
        ,PCPEDI.QTUNITEMB
        ,PCPEDI.QTUNITCX
        ,pcpedi.percdescpis
        ,pcpedi.vldescreducaopis
        ,pcpedi.percdesccofins
        ,pcpedi.vldescreducaocofins
        ,pcpedi.percom2
        ,pcpedi.percom3
        ,pcpedi.percom4
        ,(SELECT pcmarca.marca
            FROM pcmarca
           WHERE pcmarca.codmarca = pcprodut.codmarca) marca
        ,NVL(pcpedi.Brinde, 'N') Brinde
        ,NVL(pcpedi.truncaritem, 'N') truncaritem
        ,pcpedi.coddesconto
        ,pcpedi.CODDESCONTOBASERCA
        ,pcpedi.codcombo
     ,CASE WHEN NVL(PCPEDC.VLATEND, 0) = 0 THEN -100 ELSE
     DECODE (NVL (pcpedi.pvenda, 0)
                   ,0, 0
                   ,ROUND (  ((pcpedi.pvenda - pcpedi.vlcustofin) / pcpedi.pvenda
                             )
                           * 100
                          ,2)
                   ) END AS clperlucro
        ,pcpedi.vlredcmvsimplesnac
        ,pcpedi.vlredpvendasimplesna
        ,pcpedi.PerBonific
        ,pcpedi.VLBONIFIC
        ,pcpedi.PerDescCom
        ,pcpedi.VlDescCom
        ,pcpedi.VlRepasse
        ,pcpedi.VlOutros
        ,PCPEDI.PERCDESCABATIMENTO
        ,PCPEDI.VLDESCABATIMENTO
        ,PCPEDI.NUMERORECOPI
        ,PCPEDI.USAUNIDADEMASTER
        ,PCPEDI.VLRMOEDAESTRAGEIRA
        ,PCPEDI.CODMOEDAESTRAGEIRA
        ,DECODE ((SELECT COUNT (1) 
          FROM pcprodfilial 
                 WHERE codprod = pcprodut.codprod 
                   AND codfilial = NVL(PCPEDI.CODFILIALRETIRA, :CODFILIAL)) 
              ,0, 'N' 
              , (SELECT NVL (utilizaqtdesupmultipla, 'N') 
                   FROM pcprodfilial 
                  WHERE codprod = pcprodut.codprod 
                    AND codfilial = NVL(PCPEDI.CODFILIALRETIRA, :CODFILIAL)) 
              ) utilizaqtdesupmultipla 
         , PCPEDI.PERDESCPAUTA 
         , PCPEDI.ORIGEMST 
         , PCPEDI.PERCREDALIQIPI 
         , NVL(PCPEDI.BONIFIC,'N') BONIFIC 
         , NVL(PCPEDI.PBONIFIC, 0) PBONIFIC  
         , PCPEDI.ALIQFCP                    
         , PCPEDI.ALIQINTERNADEST            
         , PCPEDI.VLFCPPART                  
         , PCPEDI.VLICMSPARTDEST             
         , PCPEDI.VLICMSPART                 
         , PCPEDI.PERCPROVPART               
         , PCPEDI.VLICMSDIFALIQPART          
         , PCPEDI.PERCBASEREDPART            
         , PCPEDI.VLICMSPARTREM              
         , PCPEDI.ALIQINTERORIGPART          
         , PCPEDI.VLBASEPARTDEST             
         , PCPEDI.CODFIGVENDATRIANGULAR      
         , PCPEDI.CODDESCONTOSIMULADOR       
         , PCPEDI.CODFISCAL                  
         , PCPEDI.SITTRIBUT                  
         , PCPEDI.PTABELAFABRICAZFM          
         , PCPEDI.ORIGMERCTRIB               
         , PCPEDI.VLDESCCARCACA              
         , PCPEDI.DEVOLUCAOCARCACA           
         , pcprodut.ACEITATROCAINSERVIVEL    
         , pcprodut.CODINSERVIVEL            
         , PCPEDI.NUMDRAWBACK                
         , PCPEDI.NUMCHAVEEXP                
         , PCPEDI.NUMREGEXP                  
         , PCPEDI.CODEMITENTEITEMPEDIDO      
         , PCPEDI.VLBASEFCPST      
         , PCPEDI.ALIQICMSFECP      
         , PCPEDI.VLFECP      
         , PCPEDI.UTILIZOUMOTORCALCULO 
         , PCPEDI.QTEMBALAGEM 
         , PCPEDI.CODPRECOFIXO 
         , PCPEDI.CODPRECOCESTA 
         , NVL(PCPRODUT.PSICOTROPICO,'N') PSICOTROPICO 
         , PCPEDI.NUMPEDCLI                  
         , PCPRODUT.CLASSE   
         , PCPRODUT.CODMARCA 
         , PCPEDI.VLBASEFCPICMS 
 FROM PCPEDI, PCPRODUT, PCEMBALAGEM, PCPEDC
WHERE PCPEDI.CODPROD     = PCPRODUT.CODPROD
  AND PCPEDI.NUMPED      = :NUMPED
  AND PCPEDI.NUMPED      = PCPEDC.NUMPED
  AND PCPEDI.CODPROD     = PCEMBALAGEM.CODPROD(+)
  AND PCPEDI.CODAUXILIAR = PCEMBALAGEM.CODAUXILIAR(+)
  AND DECODE(NVL(PCPEDC.UTILIZAVENDAPOREMBALAGEM, 'X'),
          'X',
          DECODE((SELECT NVL(PCFILIAL.UTILIZAVENDAPOREMBALAGEM,
                            PCCONSUM.UTILIZAVENDAPOREMBALAGEM)
                   FROM PCFILIAL, PCCONSUM
                  WHERE PCFILIAL.CODIGO = PCPEDC.CODFILIAL),
                 'S',
                 PCEMBALAGEM.CODFILIAL,
                 PCPEDC.CODFILIAL),
          'S',
          PCEMBALAGEM.CODFILIAL,
          '99') =
   DECODE(NVL(PCPEDC.UTILIZAVENDAPOREMBALAGEM, 'X'),
          'X',
          DECODE((SELECT NVL(PCFILIAL.UTILIZAVENDAPOREMBALAGEM,
                            PCCONSUM.UTILIZAVENDAPOREMBALAGEM)
                   FROM PCFILIAL, PCCONSUM
                  WHERE PCFILIAL.CODIGO = PCPEDC.CODFILIAL),
                 'S',
                 NVL(PCPEDI.CODFILIALRETIRA, PCPEDC.CODFILIAL),
                 PCPEDC.CODFILIAL),
          'S',
CASE WHEN ((:USAESTOQUEDEPFECHADO = 'S') AND 
           (:UTILIZAEMBALAGEMFILIALRETIRA = 'S')) THEN 
  PCPEDC.CODFILIAL ELSE NVL(PCPEDI.CODFILIALRETIRA, PCPEDC.CODFILIAL) END 
  , '99') 
 AND PCPEDI.POSICAO NOT IN ('C')
 AND 1 = 1
ORDER BY clPERLUCRO
UTILIZAVENDAPOREMBALAGEM = 'N'
CODFILIAL = '2'
CONSUMBLOQUEIAVENDAESTPENDENTE = <NULL>
ABATERIMPOSTOSCOMISSAORCA = <NULL>
NUMREGIAO = 15
NUMPED = 791011572
USAESTOQUEDEPFECHADO = 'N'
UTILIZAEMBALAGEMFILIALRETIRA = <NULL>
----------------------------------
Timestamp: 10:20:11.885
SELECT PARAMFILIAL.OBTERCOMOVARCHAR2('UTILIZAEMBALAGEMFILIALRETIRA', '2')
  FROM DUAL
----------------------------------
Timestamp: 10:20:11.898
begin  :Result := SYS_CONTEXT ('USERENV', 'CURRENT_SCHEMA');end;
Result = 'FRIOBOM'
----------------------------------
Timestamp: 10:20:11.925
SELECT '' TABLE_CATALOG, IC.TABLE_OWNER TABLE_SCHEMA, IC.TABLE_NAME, '' INDEX_CATALOG, IC.INDEX_OWNER INDEX_SCHEMA, 
IC.INDEX_NAME, IC.COLUMN_NAME, IC.COLUMN_POSITION, DECODE(IC.DESCEND, 'ASC', 0, 1) DESCENDING FROM SYS.ALL_IND_COLUMNS IC, 
SYS.ALL_INDEXES I, SYS.ALL_CONSTRAINTS C WHERE IC.TABLE_OWNER = 'FRIOBOM' AND IC.TABLE_NAME = 'PCPEDI' AND I.UNIQUENESS = 
'UNIQUE' AND        I.OWNER = IC.INDEX_OWNER AND I.INDEX_NAME = IC.INDEX_NAME AND       C.TABLE_NAME (+) = IC.TABLE_NAME AND 
C.INDEX_NAME (+) = IC.INDEX_NAME AND C.OWNER (+)= IC.TABLE_OWNER ORDER BY DECODE(IC.INDEX_OWNER, 'FRIOBOM', 0, 'PUBLIC', 1, 2), 
DECODE(C.CONSTRAINT_TYPE, 'P', 1, 'U', 2, 3), IC.INDEX_OWNER, IC.TABLE_OWNER, IC.TABLE_NAME, IC.INDEX_NAME, IC.COLUMN_POSITION
----------------------------------
Timestamp: 10:20:11.964
SELECT DISTINCT
       PCPEDI.NUMPED,
       PCPEDI.CODPROD,
       PCPEDI.CODCONTRATO,
       PCPEDI.QTLITRAGEM,
       PCPRODUT.DESCRICAO,
       PCPRODUT.NumOriginal,
       PCPEDI.GERAGNRE_CNPJCLIENTE,
       PCPEDI.CODUSUR,
       PCPEDI.CODCLI,
       NVL(PCPEDI.DTCONSOLIDACAOAUXPRO, PCPEDI.DATA) DTCONSOLIDACAOAUXPRO,
       PCPEDI.DATA,
       PCPEDI.NUMPED,
       PCPEDI.NUMPEDRAS,
       PCPEDI.NUMSEQRAS,
       PCPEDI.EANCODPROD,
       ROUND(PCPEDI.QT * PCPEDI.PVENDA,2) VLTOTAL,
       PCPRODUT.CODFORNEC,
       PCPRODUT.EMBALAGEMMASTER DESCEMBALAGEMMASTER,
       PCPRODUT.descricao7,
       PCPEDI.DESCPRECOFAB,
       PCPEDI.PRECOMAXCONSUM,
       Decode(:UTILIZAVENDAPOREMBALAGEM,'S',PCEMBALAGEM.EMBALAGEM, PCPRODUT.EMBALAGEM) EMBALAGEM,
       Decode(:UTILIZAVENDAPOREMBALAGEM,'S',NVL(PCEMBALAGEM.QTUNIT,1), NVL(PCPRODUT.QTUNIT,1)) QTUNIT,
       PCPEDI.NUMSEQ,
       PCPRODUT.UNIDADE,
       DECODE((SELECT COUNT ( * )
                 FROM pcprodfilial
                WHERE codprod = PCPRODUT.CODPROD
                  AND codfilial = :CODFILIAL),0,DECODE(NVL(PCPRODUT.MULTIPLO, 0),0,1,PCPRODUT.MULTIPLO),
          NVL((SELECT MULTIPLO
                 FROM pcprodfilial
                WHERE codprod = PCPRODUT.CODPROD
                  AND codfilial = :CODFILIAL), DECODE(NVL(PCPRODUT.MULTIPLO, 0),0,1,PCPRODUT.MULTIPLO))) MULTIPLO,
       PCPEDI.POSICAO,
       NVL(PCPEDI.QT,0) QT,
       NVL(PCPEDI.PVENDA,0) PVENDA,
       NVL(PCPEDI.PTABELA,0) PTABELA,
 greatest( 
 case when  
       (select(PKG_ESTOQUE.ESTOQUE_DISPONIVEL(PCPEDI.CODPROD,NVL(PCPEDI.CODFILIALRETIRA,:CODFILIAL),'VP',null)
                        )
          FROM PCEST
         WHERE CODPROD = PCPEDI.CODPROD
           AND CODFILIAL = NVL(PCPEDI.CODFILIALRETIRA,:CODFILIAL)) 
 >= (SELECT pcest.qtpendente FROM pcest WHERE codprod = pcpedi.codprod AND codfilial = nvl(pcpedi.codfilialretira, :CODFILIAL)) 
then 
      (select(  PKG_ESTOQUE.ESTOQUE_DISPONIVEL(PCPEDI.CODPROD,NVL(PCPEDI.CODFILIALRETIRA,:CODFILIAL),'VA',null)
                        )
          FROM PCEST
         WHERE CODPROD = PCPEDI.CODPROD
           AND CODFILIAL = NVL(PCPEDI.CODFILIALRETIRA,:CODFILIAL))  
    + CASE WHEN PCPEDI.POSICAO IN ('P','B') THEN 
      DECODE(NVL(FERRAMENTAS.F_BUSCARPARAMETRO_ALFA('BLOQUEIAVENDAESTPENDENTE', nvl(pcpedi.codfilialretira, :CODFILIAL),
:CONSUMBLOQUEIAVENDAESTPENDENTE ),:CONSUMBLOQUEIAVENDAESTPENDENTE), 'S', PCPEDI.QT, 0) ELSE 0 END 
 else 
      (select(PKG_ESTOQUE.ESTOQUE_DISPONIVEL(PCPEDI.CODPROD,NVL(PCPEDI.CODFILIALRETIRA,:CODFILIAL),'VP',null)
                        )
          FROM PCEST
         WHERE CODPROD = PCPEDI.CODPROD
           AND CODFILIAL = NVL(PCPEDI.CODFILIALRETIRA,:CODFILIAL)) 
 END 
       ,0) QTDISPONIVEL,
       PCPEDI.QTFALTA,
       PCPEDI.NOMECONCORRENTE,
       PCPEDI.CODST,
       PCPEDI.VLCUSTOFIN,
       PCPEDI.VLCUSTOREAL,
       NVL(PCPEDI.STPTABELA, 0) STPTABELA, 
       NVL(PCPEDI.VLIPIPTABELA, 0) VLIPIPTABELA, 
       nvl(PCPEDI.ST,0) ST,
       nvl(PCPEDI.STCLIENTEGNRE,0) STCLIENTEGNRE,
       PCPEDI.PORIGINAL,
       PCPEDI.PERCIPI,
       nvl(PCPEDI.VLIPI,0) VLIPI,
       PCPEDI.CUSTOFINEST,
       PCPEDI.IVA,
       PCPEDI.PAUTA,
       PCPEDI.ALIQICMS1,
       PCPEDI.ALIQICMS2,
       PCPEDI.VLDESCSUFRAMA,
       PCPEDI.PERDESC,
       PCPEDI.PERCOM,
       DECODE(:ABATERIMPOSTOSCOMISSAORCA,
              'N',(ROUND((PCPEDI.QT * PCPEDI.PVENDA) * (NVL(PCPEDI.PERCOM, 0) / 100),2))
                   ,(ROUND((PCPEDI.QT *
                                        (PCPEDI.PVENDA - (DECODE(FERRAMENTAS.F_BUSCARPARAMETRO_ALFA('IMPOSTOCOMISSAORCA',
PCPEDC.CODFILIAL,'A'),
                                                                 'A', (NVL(PCPEDI.ST,0) + NVL(PCPEDI.VLIPI,0) + 
NVL(PCPEDI.STCLIENTEGNRE,0) + NVL(PCPEDI.VLISS,0)),
                                                                 'I', (NVL(PCPEDI.VLIPI,0) + NVL(PCPEDI.VLISS,0)),
                                                                 'S', (NVL(PCPEDI.ST,0) + NVL(PCPEDI.STCLIENTEGNRE,0) + 
NVL(PCPEDI.VLISS,0)),
                                                                 0))
                                         ) *
              (NVL(PCPEDI.PERCOM, 0) / 100)),2))) VALOR_COMISSAO,
       PCPRODUT.CODFAB,
       PCPEDI.PERCBASEREDST,
       PCPEDI.PERCBASEREDSTFONTE,
       PCPEDI.PERFRETECMV,
       PCPEDI.NUMCAR,
       PCPEDI.PERCISS,
       nvl(PCPEDI.VLISS,0) VLISS,
       PCPEDI.PVENDABASE,
       NVL(PCPEDI.PBASERCA, PCPEDI.PTABELA) PBASERCA
       ,PCPEDI.VLVERBACMV
       ,NUMVERBAREBCMV
       ,PCPEDI.BASEICST
       ,PCPEDI.QTCX
       ,PCPEDI.QTPECAS, 
       PCPEDI.NUMITEMPED, 
        NVL(PCPRODUT.TIPOESTOQUE,'PA') TIPOESTOQUE 
       ,PCPRODUT.UNIDADEMASTER, 
        GET_PRODUTO_PESO(PCPEDI.CODPROD, NVL(PCPEDI.CODFILIALRETIRA, :CODFILIAL)) PESOBRUTOMASTER, 
        GET_PRODUTO_PECA(PCPEDI.CODPROD, NVL(PCPEDI.CODFILIALRETIRA, :CODFILIAL)) PESOPECA, 
        PCPRODUT.PESOBRUTO
       ,PCPEDI.LETRACOMISS
       ,PCPEDI.VLCUSTOCONT
       ,PCPEDI.VLCUSTOREP
       ,PCPRODUT.DV
       ,NVL(PCPEDI.CODFILIALRETIRA, :CODFILIAL) CODFILIALRETIRA
       ,PCPEDI.VLDESCICMISENCAO
       ,PCPEDI.PERDESCISENTOICMS
       ,PCPEDI.CODAUXILIAR
       ,NVL(PCPRODUT.TIPOMERC, 'L') TIPOMERC
       ,PCPEDI.VLVERBACMVCLI
       ,PCPRODUT.CODEPTO
       ,PCPRODUT.CODSEC
       ,PCPEDI.PVENDA1
       ,PCPEDI.COMPLEMENTO
       ,PCPEDI.TXVENDA
       ,PCPEDI.PERDESCCUSTO
       ,PCPEDI.CODICMTAB
       ,PCPEDI.VLDESCCUSTOCMV
       ,NVL(PCPRODUT.ChecarMultiploVendaBNF, 'S') ChecarMultiploVendaBNF
       ,NVL(PCPEDI.QTNAOCOMPRA, 0) QTNAOCOMPRA
        ,PCPEDI.PERCDIFALIQUOTAS
        ,PCPEDI.BASEDIFALIQUOTAS
        ,PCPEDI.VLDIFALIQUOTAS
        ,PCPEDI.PRODDESCRICAOCONTRATO
        ,(select GREATEST(PCEST.QTEST,0) from PCEST where PCEST.CODPROD = PCPEDI.CODPROD and PCEST.CODFILIAL = 
NVL(PCPEDI.CODFILIALRETIRA, :CODFILIAL)) QTEST
        ,(select GREATEST(PCEST.QTRESERV,0) from PCEST where PCEST.CODPROD = PCPEDI.CODPROD and PCEST.CODFILIAL = 
NVL(PCPEDI.CODFILIALRETIRA, :CODFILIAL)) QTRESERV
        ,(select GREATEST(PCEST.QTBLOQUEADA,0) from PCEST where PCEST.CODPROD = PCPEDI.CODPROD and PCEST.CODFILIAL = 
NVL(PCPEDI.CODFILIALRETIRA, :CODFILIAL)) QTBLOQUEADA
        ,PCPEDI.CODFUNCULTALTER
        ,PCPEDI.ROTINAULTLALTER
        ,PCPEDI.DTULTLALTER
        ,PCPEDI.CODFUNCLANC
        ,PCPEDI.ROTINALANC
        ,PCPEDI.DTLANC
        ,PCPEDI.POLITICAPRIORITARIA
        ,PCPEDI.TIPOENTREGA
        ,DECODE((SELECT COUNT(*)
                   FROM PCRESTRICAODESCVALOR
                  WHERE PCRESTRICAODESCVALOR.CODPROD = PCPRODUT.CODPROD
                    AND ((PCRESTRICAODESCVALOR.CODFILIAL = :CODFILIAL) OR
                         (PCRESTRICAODESCVALOR.CODFILIAL IS NULL))
                    AND ((PCRESTRICAODESCVALOR.NUMREGIAO = :NUMREGIAO) OR
                         (PCRESTRICAODESCVALOR.NUMREGIAO IS NULL)))
                ,0,0,1) ProdutoPolDeptoSec
        ,PCPEDI.QTUNITEMB
        ,PCPEDI.QTUNITCX
        ,pcpedi.percdescpis
        ,pcpedi.vldescreducaopis
        ,pcpedi.percdesccofins
        ,pcpedi.vldescreducaocofins
        ,pcpedi.percom2
        ,pcpedi.percom3
        ,pcpedi.percom4
        ,(SELECT pcmarca.marca
            FROM pcmarca
           WHERE pcmarca.codmarca = pcprodut.codmarca) marca
        ,NVL(pcpedi.Brinde, 'N') Brinde
        ,NVL(pcpedi.truncaritem, 'N') truncaritem
        ,pcpedi.coddesconto
        ,pcpedi.CODDESCONTOBASERCA
        ,pcpedi.codcombo
     ,CASE WHEN NVL(PCPEDC.VLATEND, 0) = 0 THEN -100 ELSE
     DECODE (NVL (pcpedi.pvenda, 0)
                   ,0, 0
                   ,ROUND (  ((pcpedi.pvenda - pcpedi.vlcustofin) / pcpedi.pvenda
                             )
                           * 100
                          ,2)
                   ) END AS clperlucro
        ,pcpedi.vlredcmvsimplesnac
        ,pcpedi.vlredpvendasimplesna
        ,pcpedi.PerBonific
        ,pcpedi.VLBONIFIC
        ,pcpedi.PerDescCom
        ,pcpedi.VlDescCom
        ,pcpedi.VlRepasse
        ,pcpedi.VlOutros
        ,PCPEDI.PERCDESCABATIMENTO
        ,PCPEDI.VLDESCABATIMENTO
        ,PCPEDI.NUMERORECOPI
        ,PCPEDI.USAUNIDADEMASTER
        ,PCPEDI.VLRMOEDAESTRAGEIRA
        ,PCPEDI.CODMOEDAESTRAGEIRA
        ,DECODE ((SELECT COUNT (1) 
          FROM pcprodfilial 
                 WHERE codprod = pcprodut.codprod 
                   AND codfilial = NVL(PCPEDI.CODFILIALRETIRA, :CODFILIAL)) 
              ,0, 'N' 
              , (SELECT NVL (utilizaqtdesupmultipla, 'N') 
                   FROM pcprodfilial 
                  WHERE codprod = pcprodut.codprod 
                    AND codfilial = NVL(PCPEDI.CODFILIALRETIRA, :CODFILIAL)) 
              ) utilizaqtdesupmultipla 
         , PCPEDI.PERDESCPAUTA 
         , PCPEDI.ORIGEMST 
         , PCPEDI.PERCREDALIQIPI 
         , NVL(PCPEDI.BONIFIC,'N') BONIFIC 
         , NVL(PCPEDI.PBONIFIC, 0) PBONIFIC  
         , PCPEDI.ALIQFCP                    
         , PCPEDI.ALIQINTERNADEST            
         , PCPEDI.VLFCPPART                  
         , PCPEDI.VLICMSPARTDEST             
         , PCPEDI.VLICMSPART                 
         , PCPEDI.PERCPROVPART               
         , PCPEDI.VLICMSDIFALIQPART          
         , PCPEDI.PERCBASEREDPART            
         , PCPEDI.VLICMSPARTREM              
         , PCPEDI.ALIQINTERORIGPART          
         , PCPEDI.VLBASEPARTDEST             
         , PCPEDI.CODFIGVENDATRIANGULAR      
         , PCPEDI.CODDESCONTOSIMULADOR       
         , PCPEDI.CODFISCAL                  
         , PCPEDI.SITTRIBUT                  
         , PCPEDI.PTABELAFABRICAZFM          
         , PCPEDI.ORIGMERCTRIB               
         , PCPEDI.VLDESCCARCACA              
         , PCPEDI.DEVOLUCAOCARCACA           
         , pcprodut.ACEITATROCAINSERVIVEL    
         , pcprodut.CODINSERVIVEL            
         , PCPEDI.NUMDRAWBACK                
         , PCPEDI.NUMCHAVEEXP                
         , PCPEDI.NUMREGEXP                  
         , PCPEDI.CODEMITENTEITEMPEDIDO      
         , PCPEDI.VLBASEFCPST      
         , PCPEDI.ALIQICMSFECP      
         , PCPEDI.VLFECP      
         , PCPEDI.UTILIZOUMOTORCALCULO 
         , PCPEDI.QTEMBALAGEM 
         , PCPEDI.CODPRECOFIXO 
         , PCPEDI.CODPRECOCESTA 
         , NVL(PCPRODUT.PSICOTROPICO,'N') PSICOTROPICO 
         , PCPEDI.NUMPEDCLI                  
         , PCPRODUT.CLASSE   
         , PCPRODUT.CODMARCA 
         , PCPEDI.VLBASEFCPICMS 
 FROM PCPEDI, PCPRODUT, PCEMBALAGEM, PCPEDC
WHERE PCPEDI.CODPROD     = PCPRODUT.CODPROD
  AND PCPEDI.NUMPED      = :NUMPED
  AND PCPEDI.NUMPED      = PCPEDC.NUMPED
  AND PCPEDI.CODPROD     = PCEMBALAGEM.CODPROD(+)
  AND PCPEDI.CODAUXILIAR = PCEMBALAGEM.CODAUXILIAR(+)
  AND DECODE(NVL(PCPEDC.UTILIZAVENDAPOREMBALAGEM, 'X'),
          'X',
          DECODE((SELECT NVL(PCFILIAL.UTILIZAVENDAPOREMBALAGEM,
                            PCCONSUM.UTILIZAVENDAPOREMBALAGEM)
                   FROM PCFILIAL, PCCONSUM
                  WHERE PCFILIAL.CODIGO = PCPEDC.CODFILIAL),
                 'S',
                 PCEMBALAGEM.CODFILIAL,
                 PCPEDC.CODFILIAL),
          'S',
          PCEMBALAGEM.CODFILIAL,
          '99') =
   DECODE(NVL(PCPEDC.UTILIZAVENDAPOREMBALAGEM, 'X'),
          'X',
          DECODE((SELECT NVL(PCFILIAL.UTILIZAVENDAPOREMBALAGEM,
                            PCCONSUM.UTILIZAVENDAPOREMBALAGEM)
                   FROM PCFILIAL, PCCONSUM
                  WHERE PCFILIAL.CODIGO = PCPEDC.CODFILIAL),
                 'S',
                 NVL(PCPEDI.CODFILIALRETIRA, PCPEDC.CODFILIAL),
                 PCPEDC.CODFILIAL),
          'S',
CASE WHEN ((:USAESTOQUEDEPFECHADO = 'S') AND 
           (:UTILIZAEMBALAGEMFILIALRETIRA = 'S')) THEN 
  PCPEDC.CODFILIAL ELSE NVL(PCPEDI.CODFILIALRETIRA, PCPEDC.CODFILIAL) END 
  , '99') 
 AND PCPEDI.POSICAO NOT IN ('C')
 AND 1 = 1
ORDER BY clPERLUCRO
UTILIZAVENDAPOREMBALAGEM = 'N'
CODFILIAL = '2'
NUMREGIAO = 15
NUMPED = 791011572
USAESTOQUEDEPFECHADO = 'N'
CONSUMBLOQUEIAVENDAESTPENDENTE = 'N'
ABATERIMPOSTOSCOMISSAORCA = 'S'
UTILIZAEMBALAGEMFILIALRETIRA = 'N'
----------------------------------
Timestamp: 10:20:12.525
SELECT DISTINCT I.CODPROD                 
               ,I.NUMPED                  
               ,I.CODDESCONTOSIMULADOR    
               ,I.PERDESC                 
  FROM PCPEDI I                           
 WHERE NVL(I.CODDESCONTOSIMULADOR, 0) > 0 
AND (I.NUMPED IN ( 791011572,791011573,791011574,791011575,1155001749,1233001199,1250001390,1250001391,1250001392,1250001393,
1250001394,1250001395,1250001396,1251001773,1251001774,1251001775,1257002346,1257002347,1257002348,1257002349,1257002350,
1275002219,1275002220,1275002221,1275002222,1338000694,1338000695,1338000696,1417000606,1417000607,1417000608,1417000609,
1422000345,1432000305,1432000306,1432000307,1439000148,1439000149,1439000150,1439000151,1443000063,1450000128 ))
----------------------------------
Timestamp: 10:20:12.701
SELECT DISTINCT
       PCPEDI.NUMPED,
       PCPEDI.CODPROD,
       PCPEDI.CODCONTRATO,
       PCPEDI.QTLITRAGEM,
       PCPRODUT.DESCRICAO,
       PCPRODUT.NumOriginal,
       PCPEDI.GERAGNRE_CNPJCLIENTE,
       PCPEDI.CODUSUR,
       PCPEDI.CODCLI,
       NVL(PCPEDI.DTCONSOLIDACAOAUXPRO, PCPEDI.DATA) DTCONSOLIDACAOAUXPRO,
       PCPEDI.DATA,
       PCPEDI.NUMPED,
       PCPEDI.NUMPEDRAS,
       PCPEDI.NUMSEQRAS,
       PCPEDI.EANCODPROD,
       ROUND(PCPEDI.QT * PCPEDI.PVENDA,2) VLTOTAL,
       PCPRODUT.CODFORNEC,
       PCPRODUT.EMBALAGEMMASTER DESCEMBALAGEMMASTER,
       PCPRODUT.descricao7,
       PCPEDI.DESCPRECOFAB,
       PCPEDI.PRECOMAXCONSUM,
       Decode(:UTILIZAVENDAPOREMBALAGEM,'S',PCEMBALAGEM.EMBALAGEM, PCPRODUT.EMBALAGEM) EMBALAGEM,
       Decode(:UTILIZAVENDAPOREMBALAGEM,'S',NVL(PCEMBALAGEM.QTUNIT,1), NVL(PCPRODUT.QTUNIT,1)) QTUNIT,
       PCPEDI.NUMSEQ,
       PCPRODUT.UNIDADE,
       DECODE((SELECT COUNT ( * )
                 FROM pcprodfilial
                WHERE codprod = PCPRODUT.CODPROD
                  AND codfilial = :CODFILIAL),0,DECODE(NVL(PCPRODUT.MULTIPLO, 0),0,1,PCPRODUT.MULTIPLO),
          NVL((SELECT MULTIPLO
                 FROM pcprodfilial
                WHERE codprod = PCPRODUT.CODPROD
                  AND codfilial = :CODFILIAL), DECODE(NVL(PCPRODUT.MULTIPLO, 0),0,1,PCPRODUT.MULTIPLO))) MULTIPLO,
       PCPEDI.POSICAO,
       NVL(PCPEDI.QT,0) QT,
       NVL(PCPEDI.PVENDA,0) PVENDA,
       NVL(PCPEDI.PTABELA,0) PTABELA,
 greatest( 
 case when  
       (select(PKG_ESTOQUE.ESTOQUE_DISPONIVEL(PCPEDI.CODPROD,NVL(PCPEDI.CODFILIALRETIRA,:CODFILIAL),'VP',null)
                        )
          FROM PCEST
         WHERE CODPROD = PCPEDI.CODPROD
           AND CODFILIAL = NVL(PCPEDI.CODFILIALRETIRA,:CODFILIAL)) 
 >= (SELECT pcest.qtpendente FROM pcest WHERE codprod = pcpedi.codprod AND codfilial = nvl(pcpedi.codfilialretira, :CODFILIAL)) 
then 
      (select(  PKG_ESTOQUE.ESTOQUE_DISPONIVEL(PCPEDI.CODPROD,NVL(PCPEDI.CODFILIALRETIRA,:CODFILIAL),'VA',null)
                        )
          FROM PCEST
         WHERE CODPROD = PCPEDI.CODPROD
           AND CODFILIAL = NVL(PCPEDI.CODFILIALRETIRA,:CODFILIAL))  
    + CASE WHEN PCPEDI.POSICAO IN ('P','B') THEN 
      DECODE(NVL(FERRAMENTAS.F_BUSCARPARAMETRO_ALFA('BLOQUEIAVENDAESTPENDENTE', nvl(pcpedi.codfilialretira, :CODFILIAL),
:CONSUMBLOQUEIAVENDAESTPENDENTE ),:CONSUMBLOQUEIAVENDAESTPENDENTE), 'S', PCPEDI.QT, 0) ELSE 0 END 
 else 
      (select(PKG_ESTOQUE.ESTOQUE_DISPONIVEL(PCPEDI.CODPROD,NVL(PCPEDI.CODFILIALRETIRA,:CODFILIAL),'VP',null)
                        )
          FROM PCEST
         WHERE CODPROD = PCPEDI.CODPROD
           AND CODFILIAL = NVL(PCPEDI.CODFILIALRETIRA,:CODFILIAL)) 
 END 
       ,0) QTDISPONIVEL,
       PCPEDI.QTFALTA,
       PCPEDI.NOMECONCORRENTE,
       PCPEDI.CODST,
       PCPEDI.VLCUSTOFIN,
       PCPEDI.VLCUSTOREAL,
       NVL(PCPEDI.STPTABELA, 0) STPTABELA, 
       NVL(PCPEDI.VLIPIPTABELA, 0) VLIPIPTABELA, 
       nvl(PCPEDI.ST,0) ST,
       nvl(PCPEDI.STCLIENTEGNRE,0) STCLIENTEGNRE,
       PCPEDI.PORIGINAL,
       PCPEDI.PERCIPI,
       nvl(PCPEDI.VLIPI,0) VLIPI,
       PCPEDI.CUSTOFINEST,
       PCPEDI.IVA,
       PCPEDI.PAUTA,
       PCPEDI.ALIQICMS1,
       PCPEDI.ALIQICMS2,
       PCPEDI.VLDESCSUFRAMA,
       PCPEDI.PERDESC,
       PCPEDI.PERCOM,
       DECODE(:ABATERIMPOSTOSCOMISSAORCA,
              'N',(ROUND((PCPEDI.QT * PCPEDI.PVENDA) * (NVL(PCPEDI.PERCOM, 0) / 100),2))
                   ,(ROUND((PCPEDI.QT *
                                        (PCPEDI.PVENDA - (DECODE(FERRAMENTAS.F_BUSCARPARAMETRO_ALFA('IMPOSTOCOMISSAORCA',
PCPEDC.CODFILIAL,'A'),
                                                                 'A', (NVL(PCPEDI.ST,0) + NVL(PCPEDI.VLIPI,0) + 
NVL(PCPEDI.STCLIENTEGNRE,0) + NVL(PCPEDI.VLISS,0)),
                                                                 'I', (NVL(PCPEDI.VLIPI,0) + NVL(PCPEDI.VLISS,0)),
                                                                 'S', (NVL(PCPEDI.ST,0) + NVL(PCPEDI.STCLIENTEGNRE,0) + 
NVL(PCPEDI.VLISS,0)),
                                                                 0))
                                         ) *
              (NVL(PCPEDI.PERCOM, 0) / 100)),2))) VALOR_COMISSAO,
       PCPRODUT.CODFAB,
       PCPEDI.PERCBASEREDST,
       PCPEDI.PERCBASEREDSTFONTE,
       PCPEDI.PERFRETECMV,
       PCPEDI.NUMCAR,
       PCPEDI.PERCISS,
       nvl(PCPEDI.VLISS,0) VLISS,
       PCPEDI.PVENDABASE,
       NVL(PCPEDI.PBASERCA, PCPEDI.PTABELA) PBASERCA
       ,PCPEDI.VLVERBACMV
       ,NUMVERBAREBCMV
       ,PCPEDI.BASEICST
       ,PCPEDI.QTCX
       ,PCPEDI.QTPECAS, 
       PCPEDI.NUMITEMPED, 
        NVL(PCPRODUT.TIPOESTOQUE,'PA') TIPOESTOQUE 
       ,PCPRODUT.UNIDADEMASTER, 
        GET_PRODUTO_PESO(PCPEDI.CODPROD, NVL(PCPEDI.CODFILIALRETIRA, :CODFILIAL)) PESOBRUTOMASTER, 
        GET_PRODUTO_PECA(PCPEDI.CODPROD, NVL(PCPEDI.CODFILIALRETIRA, :CODFILIAL)) PESOPECA, 
        PCPRODUT.PESOBRUTO
       ,PCPEDI.LETRACOMISS
       ,PCPEDI.VLCUSTOCONT
       ,PCPEDI.VLCUSTOREP
       ,PCPRODUT.DV
       ,NVL(PCPEDI.CODFILIALRETIRA, :CODFILIAL) CODFILIALRETIRA
       ,PCPEDI.VLDESCICMISENCAO
       ,PCPEDI.PERDESCISENTOICMS
       ,PCPEDI.CODAUXILIAR
       ,NVL(PCPRODUT.TIPOMERC, 'L') TIPOMERC
       ,PCPEDI.VLVERBACMVCLI
       ,PCPRODUT.CODEPTO
       ,PCPRODUT.CODSEC
       ,PCPEDI.PVENDA1
       ,PCPEDI.COMPLEMENTO
       ,PCPEDI.TXVENDA
       ,PCPEDI.PERDESCCUSTO
       ,PCPEDI.CODICMTAB
       ,PCPEDI.VLDESCCUSTOCMV
       ,NVL(PCPRODUT.ChecarMultiploVendaBNF, 'S') ChecarMultiploVendaBNF
       ,NVL(PCPEDI.QTNAOCOMPRA, 0) QTNAOCOMPRA
        ,PCPEDI.PERCDIFALIQUOTAS
        ,PCPEDI.BASEDIFALIQUOTAS
        ,PCPEDI.VLDIFALIQUOTAS
        ,PCPEDI.PRODDESCRICAOCONTRATO
        ,(select GREATEST(PCEST.QTEST,0) from PCEST where PCEST.CODPROD = PCPEDI.CODPROD and PCEST.CODFILIAL = 
NVL(PCPEDI.CODFILIALRETIRA, :CODFILIAL)) QTEST
        ,(select GREATEST(PCEST.QTRESERV,0) from PCEST where PCEST.CODPROD = PCPEDI.CODPROD and PCEST.CODFILIAL = 
NVL(PCPEDI.CODFILIALRETIRA, :CODFILIAL)) QTRESERV
        ,(select GREATEST(PCEST.QTBLOQUEADA,0) from PCEST where PCEST.CODPROD = PCPEDI.CODPROD and PCEST.CODFILIAL = 
NVL(PCPEDI.CODFILIALRETIRA, :CODFILIAL)) QTBLOQUEADA
        ,PCPEDI.CODFUNCULTALTER
        ,PCPEDI.ROTINAULTLALTER
        ,PCPEDI.DTULTLALTER
        ,PCPEDI.CODFUNCLANC
        ,PCPEDI.ROTINALANC
        ,PCPEDI.DTLANC
        ,PCPEDI.POLITICAPRIORITARIA
        ,PCPEDI.TIPOENTREGA
        ,DECODE((SELECT COUNT(*)
                   FROM PCRESTRICAODESCVALOR
                  WHERE PCRESTRICAODESCVALOR.CODPROD = PCPRODUT.CODPROD
                    AND ((PCRESTRICAODESCVALOR.CODFILIAL = :CODFILIAL) OR
                         (PCRESTRICAODESCVALOR.CODFILIAL IS NULL))
                    AND ((PCRESTRICAODESCVALOR.NUMREGIAO = :NUMREGIAO) OR
                         (PCRESTRICAODESCVALOR.NUMREGIAO IS NULL)))
                ,0,0,1) ProdutoPolDeptoSec
        ,PCPEDI.QTUNITEMB
        ,PCPEDI.QTUNITCX
        ,pcpedi.percdescpis
        ,pcpedi.vldescreducaopis
        ,pcpedi.percdesccofins
        ,pcpedi.vldescreducaocofins
        ,pcpedi.percom2
        ,pcpedi.percom3
        ,pcpedi.percom4
        ,(SELECT pcmarca.marca
            FROM pcmarca
           WHERE pcmarca.codmarca = pcprodut.codmarca) marca
        ,NVL(pcpedi.Brinde, 'N') Brinde
        ,NVL(pcpedi.truncaritem, 'N') truncaritem
        ,pcpedi.coddesconto
        ,pcpedi.CODDESCONTOBASERCA
        ,pcpedi.codcombo
     ,CASE WHEN NVL(PCPEDC.VLATEND, 0) = 0 THEN -100 ELSE
     DECODE (NVL (pcpedi.pvenda, 0)
                   ,0, 0
                   ,ROUND (  ((pcpedi.pvenda - pcpedi.vlcustofin) / pcpedi.pvenda
                             )
                           * 100
                          ,2)
                   ) END AS clperlucro
        ,pcpedi.vlredcmvsimplesnac
        ,pcpedi.vlredpvendasimplesna
        ,pcpedi.PerBonific
        ,pcpedi.VLBONIFIC
        ,pcpedi.PerDescCom
        ,pcpedi.VlDescCom
        ,pcpedi.VlRepasse
        ,pcpedi.VlOutros
        ,PCPEDI.PERCDESCABATIMENTO
        ,PCPEDI.VLDESCABATIMENTO
        ,PCPEDI.NUMERORECOPI
        ,PCPEDI.USAUNIDADEMASTER
        ,PCPEDI.VLRMOEDAESTRAGEIRA
        ,PCPEDI.CODMOEDAESTRAGEIRA
        ,DECODE ((SELECT COUNT (1) 
          FROM pcprodfilial 
                 WHERE codprod = pcprodut.codprod 
                   AND codfilial = NVL(PCPEDI.CODFILIALRETIRA, :CODFILIAL)) 
              ,0, 'N' 
              , (SELECT NVL (utilizaqtdesupmultipla, 'N') 
                   FROM pcprodfilial 
                  WHERE codprod = pcprodut.codprod 
                    AND codfilial = NVL(PCPEDI.CODFILIALRETIRA, :CODFILIAL)) 
              ) utilizaqtdesupmultipla 
         , PCPEDI.PERDESCPAUTA 
         , PCPEDI.ORIGEMST 
         , PCPEDI.PERCREDALIQIPI 
         , NVL(PCPEDI.BONIFIC,'N') BONIFIC 
         , NVL(PCPEDI.PBONIFIC, 0) PBONIFIC  
         , PCPEDI.ALIQFCP                    
         , PCPEDI.ALIQINTERNADEST            
         , PCPEDI.VLFCPPART                  
         , PCPEDI.VLICMSPARTDEST             
         , PCPEDI.VLICMSPART                 
         , PCPEDI.PERCPROVPART               
         , PCPEDI.VLICMSDIFALIQPART          
         , PCPEDI.PERCBASEREDPART            
         , PCPEDI.VLICMSPARTREM              
         , PCPEDI.ALIQINTERORIGPART          
         , PCPEDI.VLBASEPARTDEST             
         , PCPEDI.CODFIGVENDATRIANGULAR      
         , PCPEDI.CODDESCONTOSIMULADOR       
         , PCPEDI.CODFISCAL                  
         , PCPEDI.SITTRIBUT                  
         , PCPEDI.PTABELAFABRICAZFM          
         , PCPEDI.ORIGMERCTRIB               
         , PCPEDI.VLDESCCARCACA              
         , PCPEDI.DEVOLUCAOCARCACA           
         , pcprodut.ACEITATROCAINSERVIVEL    
         , pcprodut.CODINSERVIVEL            
         , PCPEDI.NUMDRAWBACK                
         , PCPEDI.NUMCHAVEEXP                
         , PCPEDI.NUMREGEXP                  
         , PCPEDI.CODEMITENTEITEMPEDIDO      
         , PCPEDI.VLBASEFCPST      
         , PCPEDI.ALIQICMSFECP      
         , PCPEDI.VLFECP      
         , PCPEDI.UTILIZOUMOTORCALCULO 
         , PCPEDI.QTEMBALAGEM 
         , PCPEDI.CODPRECOFIXO 
         , PCPEDI.CODPRECOCESTA 
         , NVL(PCPRODUT.PSICOTROPICO,'N') PSICOTROPICO 
         , PCPEDI.NUMPEDCLI                  
         , PCPRODUT.CLASSE   
         , PCPRODUT.CODMARCA 
         , PCPEDI.VLBASEFCPICMS 
 FROM PCPEDI, PCPRODUT, PCEMBALAGEM, PCPEDC
WHERE PCPEDI.CODPROD     = PCPRODUT.CODPROD
  AND PCPEDI.NUMPED      = :NUMPED
  AND PCPEDI.NUMPED      = PCPEDC.NUMPED
  AND PCPEDI.CODPROD     = PCEMBALAGEM.CODPROD(+)
  AND PCPEDI.CODAUXILIAR = PCEMBALAGEM.CODAUXILIAR(+)
  AND DECODE(NVL(PCPEDC.UTILIZAVENDAPOREMBALAGEM, 'X'),
          'X',
          DECODE((SELECT NVL(PCFILIAL.UTILIZAVENDAPOREMBALAGEM,
                            PCCONSUM.UTILIZAVENDAPOREMBALAGEM)
                   FROM PCFILIAL, PCCONSUM
                  WHERE PCFILIAL.CODIGO = PCPEDC.CODFILIAL),
                 'S',
                 PCEMBALAGEM.CODFILIAL,
                 PCPEDC.CODFILIAL),
          'S',
          PCEMBALAGEM.CODFILIAL,
          '99') =
   DECODE(NVL(PCPEDC.UTILIZAVENDAPOREMBALAGEM, 'X'),
          'X',
          DECODE((SELECT NVL(PCFILIAL.UTILIZAVENDAPOREMBALAGEM,
                            PCCONSUM.UTILIZAVENDAPOREMBALAGEM)
                   FROM PCFILIAL, PCCONSUM
                  WHERE PCFILIAL.CODIGO = PCPEDC.CODFILIAL),
                 'S',
                 NVL(PCPEDI.CODFILIALRETIRA, PCPEDC.CODFILIAL),
                 PCPEDC.CODFILIAL),
          'S',
CASE WHEN ((:USAESTOQUEDEPFECHADO = 'S') AND 
           (:UTILIZAEMBALAGEMFILIALRETIRA = 'S')) THEN 
  PCPEDC.CODFILIAL ELSE NVL(PCPEDI.CODFILIALRETIRA, PCPEDC.CODFILIAL) END 
  , '99') 
 AND PCPEDI.POSICAO NOT IN ('C')
 AND 1 = 1
ORDER BY clPERLUCRO
UTILIZAVENDAPOREMBALAGEM = 'N'
CODFILIAL = '2'
CONSUMBLOQUEIAVENDAESTPENDENTE = <NULL>
ABATERIMPOSTOSCOMISSAORCA = <NULL>
NUMREGIAO = 15
NUMPED = 791011572
USAESTOQUEDEPFECHADO = 'N'
UTILIZAEMBALAGEMFILIALRETIRA = <NULL>
----------------------------------
Timestamp: 10:20:13.267
SELECT PARAMFILIAL.OBTERCOMOVARCHAR2('VENDAPORGRADE', '2')
  FROM DUAL
----------------------------------
Timestamp: 10:20:13.287
SELECT PARAMFILIAL.OBTERCOMOVARCHAR2('FIL_INCLUIFRETEOUTRASDESPBASEST', '2')
  FROM DUAL
----------------------------------
Timestamp: 10:20:13.365
SELECT PARAMFILIAL.OBTERCOMOVARCHAR2('USAABATIMENTO', '2')
  FROM DUAL
----------------------------------
Timestamp: 10:20:13.388
SELECT PARAMFILIAL.OBTERCOMOVARCHAR2('INCLUIDESPRODAPENFALT', '99')
  FROM DUAL
----------------------------------
Timestamp: 10:20:13.402
SELECT PARAMFILIAL.OBTERCOMOVARCHAR2('MOEDAESTRAORCAPEDIDO', '2')
  FROM DUAL
----------------------------------
Timestamp: 10:20:13.434
SELECT COUNT(1) QT                                   
  FROM PCDESCONTO C                                  
 WHERE C.TIPO = 'S'                                
   AND TRUNC(SYSDATE) BETWEEN C.DTINICIO AND C.DTFIM
