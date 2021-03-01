

create procedure sp_expediteShippingbyOrderID
	@orderID int
as
begin
	select * from Orders
	where Orders.OrderID = @orderID and DATEDIFF(day,OrderDate,ShippedDate) < 10

	update Orders
	set ShippedDate = ShippedDate - 7, Freight = Freight * 2
	where Orders.OrderID = @orderID and DATEDIFF(day,OrderDate,ShippedDate)>10
end 

execute sp_expediteShippingbyOrderID 10248