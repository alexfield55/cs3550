--Alex Field
--Cursor LA solved
--See below for sp
use Northwind;

declare @categoryid int;
declare @month int;
set @month =  MONTH(CURRENT_TIMESTAMP);

declare categorymonthdiscount cursor
for
	select Products.CategoryID
	from Products

open categorymonthdiscount

fetch next from categorymonthdiscount
into @categoryid

while @@FETCH_STATUS = 0
	begin
		--check for jan to aug
		if (@month = @categoryid and @month != 9 and @month != 10 and @month != 11 and @month != 12)
			begin
				execute sp_discountbycategoryID @categoryid
			end
		-- apply discount for all product categorties in nov and dec
		if (@month = 11 or @month = 12)
			begin
			declare @i int;
			set @i = (select count(*) from Categories)
			while(@i>0)
				begin
				execute sp_discountbycategoryID @i
				set @i = @i - 1
				end
			end
	fetch next from categorymonthdiscount
	into @categoryid
	end;

close categorymonthdiscount;
deallocate categorymonthdiscount;


--sp editted down for category ID only
go
create procedure sp_discountbycategoryID @categoryID int
as
begin
	update [Order Details]
	set Discount =
	(
		case
			when [Order Details].UnitPrice = 70 and Discount = .07 then .17
			when [Order Details].UnitPrice = 70 and Discount = 0 then .1
			when ([Order Details].UnitPrice*Quantity) < 50 then Discount + .05
			when ([Order Details].UnitPrice*Quantity) >= 50 or ([Order Details].UnitPrice*Quantity) <100 then Discount + .1
			else Discount + .15
		end
	)
	from [Order Details]
	inner join Products on Products.ProductID = [Order Details].ProductID
	where Products.CategoryID = @categoryID
end
go