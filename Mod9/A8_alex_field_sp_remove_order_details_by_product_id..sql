use Northwind;
go	

create or alter procedure sp_remove_order_details_by_product_id
(@productID int)
as
begin
	delete from [Order Details] where [Order Details].ProductID = @productID
end