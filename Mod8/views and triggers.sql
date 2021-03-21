/*
1. Use only views to achieve the following queries.  

	You can use any of the existing views in the Northwind DB. 
	For problem 1, I expect you not to write any new views. 
	Current products are the products with discontinued = 0. 
	Find all the current products that are shipped between 1997-01-01 to
	1997-03-31 ordered by category name. (20 points)

2. Write and test the following view.  

	Write a view called [Order Details Extended Above Average] that returns details like OrderId, 
	ProductId, ProductName, UnitPrice, Quantity, Discount, and ExtendedPrice. 
	It calculates extended price just like [Order Details Extended] view but returns rows 
	only if the ExtendedPrice is above the average extended price.  You can use [Order Details Extended]
	view as an example. [Order Details Extended] build extended price using this formula:  
	CONVERT(money, (dbo.[Order Details].UnitPrice * dbo.[Order Details].Quantity) * (1 - dbo.[Order Details].Discount) / 100) * 
	100 AS ExtendedPrice.  (40 points) 
	Warning: Do Not use [Order Details Extended] view as part of the new view. 
	Generate the view from tables. Once you finish writing the view, demonstrate the view by querying against the view. 

*/

 --#1
 select [Product Sales for 1997].ProductName, CategoryName from [Product Sales for 1997]
 inner join [Current Product List] on [Product Sales for 1997].ProductName = [Current Product List].ProductName
 inner join [Order Details Extended] on [Current Product List].ProductID = [Order Details Extended].ProductID
 inner join [Orders Qry] on [Order Details Extended].OrderID = [Orders Qry].OrderID
 where [Orders Qry].ShippedDate between '01/01/1997' and '03/31/1997'
 group by [Product Sales for 1997].ProductName, CategoryName
 order by CategoryName

 GO

 --#2
create view [Order Details Extended Above Average]
as
select "Order Details".OrderID, "Order Details".ProductID, Products.ProductName, 
	"Order Details".UnitPrice, "Order Details".Quantity, "Order Details".Discount, 
	CONVERT(money, (dbo.[Order Details].UnitPrice * dbo.[Order Details].Quantity) * (1 - dbo.[Order Details].Discount) / 100) * 
	100 as ExtendedPrice
from Products INNER JOIN "Order Details" ON Products.ProductID = "Order Details".ProductID
where (((dbo.[Order Details].UnitPrice * dbo.[Order Details].Quantity) * (1 - dbo.[Order Details].Discount) / 100) * 
	100) > (select avg(CONVERT(money, (dbo.[Order Details].UnitPrice * dbo.[Order Details].Quantity) *
	(1 - dbo.[Order Details].Discount) / 100) * 100) from [Order Details])

GO

select * from [Order Details Extended Above Average]
order by ExtendedPrice