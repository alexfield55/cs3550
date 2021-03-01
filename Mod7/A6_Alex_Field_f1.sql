/*
Write a function that returns the number of employees based on a region. 
By region, we mean the region the employee serves and not the region where the employee lives.
Execute the function to demonstrate the correctness.
*/

use Northwind
go

create function numEmployeeServiceRegion
	(@region varchar(50))
	returns int
as
begin
	declare @numEmployees int;
	select @numEmployees  = count(*) 
		from EmployeeTerritories
		inner join Territories on Territories.TerritoryID = EmployeeTerritories.TerritoryID
		inner join Region on Region.RegionID = Territories.RegionID
	where Region.RegionDescription = @region
	return @numEmployees;
end 

--execution statement
go
declare @numEmps int
set @numEmps = dbo.numEmployeeServiceRegion('Western')
print @numEmps