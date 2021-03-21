create or alter procedure sp_remove_order_details_by_product_id
(@productID int)
as
begin
	delete from [Order Details] where [Order Details].ProductID = @productID
end



go
declare remove_cursor_for_disconinued_product cursor
for 
	select OrderID, ProductID from [Order Details] 
	where OrderID in 
	(
		select OrderID from [Order Details]
		where OrderID in 
		(
			select OrderID from [Order Details]
			join Products on Products.ProductID = [Order Details].ProductID 
			where Products.Discontinued=1
		)
		group by OrderID
		having count(orderid) = 1
	)


declare @orderid int
declare @productid int
open remove_cursor_for_disconinued_product

fetch next from remove_cursor_for_discountinued_product
into @orderid, @productid

while @@FETCH_STATUS = 0

begin
	print @productid;

	
	create table #temp_order_removal (orderid int, productid int)
	insert into #temp_order_removal values (@orderid, @productid)

	delete from Orders where OrderID = (select OrderID from #temp_order_removal)
	execute sp_remove_order_details_by_product_id @productid
	


	drop table #temp_order_removal 


	--fetch into product id again to continue the loop.

	
	
	
	
end


-- don't forget close and deallocate. 
close remove_cursor_for_disconinued_product
deallocate remove_cursor_for_disconinued_product