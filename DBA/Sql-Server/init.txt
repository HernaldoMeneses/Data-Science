/*                
/-  Structured Query Language (SQL)
*/

--Welcome to DataBase Administraror by ./HernaldoMeneses
-- objetivo -> aprender T-SQL (Transact-SQL)
-- Getting Started
-- T-SQL - Transact-SQL is Microsoft's implemntation 
-- of the Structured Query Language (SQL)

-- Install the SQL Server... 
--- continue__

/*                
/- Using SQL Server Management Studio 
*/                                    
--SQL new Query Windows
--You will notice as you type that IntelliSence
SELECT * FROM sys.databases;

-- see pag 18 to instal on databese from a file dowload 

-- Get Started with SSMS
-- choice a table and Select 
--  Script de tabela como
--      Select for new windows sql editor
-- It will show you the simples select filds of tables

USE [powerbi] -- databes
GO

SELECT [CodigoIBGE] -- fildes
      ,[Cidade]
      ,[UF]
      ,[Estado]
      ,[Populacao]
      ,[Area]
      ,[Regiao]
  FROM [dbo].[Aux_CidadeIBGE] -- objeto.tabela

GO

-- Another way is select all filds
SELECT * FROM 

-- go to chapter 2
-- pg 23
