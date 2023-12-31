
/**
USE [powerbi]
GO

INSERT INTO [dbo].[Fato_PastaCompras]
           ([PASTA]
           ,[codfornec])
     VALUES
           (<PASTA, int,>
           ,<codfornec, int,>)
GO
***/

USE [powerbi]
GO

INSERT INTO [dbo].[Fato_PastaCompras]
           ([PASTA]
           ,[codfornec])
     VALUES
            (1,     297)
            ,(1,	989)
            ,(1,	1174)
            ,(1,	1214)
            ,(1,	2280)
            ,(1,    2589)
            ,(1,	2620)
            ,(1,	2901)
            ,(1,	3026)
            ,(1,	3114)
            ,(1,	3175)
            ,(1,	3235)
            ,(1,	3309)
            ,(1,	3383)
            ,(1,	3582)
            ,(1,	3639)
            ,(1,	3640)
            ,(1,	3715)
            ,(1,	3718)
            ,(1,    3726)
            ,(2,	4)
            ,(2,	19)
            ,(2,	346)
            ,(2,	390)
            ,(2,	394)
            ,(2,	403)
            ,(2,	405)
            ,(2,	975)
            ,(2,	976)
            ,(2,	1118)
            ,(2,	1203)
            ,(2,	1360)
            ,(2,	2971)
            ,(2,	2993)
            ,(2,	3209)
            ,(2,	3248)
            ,(2,	3258)
            ,(2,	3314)
            ,(2,	3330)
            ,(2,	3333)
            ,(2,	3356)
            ,(2,	3361)
            ,(2,	3420)
            ,(2,	3423)
            ,(2,	3424)
            ,(2,	3446)
            ,(2,	3461)
            ,(2,	3468)
            ,(2,	3470)
            ,(2,	3485)
            ,(2,	3486)
            ,(2,	3492)
            ,(2,	3513)
            ,(2,	3535)
            ,(2,	3549)
            ,(2,	3570)
            ,(2,	3571)
            ,(2,	3642)
            ,(3,	125)
            ,(3,	1068)
            ,(3,	1662)
            ,(3,	1970)
            ,(3,	2591)
            ,(3,	2782)
            ,(3,	2789)
            ,(3,	2841)
            ,(3,	2946)
            ,(3,	3018)
            ,(3,	3222)
            ,(3,	3241)
            ,(3,	3313)
            ,(3,	3326)
            ,(3,	3459)
            ,(3,	3466)
            ,(3,    3542)
            ,(4,	1721)
            ,(4,	2746)
            ,(4,	2811)
            ,(4,	2824)
            ,(4,	2834)
            ,(4,    2902)
            ,(4,	2908)
            ,(4,	3074)
            ,(4,	3077)
            ,(4,	3207)
            ,(4,	3317)
            ,(4,	3329)
            ,(4,	3334)
            ,(4,	3345)
            ,(4,	3373)
            ,(4,	3396)
            ,(4,	3427)
            ,(4,	3441)
            ,(4,	3457)
            ,(4,	3469)
            ,(4,	3546)
            ,(4,	3552)
            ,(4,	3589)
            ,(4,	3606)
            ,(4,	3623)
            ,(4,	3632)
            ,(4,	3634)
            ,(4,	3675)


GO

TendênciaVenda:=[Valor Venda Total]/[QuantidadeDiasUteisCorridos]*[QuantidadesDiasUteis]

Venda por Industria:=if([Venda-por-Meta]>=(97/100);1;0)


Vend_por_Indust
=if([%_Real_Venda]>=0,97;1;0)
