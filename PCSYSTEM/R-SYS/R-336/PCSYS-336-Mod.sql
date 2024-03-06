
SELECT PCPEDI.NUMPED,
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
       Decode('N','S',PCEMBALAGEM.EMBALAGEM, PCPRODUT.EMBALAGEM) EMBALAGEM,
       Decode('N','S',NVL(PCEMBALAGEM.QTUNIT,1), NVL(PCPRODUT.QTUNIT,1)) QTUNIT,
       PCPEDI.NUMSEQ,
       PCPRODUT.UNIDADE,
       DECODE((SELECT COUNT ( * )
                 FROM pcprodfilial
                WHERE codprod = PCPRODUT.CODPROD
                  AND codfilial = '2'),0,DECODE(NVL(PCPRODUT.MULTIPLO, 0),0,1,PCPRODUT.MULTIPLO),
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
       (select(PKG_ESTOQUE.ESTOQUE_DISPONIVEL(PCPEDI.CODPROD,NVL(PCPEDI.CODFILIALRETIRA,'2'),'VP',null)
                        )
          FROM PCEST
         WHERE CODPROD = PCPEDI.CODPROD
           AND CODFILIAL = NVL(PCPEDI.CODFILIALRETIRA,:CODFILIAL)) 
 >= (SELECT pcest.qtpendente FROM pcest WHERE codprod = pcpedi.codprod AND codfilial = nvl(pcpedi.codfilialretira, '2')) 
then 
      (select(  PKG_ESTOQUE.ESTOQUE_DISPONIVEL(PCPEDI.CODPROD,NVL(PCPEDI.CODFILIALRETIRA,'2'),'VA',null)
                        )
          FROM PCEST
         WHERE CODPROD = PCPEDI.CODPROD
           AND CODFILIAL = NVL(PCPEDI.CODFILIALRETIRA,'2'))  
    + CASE WHEN PCPEDI.POSICAO IN ('P','B') THEN 
      DECODE(NVL(FERRAMENTAS.F_BUSCARPARAMETRO_ALFA('BLOQUEIAVENDAESTPENDENTE', nvl(pcpedi.codfilialretira, '2'),
:CONSUMBLOQUEIAVENDAESTPENDENTE ),:CONSUMBLOQUEIAVENDAESTPENDENTE), 'S', PCPEDI.QT, 0) ELSE 0 END 
 else 
      (select(PKG_ESTOQUE.ESTOQUE_DISPONIVEL(PCPEDI.CODPROD,NVL(PCPEDI.CODFILIALRETIRA,:CODFILIAL),'VP',null)
                        )
          FROM PCEST
         WHERE CODPROD = PCPEDI.CODPROD
           AND CODFILIAL = NVL(PCPEDI.CODFILIALRETIRA,'2')) 
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
       DECODE(NULL,
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
        GET_PRODUTO_PESO(PCPEDI.CODPROD, NVL(PCPEDI.CODFILIALRETIRA, '2')) PESOBRUTOMASTER, 
        GET_PRODUTO_PECA(PCPEDI.CODPROD, NVL(PCPEDI.CODFILIALRETIRA, '2')) PESOPECA, 
        PCPRODUT.PESOBRUTO
       ,PCPEDI.LETRACOMISS
       ,PCPEDI.VLCUSTOCONT
       ,PCPEDI.VLCUSTOREP
       ,PCPRODUT.DV
       ,NVL(PCPEDI.CODFILIALRETIRA, '2') CODFILIALRETIRA
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
NVL(PCPEDI.CODFILIALRETIRA, '2')) QTEST
        ,(select GREATEST(PCEST.QTRESERV,0) from PCEST where PCEST.CODPROD = PCPEDI.CODPROD and PCEST.CODFILIAL = 
NVL(PCPEDI.CODFILIALRETIRA, '2')) QTRESERV
        ,(select GREATEST(PCEST.QTBLOQUEADA,0) from PCEST where PCEST.CODPROD = PCPEDI.CODPROD and PCEST.CODFILIAL = 
NVL(PCPEDI.CODFILIALRETIRA, '2')) QTBLOQUEADA
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
                    AND ((PCRESTRICAODESCVALOR.CODFILIAL = '2') OR
                         (PCRESTRICAODESCVALOR.CODFILIAL IS NULL))
                    AND ((PCRESTRICAODESCVALOR.NUMREGIAO = 15) OR
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
                   AND codfilial = NVL(PCPEDI.CODFILIALRETIRA, '2')) 
              ,0, 'N' 
              , (SELECT NVL (utilizaqtdesupmultipla, 'N') 
                   FROM pcprodfilial 
                  WHERE codprod = pcprodut.codprod 
                    AND codfilial = NVL(PCPEDI.CODFILIALRETIRA,'2')) 
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
  --AND PCPEDI.NUMPED      = :NUMPED
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
CASE WHEN (('N' = 'S') AND 
           (NULL = 'S')) THEN 
  PCPEDC.CODFILIAL ELSE NVL(PCPEDI.CODFILIALRETIRA, PCPEDC.CODFILIAL) END 
  , '99') 
 AND PCPEDI.POSICAO NOT IN ('C')
 AND PCPEDI.DATA >= to_date('01/03/2024','dd/mm/yyyy') 
 --AND PCPEDI.DATA <= to_date('31/12/2024','dd/mm/yyyy')
 AND 1 = 1
ORDER BY clPERLUCRO