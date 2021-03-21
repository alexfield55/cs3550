/*
Create an audit trail table for [Order Details] table and name it
[Order Details Audit Trail]. The audit trail consists of the following 
information: OrderID, ProductID, User (who changed the value), 
TimeStamp (when the value is changed),  OldUnitPrice and NewUnitPrice. 
Write an update trigger on [Order Details] table such that whenever 
the unit price is updated, it creates an entry in the [Order Details Audit Trail] table.
*/

--table to store audit
create table [Order Details Audit Trail]
(
	OrderID int null,
	ProductID int null,
	User_Name char(20) null,
	Time datetime null,
	Old_Price money,
	New_Price money
)

--trigger
go
create trigger modify_order_details 
on [Order Details]
after update
as
print 'inside trigger'
if update(UnitPrice)
begin
	declare @old_price money;
	declare @new_price money;
	declare @orderID int;
	declare @productID int;
	select @old_price = (select UnitPrice from deleted);
	select @new_price = (select UnitPrice from inserted);
	select @orderID = (select OrderID from deleted);
	select @productID = (select ProductID from deleted);
	insert into [Order Details Audit Trail] values 
	(@orderID,@productID,USER_NAME(), GETDATE() , @old_price, @new_price)
end

--example queries
update [Order Details]
set UnitPrice = 5
where ProductID = 11 and OrderID = 10248

--example queries
select * from [Order Details]
select * from [Order Details Audit Trail]