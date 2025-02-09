


/*filtrar los datos de mexico en el mes de enero y frebrero del 2014*/
SELECT *
FROM financial.currencies
WHERE Country = 'México'
  AND MonthName IN (' January ', ' February ')
   AND Year = 2014;

-------------------------------------------------------------
SELECT 
    financialsam.Country, 
    financialsam.Product, 
    financialsam.SalePrice, 
    financialsam.ManufacturingPrice,
    financialsam.MonthName, 
    financialsam.year,
    currencies.exchange_rate
FROM 
    financial.financialsam AS financialsam
JOIN 
    financial.currencies AS currencies
    ON TRIM(financialsam.Country) = TRIM(currencies.Country) 
WHERE 
    TRIM(financialsam.Country) = 'Mexico' 
    AND TRIM(financialsam.MonthName) IN ('January', 'February')
    AND financialsam.Year = 2014
ORDER BY 
    financialsam.MonthName,
    financialsam.Product;

