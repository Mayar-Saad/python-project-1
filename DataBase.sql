select*from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME like '%name%'
--1.	List all product categories.
select Production.ProductCategory.Name 
from Production.ProductCategory
--2.	Retrieve the top 5 most expensive products.
select top 5 pp.Name,pp.Listprice,pp.ProductID
from
Production.Product pp
order by pp.ListPrice desc
--3.	Retrieve a list of customers and the number of orders they have placed.
select ss.CustomerID,pp.FirstName as 'customer_name' ,count(ss.SalesOrderID) as 'the number of orders'
from
Person.Person pp join Sales.Customer sc 
on pp.BusinessEntityID=sc.PersonID
join Sales.SalesOrderHeader ss
on sc.CustomerID=ss.CustomerID
group by pp.FirstName, ss.CustomerID
order by 'the number of orders'
--4.	Find the total sales amount for each customer.
select ss.CustomerID,pp.FirstName as 'customer_name',SUM(TotalDue) as'the total sales amount'
from
Person.Person pp join Sales.Customer sc 
on pp.BusinessEntityID=sc.PersonID
join Sales.SalesOrderHeader ss
on sc.CustomerID=ss.CustomerID
group by ss.CustomerID,pp.FirstName
order by 'the total sales amount'desc
--5.	Get the top 3 selling products by order quantity.
select top 3 ssd.OrderQty,pp.ProductID,pp.Name  
from 
Production.Product pp join Sales.SpecialOfferProduct ssp
on pp.ProductID=ssp.ProductID
join Sales.SalesOrderDetail ssd
on ssp.ProductID=ssd.ProductID
order by ssd.OrderQty desc

--6.	Find the top 5 customers who spent the most money.
select TOP 5 ss.CustomerID,pp.FirstName as 'customer_name',SUM(TotalDue) as'the total sales amount'
from
Person.Person pp join Sales.Customer sc 
on pp.BusinessEntityID=sc.PersonID
join Sales.SalesOrderHeader ss
on sc.CustomerID=ss.CustomerID
group by ss.CustomerID,pp.FirstName
order by 'the total sales amount'desc

--7.	Find employees who have been with the company for more than 10 years.
SELECT pp.BusinessEntityID,pp.FirstName,DATEDIFF(YEAR,HE.HireDate,GETDATE())AS'Experience'
FROM
HumanResources.Employee HE join Person.Person pp
ON 
HE.BusinessEntityID=pp.BusinessEntityID 
where DATEDIFF(YEAR,HE.HireDate,GETDATE())>10 
--8.	Find customers who have placed more than 5 orders.
select sc.CustomerID, pp.FirstName, count(ss.SalesOrderID) as NumberOfOrders
from
Person.Person pp 
join Sales.Customer sc 
on pp.BusinessEntityID = sc.PersonID
join Sales.SalesOrderHeader ss 
on sc.CustomerID = ss.CustomerID
group by sc.CustomerID, pp.FirstName
having count(ss.SalesOrderID) > 5
order by NumberOfOrders 




