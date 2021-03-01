/*
A Customer can request an expedite delivery of all the orders that the customer placed. 
Given a customer id, we follow the following rules for expedite delivery. 

(1) If orders are within ten days of delivery (the difference between the order date and shipping date  < 10)
(Some people also interpret it as the difference between the order date and required date as a way to expedite delivery, 
I will accept it also. Though, prefer to use the difference between the order date and ship date.), 
we refuse the expedite delivery but create a set of such orders.  As part of the stored procedure, 
we will print such rows using a select statement. 

(2) If orders are going to make more than ten days to deliver 
(the difference between the order date and shipping date/required date > 10), 
we expedite the shipping date by one week (by shipping it earlier). At the same time, 
we will charge the customers double for the freight. Update tables accordingly.  

Now we want to allow the customer to expedite delivery for a specific order. 
We will refuse delivery if it is not possible based on our rules or update the order 
for expedite delivery and return the new expedite date. If the expedite delivery is not
possible we will just return the current shipping date. Implement this and demonstrate 
implementation by executing the stored procedure or function.
 
*/

create procedure sp_expediteShippingbyCustID
	@custID varchar(10)
as
begin
	select * from Orders
	where Orders.CustomerID = @custID and DATEDIFF(day,OrderDate,ShippedDate) < 10

	update Orders
	set ShippedDate = ShippedDate - 7, Freight = Freight * 2
	where Orders.CustomerID= @custID and DATEDIFF(day,OrderDate,ShippedDate)>10
end 

execute sp_expediteShippingbyCustID 'VINET'