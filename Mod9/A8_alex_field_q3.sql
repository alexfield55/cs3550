use Northwind;
go

--pivot averages table
select * from
(
	select UnitPrice, Categories.CategoryName from Products
	inner join Categories on Products.CategoryID = Categories.CategoryID
	where Categories.CategoryName = 'Beverages' or Categories.CategoryName = 'Condiments' 
	 or Categories.CategoryName = 'Produce'
)	
as
avgTable
pivot
(
	avg(UnitPrice)
	for CategoryName in ([Beverages],[Condiments],[Produce])
)
as
pivotavgTable

--group by proving results
select Categories.CategoryName, Avg(UnitPrice) from Products
	inner join Categories on Products.CategoryID = Categories.CategoryID
	where Categories.CategoryName = 'Beverages' or Categories.CategoryName = 'Condiments' 
	 or Categories.CategoryName = 'Produce'
Group by CategoryName