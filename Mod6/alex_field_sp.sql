use sample;
GO

--stored procedures with no params
create procedure sp_GetAllEmployeeList
as
begin
	select * from employee
end

--stored procedures with parameter
GO
use sample;
GO
create procedure sp_EmployeeByLocation @location varchar(50)
as
begin
	select emp_fname,emp_lname from employee
	inner join department on employee.dept_no = department.dept_no
	where location = @location
end

GO
use sample;
GO

--multiple params
create procedure sp_EmployeeByLocationAndJob @location  varchar(50),@jobtitle varchar(50)
as
begin
	select * from employee
	inner join works_on on employee.emp_no = works_on.emp_no
	inner join department on department.dept_no = employee.dept_no
	where location = @location and job = @jobtitle
end

--Executions
GO
use sample;
GO

execute sp_EmployeeByLocation 'Dallas'
execute sp_EmployeeByLocation @location='Dallas'
execute sp_GetAllEmployeeList
execute sp_EmployeeByLocationAndJob 'Seattle', 'Analyst'

--need to run all lines to execute
declare @location1 varchar(50)
set @location1 = 'Seattle'
declare @jobtitle1 varchar(50)
set @jobtitle1 = 'Analyst'
execute sp_EmployeeByLocationAndJob @location = @location1, @jobtitle = @jobtitle1

--default location
execute sp_EmployeeByLocation
--parameterized location
execute sp_EmployeeByLocation 'Dallas'

declare @totalemp1 int;
execute sp_EmployeeByLocation 'Dallas', @totalemp = @totalemp1 output
print 'Total Employee: '  + STR(@totalemp1,3)

--alter procedure
alter procedure sp_EmployeeByLocation@location varchar(50) = 'Seattle'
as
begin
	select emp_fname,emp_lname from employee
	inner join department on employee.dept_no = department.dept_no
	where location = @location
end

GO
Use sample;
GO

--alter output
alter procedure sp_EmployeeByLocation @location varchar(50) = 'Seattle', @totalemp int OUTPUT
as
begin
	select emp_fname,emp_lname from employee
	inner join department on employee.dept_no = department.dept_no
	where location = @location
	
	select @totalemp = count(*) from employee
	inner join department on employee.dept_no = department.dept_no
	where location = @location
end

-- example 8.7
GO
use sample;
GO

create procedure sp_IncreaseBudget(@percent int = 5)
as
begin
	update project
	set budget = budget + budget * @percent / 100;
end

execute sp_IncreaseBudget 10

-- example 8.8
GO
use sample;
GO

create procedure sp_ModifyEmpNo(@old_no int, @new_no int)
as
begin
	update employee
	set emp_no = @new_no
	where emp_no = @old_no
	update works_on
	set emp_no = @new_no
	where emp_no = @old_no
end


GO
use sample;
GO

create procedure sp_DeleteEmp
(@emp_no int, @no_projects int output)
as
begin
	select @no_projects = count(*)
	from works_on where emp_no = @emp_no

	delete from works_on
	where emp_no = @emp_no

	delete from employee
	where emp_no = @emp_no

end

select * from works_on

declare @totalProjects int;
set @totalProjects = 0;
execute sp_DeleteEmp @emp_no = 9999, @no_projects = @totalProjects OUTPUT
print @totalProjects