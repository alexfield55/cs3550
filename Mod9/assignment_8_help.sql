select * from Products 
where Discontinued = 1

select * from Products


select * from Orders


-- order details for discontinued product 17

select [Order Details].ProductID, [Order Details].OrderID, Products.Discontinued, [Order Details].* from [Order Details]
inner join Products on Products.ProductID = [Order Details].ProductID
where products.ProductID = 17

-- more details for discontinued product 17
select distinct [Order Details].ProductID, Orders.OrderID, Products.Discontinued, [Order Details].* from [Order Details]
inner join Products on Products.ProductID = [Order Details].ProductID
inner join Orders on Orders.OrderID = [Order Details].OrderID
where products.ProductID = 17



-- all the orders where product id 17 is part of the order
select OrderID, count(*) from [Order Details]
where OrderID in (select OrderID from [Order Details]
where [Order Details].ProductID = 17) and 1 = (select count(*) from [Order Details]
where OrderID in (select OrderID from [Order Details]
where [Order Details].ProductID = 17) 
group by OrderID)
group by OrderID

-- the orders where only product id 17 (discontinued) is part of the order
select OrderID, count(*) from [Order Details]
where OrderID in (select OrderID from [Order Details]
where [Order Details].ProductID = 17)
group by OrderID
having count(orderid) = 1



select *
from [Order Details]
where OrderID = 10279


select * from [Order Details]
where OrderID = 10265


