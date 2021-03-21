--DML trigger application area 1
--creating audit trails
--(1) create an audit trail table
--(2) enter entries into audit trail table on update, delete, and insert
--whenever budget gets updated in project table keep track of 
--old values, recent values, who did it, time it was performed

use sample_book;
GO
create table audit_budget
(
	project_no char(4) null,
	user_name char(20) null,
	date datetime null,
	budget_old decimal null,
	budget_new decimal null,
)
GO
use sample_book;
GO
create trigger modify_budget
on project
after update
as
print 'inside trigger'
if update(budget)
begin
	declare @old_budget float;
	declare @new_budget float;
	declare @project_no char(4);
	select @old_budget = (select budget from deleted);
	select @new_budget = (select budget from inserted);
	select @project_no = (select project_no from deleted);
	insert into audit_budget values 
	(@project_no, USER_NAME(), GETDATE(), @old_budget, @new_budget)
end
GO
update project
set budget = 190000
where project_no = 'p3'
select * from audit_budget

--DML Trigger application area 2
--creating business rules
--trigger total_budget to tests modifications
--for any project budget <= 1.5 * total budget or rollback

use sample_book;
go
alter trigger total_budget
on project
after update
as
if UPDATE(budget)
begin
	declare @sum_old1 float;
	declare @sum_old2 float;
	declare @sum_new float;
	select @sum_new = (select sum(budget) from inserted);
	select @sum_old1 =  (select sum(budget) from project p where p.project_no not in 
		(select project_no from deleted));
	select @sum_old2 =  (select sum(budget) from deleted);
	print @sum_new;
	print @sum_old1;
	print @sum_old2;
	if(@sum_new > ((@sum_old1 + @sum_old2) * 1.5))
	begin
		print 'no modification of budget';
		rollback transaction;
	end
	else
	begin
		print 'modification of budget executed';
	end
end
update project
set budget = 1000000
where project_no ='p2'

go 
use sample_book;
go

--usage 3
--trigger as integrity constraint

--sample
insert into employee values (12,'test','test','d2')


--what im testing
update works_on set emp_no=12 where emp_no = 10102;

go
use sample_book;
go
create trigger works_integrity
on works_on
after update
as
if update(emp_no)
begin	
	if(select count(*) from employee inner join 
	inserted on employee.emp_no = inserted.emp_no)=0
	begin
		print 'rollback transaction';
		rollback transaction;
	end
	else
	begin
		print 'transaction is successful';
	end
end

go
select * from employee
select * from works_on

--integrity part 2
--when employee updates check works_on table

use sample_book;
go
create trigger refint_workson2
on employee
after update
as
if update(emp_no)
begin
	if( select count(*) from works_on
	inner join deleted on works_on.emp_no = deleted.emp_no ) > 0
	begin
	print 'no modificaiton or update on rows.'
	rollback transaction
	end
	else
	print 'rows modified successfully.'
end
go

update employee set emp_no = 4 where emp_no = 18316


select * from employee