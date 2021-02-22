-- example 8.18
GO
use sample;
GO

create function compute_cost 
	(@percent int = 10)
	returns decimal
as
begin
	declare @additional_cost decimal;
	declare @sum_budget decimal;
	select @sum_budget = sum(budget)
	from project;
	set @additional_cost = @sum_budget * @percent / 100;
	return @additional_cost;
end

GO

declare @additional_cost decimal
set @additional_cost = dbo.compute_cost(20)
print @additional_cost

GO
use sample;
GO

create function employee_in_project
(@prno varchar(5))
returns @tab1 table (fname varchar(50), lname varchar(50))
as
begin
	insert into @tab1
	select emp_fname,emp_lname from employee
	inner join works_on on employee.emp_no = works_on.emp_no
	where project_no = @prno

	return;
end

--execute the function. 
select * from dbo.employee_in_project('p3')

Go
create function get_job
	(@empid as int)
	returns table
as 
	return (select job
			from works_on
			where emp_no = @empid and job is not null)

GO