/*
Write triggers that will achieve the same functionality as following foreign keys.
FK_Orders_Customers and FK_Orders_Shippers. Delete/Disable the foreign key temporarily.
Currently, the Northwind database has "No Action" delete and update rule specified on 
these foreign keys. Write triggers that also implement "Cascade" update rules.  
I expect you to write 4 triggers in total. 
	fk_order_customers_on_update_no_action, 
	fk_orders_customers_on_update_cascade, 
	fk_orders_shippers_on_update_no_action 
	fk_orders_shippers_on_update_cascade. 
(80 points)
*/

use Northwind;
go

create trigger fk_order_customers_on_update_no_action
on Customers
after update
as
if update(CustomerID)
begin
	if(select count(*) from Customers inner join 
		inserted on inserted.CustomerID = Customers.CustomerID)=0
	begin
		print 'no rows modified'
		rollback transaction;
	end
	else
		print 'CustomerID updated, no other tables effected'
end



go
create trigger fk_order_customers_on_update_cascade
on Customers
after update
as
if update(CustomerID)
begin
	if(select count(*) from Customers inner join 
	inserted on inserted.CustomerID = Customers.CustomerID)=0
	begin
		print 'no rows modified'
		rollback transaction;
	end
	else
	begin
		update Orders
		set Orders.CustomerID = inserted.CustomerID
		from Orders inner join inserted on Orders.CustomerID = inserted.CustomerID
		print 'CustomerID updated, cascaded to Orders table'
	end
end
go

create trigger fk_orders_shippers_on_update_no_action
on Shippers
after update
as
if update(ShipperID)
begin
	if(select count(*) from Shippers inner join 
		inserted on inserted.ShipperID = Shippers.ShipperID)=0
	begin
		print 'no rows modified'
		rollback transaction;
	end
	else
		print 'ShipperID updated, no other tables effected'
end



go
create trigger fk_orders_shippers_on_update_cascade
on Shippers
after update
as
if update(ShipperID)
begin
	if(select count(*) from Shippers inner join 
	inserted on inserted.ShipperID = Shippers.ShipperID)=0
	begin
		print 'no rows modified'
		rollback transaction;
	end
	else
	begin
		update Orders
		set ShipVia = (select inserted.ShipperID from inserted)
		where ShipVia = (select inserted.ShipperID from inserted)
		print 'CustomerID updated, cascaded to Orders table'
	end
end
go

insert into Customers (CustomerID, CompanyName)
values ('test', 'test')

insert into Shippers (CompanyName)
values ('test')

insert into Orders (CustomerID, ShipVia)
values ('test', 4)

select * from Customers
where CustomerID = 'test'

select * from Shippers
where ShipperID = 4

select * from Orders
where CustomerID = 'test'

update Customers
set CustomerID = 'test1'
where CustomerID ='test'

update Shippers
set CompanyName = 'test1'
where CompanyName = 'test2'