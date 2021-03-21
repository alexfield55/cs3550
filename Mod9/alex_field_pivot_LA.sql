--Alex Field
--Pivot Videos Examples

use Northwind;

-- pivot example 1
select * from 
(
	select ShipVia, CompanyName from Customers 
	inner join Orders on Orders.CustomerID = Customers.CustomerID 
)
as ShipViaTable
pivot
(
	count(CompanyName)
	for ShipVia in ([1],[2],[3])
)
as ShipViaPivotTable

-- Pivot example 2
-- how many companies/customers are being served in each city by each shipper

select ShipVia, City, count(Customers.CustomerID) as NoOfCompanies
from Customers inner join Orders on Customers.CustomerID = Orders.CustomerID
group by ShipVia, City
order by City

select ShipVia, City, Customers.CustomerID 
from Customers inner join Orders on Customers.CustomerID = Orders.CustomerID

select * from 
(
	select ShipVia, City, Customers.CustomerID 
	from Customers inner join Orders on Customers.CustomerID = Orders.CustomerID
)
as ShiViaTable
pivot
(
	count(CustomerID)
	for ShipVia in ([1],[2],[3])
)
as ShipViaPivotTable

--pivot example 3
--What is the average freight paid to each shipper in each city
--I want to show shippers name and not number.

select ShipCity, Shippers.CompanyName as ShipperName, AVG(Freight) as AvgFreight from Customers
inner join orders on Customers.CustomerID = Orders.CustomerID
inner join Shippers on Shippers.ShipperID = Orders.ShipVia
group by Shippers.CompanyName,ShipCity
order by ShipCity

select ShipCity, Shippers.CompanyName as ShipperName, Freight  from Customers
inner join orders on Customers.CustomerID = Orders.CustomerID
inner join Shippers on Shippers.ShipperID = Orders.ShipVia

select * from 
(
	select ShipCity, Shippers.CompanyName as ShipperName, Freight  from Customers
	inner join orders on Customers.CustomerID = Orders.CustomerID
	inner join Shippers on Shippers.ShipperID = Orders.ShipVia
)
as ShipperIntermediateTable
pivot
(
	AVG(Freight)
	for ShipperName in ([Federal Shipping],[Speedy Express],[United Package])
)
as ShipperPivotTable

