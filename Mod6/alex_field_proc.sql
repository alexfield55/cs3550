

use sample;

--while loop example from video
while (select sum(budget) from project) < 500000
begin
	print 'here'
	update project set budget = budget * 1.1
	if(select max(budget) from project) > 240000
		break
	else
		continue
end

begin 

--try/catch example from video
try 
	begin transaction
	insert into employee values (1111,'Ann', 'Smith', 'd2');
	insert into employee values (2222,'Matt', 'Jones', 'd2');
	insert into employee values (666,'Alan', 'Fields', 'd2');
	commit transaction
end try
begin catch
	rollback
	print 'The transaction is rollbacked. None of the employees are added.'
end catch

--local temp table
create table #project_temp 
(
	project_no varchar(5) not null,
	project_name varchar(50) not null
)
insert into #project_temp(project_no,project_name)
(
	select project_no, project_name 
	from project
)

--global temp table
create table ##project_temp 
(
	project_no varchar(5) not null,
	project_name varchar(50) not null
)
insert into ##project_temp(project_no,project_name)
(
	select project_no, project_name 
	from project
)