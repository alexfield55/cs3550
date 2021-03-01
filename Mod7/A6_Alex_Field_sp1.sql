 /*We are running a specific discount scheme in our Northwind Organization. 
 Every month the owner of the company will choose a category and we will provide a discount to that category products. 
 If the owner chooses 'Beverages' as the category, we will provide a discount to products of 'Beverages' categories.
 So, the category name is the input parameter.

The rules of the discount are as follows:
If the total order value in order details for a particular order detail item is

<50, we give an additional 5% discount.
>=50 but <100, we give an additional 10% discount
>100, we give an additional 15% discount. 

Unit price * Quantity determines the total value of each order detail item.      

If an item costs 70$ and (1) if it has a 7% discount already, 
the new discount is 17% (2) If it has no discount, the new discount is 10%.  

Write a stored procedure that will achieve this. We need to update the table(s) to reflect the discount.
Remember, we give a discount to orders with a specific category and not to all the categories.
Execute the stored procedure to demonstrate that we can give a correct discount to the orders of category "Beverages".
*/

use Northwind;
go

declare @category varchar(25);
set @category = 'Beverages';

go
create procedure sp_CategoryDiscount @category varchar(25)
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
	inner join Categories on Categories.CategoryID = Products.CategoryID
	where Categories.CategoryName = @category 
end

execute sp_CategoryDiscount @category=Beverages
