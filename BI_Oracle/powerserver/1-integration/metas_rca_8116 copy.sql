SELECT --Obj1.1_init
          pcusuari.codsupervisor,
          pcusuari.codusur, 
          nvl(pcusuari.comissaofixa,0) FIXO, 
          NVL ((SELECT SUM (pcmetarca.vlvendaprev)
               FROM pcmetarca
              WHERE pcmetarca.codusur = pcusuari.codusur
                AND pcmetarca.codfilial IN (2)
                AND pcmetarca.DATA BETWEEN TRUNC(to_date(:DTINICIO,'dd-mm-rrrr'),'mm') AND LAST_DAY(to_date(:DTFIM,'dd-mm-rrrr'))), 0
                --AND pcmetarca.DATA >= to_date('01/01/2024','dd/mm/yyyy'))
           ) AS vlmetatotal
          FROM --Obj1.1 
               pcusuari, 
               pcsuperv 
              