--0
--1
--00
--01
--10
--11
--0000
--0001
--0010
--0011
--[0,0,0,0]
--[0,0,0,1]
--[0,0,1,0]
--[0,0,1,1]
--[16,8,4,2]
--{key:value}
--(iten0,iten1)
--go
--{:find,RCA,QT.codclientcadastradosnoperiodo,QT.codclientvendidosincadastradosnoperiodo}
--dintable_pcusur
--fatotable_pcusurcli
select tp.codusur 
    , count(tt.codcli) as "Qt.cadastro"
    , count(distinct(tp."Qt.Positivados")) as "Qt.Positivados" from
    (select  t.codcli --selelcionar colunas
        , count(t.codcli) as "Qt.cadastro"
        from       pcclient t    
        where       t.dtcadastro >= to_date(:datai,'dd/mm/yyyy')
        and       t.dtcadastro <= to_date(:dataf,'dd/mm/yyyy')
        group by  t.codcli
        order by t.codcli) tt
,    (select  t.codusur, t.codcli --selelcionar colunas
        , count(t.codcli) as "Qt.Positivados"
        from       pcpedc t    
        where       t.data >= to_date(:datai,'dd/mm/yyyy')
        and       t.data <= to_date(:dataf,'dd/mm/yyyy')
        group by t.codusur, t.codcli
        order by t.codusur) tp
where tt.codcli = tp.codcli
group by tp.codusur
--group by codusur
--orderb by codusur
--og
--(iten0,iten1)
--{key:value}
--[16,8,4,2]
--[0,0,1,1]
--[0,0,1,0]
--[0,0,0,1]
--[0,0,0,0]
--0011
--0010
--0001
--0000
--11
--10
--01
--00
--1
--0