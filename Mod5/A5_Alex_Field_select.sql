--Assignment 5 DML select

--1
select Customers.CompanyName, Customers.ContactName, Products.ProductName
from [Order Details]
inner join Products on Products.ProductID = [Order Details].ProductID
inner join Orders on Orders.OrderID = [Order Details].OrderID
inner join Customers on Customers.CustomerID = Orders.CustomerID
where ProductName = 'Chai' or ProductName = 'Chang'
group by CompanyName, Customers.ContactName, Products.ProductName
order by Customers.CompanyName ASC


--2
select Country, count(*) as [Customers from]
from Customers
group by Country

-- 3
select Country, count(*) as [Customers from]
from Customers
group by Country
having count(*)>5

--4
select Employees.FirstName, Employees.LastName, count(Orders.EmployeeID) as [Order Count]
from Employees
inner join Orders on Orders.EmployeeID = Employees.EmployeeID
group by Employees.LastName, Employees.FirstName
having count(Orders.EmployeeID) > 50

--5
Select Employees.FirstName, Employees.LastName, Employees.Title, Employees.Address, Employees.City, Employees.PostalCode
from EmployeeTerritories
inner join Employees on Employees.EmployeeID = EmployeeTerritories.EmployeeID
inner join Territories on Territories.TerritoryID = EmployeeTerritories.TerritoryID
inner join Region on Region.RegionID = Territories.RegionID
where Region.RegionDescription = 'Western'
group by Employees.FirstName, Employees.LastName, Employees.Title, Employees.Address, Employees.City, Employees.PostalCode
order by Employees.FirstName

--6 
--  List unique product names of all the products who are part of orders that were served by the employee whose last name 
--  starts with L and also served by the shipping company Federal Shipping.

select distinct Products.ProductName, Employees.LastName as [Employee Last Name], Shippers.CompanyName
from Orders
inner join Employees on Employees.EmployeeID = Orders.EmployeeID
inner join [Order Details] on [Order Details].OrderID = Orders.OrderID
inner join Products on Products.ProductID = [Order Details].ProductID
inner join Shippers on Shippers.ShipperID = Orders.ShipVia
group by Employees.LastName, Shippers.CompanyName, Products.ProductName
having Employees.LastName like 'L%' and Shippers.CompanyName = 'Federal Shipping'

-- 7
-- List product name and supplier company name of all the products of category type Beverages.

select Products.ProductName, Suppliers.CompanyName
from Products
inner join Suppliers on Suppliers.SupplierID = Products.SupplierID
inner join Categories on Categories.CategoryID = Products.CategoryID
where Categories.CategoryName = 'Beverages'

-- 8 
-- List last name and first name of all the employees supervised by Vice President Sales, 
-- sorted by the last name of the employee. 

select e1.FirstName, e1.LastName from Employees e1
inner join Employees e2
on e1.ReportsTo = e2.EmployeeID
where e2.Title = 'Vice President, Sales'
order by e1.LastName

