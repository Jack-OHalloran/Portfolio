--Question 1------------------------------------------------------------------------
--Please provide a sql CTE command that will produce the following result (SalesPerson, Total SalesTransactions, TotalSales and SalesYear):

WITH Sales_CTE(SalesPersonID, SalesOrderID, TotalDue, SalesYear)AS
-- Define the CTE query.  
(
	SELECT SalesPersonID, SalesOrderID,TotalDue, YEAR(OrderDate)AS SalesYear  
	FROM Sales.SalesOrderHeader  
	WHERE SalesPersonID IS NOT NULL
)
-- Define the outer query referencing the CTE name.  
SELECT SalesPersonID, COUNT(SalesOrderID)AS TotalSalesTransactions, SUM(TotalDue)AS TotalSales, SalesYear  
FROM Sales_CTE  
GROUP BY SalesYear, SalesPersonID
ORDER BY SalesPersonID, SalesYear;


--Question 2------------------------------------------------------------------------
--2. Please provide a sql command that uses RowNumber() and Partition By to produce the following results (Ranking the Sales Person by SalesQuota in a DESC order):

SELECT FirstName, LastName, TerritoryName, ROUND(SalesYTD,2,1) AS SalesYTD, SalesQuota, 
ROW_NUMBER() OVER(PARTITION BY TerritoryName ORDER BY SalesQuota DESC) 
  AS Ranking  
FROM Sales.vSalesPerson  
WHERE TerritoryName IS NOT NULL AND SalesYTD <> 0  
ORDER BY TerritoryName; 
