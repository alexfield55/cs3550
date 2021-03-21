--fetch all emoployees print first and last name and department number
declare @emp_no int
declare @fname varchar(50)
declare @lname varchar(50)
declare @dept_no varchar(5)

declare employee_cursor cursor
for
	select emp_no, emp_fname, emp_lname, dept_no from employee
	where dept_no = 'd1' or dept_no = 'd2' or dept_no = 'd3'

open employee_cursor;

fetch next from employee_cursor
into @emp_no, @fname, @lname, @dept_no;

while @@FETCH_STATUS = 0
	begin
		print @fname + ' ' + @lname + ' '  + @dept_no
		fetch next from employee_cursor
		into @emp_no, @fname, @lname, @dept_no;
	end;
close employee_cursor
deallocate employee_cursor

--function
use sample;
GO
create function count_employee
(@project_no varchar(10))
returns int 
as
begin
	return (select count(*) from works_on
	where project_no = @project_no);
end
GO

use sample;
go
declare @temp_val int;
set @temp_val = dbo.count_employee('p3');
print @temp_val;
GO

--part 2 example
/* 
We will begin adding 10 employees to project p2 and 5 employees to the rest of the 
projects next month. How many employees each project will have next month.
We have a function that will return current number of employee for each project.
count_employee(@project_no)
*/

use sample;
GO
declare @pr_no varchar(20);
declare @pr_name varchar(20);

declare all_projects cursor
for
	select project_no, project_name
	from project;

open all_projects;

fetch next from all_projects
into @pr_no, @pr_name

while @@FETCH_STATUS = 0
begin
	print @pr_no + ' ' + @pr_name;
	declare @employee_count int;
	set @employee_count = dbo.count_employee(@pr_no);
	if(@pr_no = 'p2')
	begin
		print (@employee_count + 10);
	end
	else 
	begin
		print (@employee_count + 5);
	end
	fetch next from all_projects
	into @pr_no, @pr_name
end

close all_projects;
deallocate all_projects;

