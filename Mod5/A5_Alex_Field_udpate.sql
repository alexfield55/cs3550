-- Assignment 5 DML
-- Update

--1
--Add two new products into the products table. Place four orders for these new products. (10 points)

insert into Products
(ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel,Discontinued)
values
('Bacon', 1, 6, '12 slice package', 15, 69, 0, 10, 0), 
('Crackers', 2, 3, '5 oz box', 3.50, 420, 99, 37, 0)

insert into Orders (CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, 
ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
values
('VINET', 5, 2021-02-14, 2021-02-15, 2021-02-16, 3, 69.69, 'Nostromo', 'LV-426', 'Paris', NULL, 88888, 'France'),
('RATTC', 1, 2021-02-14, 2021-02-15, 2021-02-16, 3, 69.69, 'Covenant', 'LV-233', 'Berlin', NULL, 11111, 'Germany'),
('RICSU', 8, 2021-02-14, 2021-02-15, 2021-02-16, 3, 69.69, 'Prometheus', 'LV-742', 'Barcelona', NULL, 99999, 'Spain'),
('BONAP', 4, 2021-02-14, 2021-02-15, 2021-02-16, 3, 69.69, 'Nostromo', 'LV-426', 'Seattle', 'WA', 98105, 'USA')

insert into [Order Details](OrderID, ProductID, UnitPrice, Quantity, Discount)
values
( 11078, 78, 15, 10, .1),
( 11079, 78, 15, 100, .25),
( 11080, 79, 3.5, 1000, .5),
( 11081, 79, 3.5, 1030, 0)

select * from Products where ProductID>77
select * from Orders where OrderID>11077
select * from [Order Details] where OrderID>11077



--2
--For any ordered item within an order (order detail item) worth more than 20$, add an additional 10% discount. (10 points)

update [Order Details]
set Discount = Discount + .1
where (UnitPrice * Quantity) > 20

select * from [Order Details]

--3 
--Delete the two new products that you added. You may need to delete the corresponding orders first. (10 points)

delete from [Order Details] where ProductID = 78 or ProductID = 79
delete from Products where ProductID = 78 or ProductID = 79

select * from [Order Details]
select * from Products

--4
--We are closing down the Eastern region. We decided to move all the employees to the western region. 
--Implement the move by modifying the tables. Please consider the note at the beginning. 
--You need to consider Employee, EmployeeTerritories, Territories and Region tables. (10 points)

update Territories
set RegionID = 2
where RegionID = (select RegionID from Region where RegionDescription = 'Eastern')

delete from Region
where RegionDescription = 'Eastern'

select * from Territories
select * from Region
