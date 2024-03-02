SELECT
	WMS.NUMTRANSWMS AS NUMEROTRANSWMS,
	WMS.NUMPED AS NUMEROPEDIDO,
	WMS.NUMBONUS AS NUMEROBONUS,
	WMS.CODPROD AS CODIGOPRODUTO,
	WMS.CODFILIAL AS CODIGOFILIAL,
	WMS.CODOPER AS CODIGOOPERACAO,
	WMS.DATAWMS AS DATAENTRADA,
	WMS.QT AS QUANTIDADE,
	WMS.QTUNITCX AS QUANTIDADEUNITARIACAIXA,
	WMS.QTTOTPALCX AS QUANTIDADECAIXAPALETE,
	WMS.QTAVARIA AS QUANTIDADEAVARIA,
	WMS.QTBLOQUEADA AS QUANTIDADEBLOQUEADA,
	PRO.PESOLIQ AS PESOLIQUIDOUNITARIO,
	PRO.PESOBRUTO AS PESOBRUTOUNITARIO,
	WMS.TOTPESO AS PESOTOTAL,
	PRO.VOLUME AS VOLUMEUNITARIO,
	WMS.TOTVOLUME AS VOLUMETOTAL,
	WMS.VLTOTAL AS VALORTOTAL
FROM PCWMS WMS
	INNER JOIN PCPRODUT PRO ON PRO.CODPROD = WMS.CODPROD
WHERE
	WMS.NUMBONUS <> 0
	AND TO_CHAR(WMS.DATAWMS, 'YYYY') >= TO_CHAR(ADD_MONTHS(SYSDATE, -24), 'YYYY')