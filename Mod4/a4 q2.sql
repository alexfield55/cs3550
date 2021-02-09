/*
The database should consist of 3 tables: Student, Assignment and StudentAssignment. 
Consider the following specification while implementing the tables. 


*student id is a primary key and cannot be empty

*Each student has a single unique email associated with the student. 

*dept_no can have the following values: CS, EE, PH, LIT, ENG, MATH. It cannot have more than 4 characters. 

*fname and lname cannot be empty. 

*The assignment id is a primary key and cannot be empty. 

*If the assignment name is not specified, we use "CS 3550 Assignment" as a dummy value. 

*The assignment description can be null. 

*The due date cannot be null. 

*Max_possible_grade is between 0 to 200. 

*The grade is between 0 to 200. 

*Submission_type consists of the following values: Text Entry, Media Recording, File Upload, Website URL.  
*/
use master;
drop database if exists student_assignments 
create database student_assignments
go
use student_assignments;

create table student
(
	studentID varchar(10) not null,
	fname varchar(25) not null,
	lname varchar(25) not null,
	email varchar(50),
	dept_no varchar(4)
	constraint dept_names check (dept_no in ('CS','EE','PH','LIT', 'ENG', 'MATH'))
	constraint unique_email unique (email),
	constraint prim_studentID primary key (studentID)
);

create table assignment
(
	assignment_id varchar(10) not null,
	name varchar(20) default 'CS 3550 Assignment',
	description  varchar(50) not null,
	due_date date not null,
	max_possible_grade float,
	submission_type varchar(30),
	constraint submission_names check (submission_type in ('Text Entry', 'Media Recording', 'File Upload', 'Website URL')),
	constraint max_grade check (max_possible_grade <= 200),
	constraint min_grade check (max_possible_grade >= 0),
	constraint prim_assignmentID primary key (assignment_id)

);

create table studentassignment
(
	assignment_id varchar(10) not null,
	studentID varchar(10) not null,
	submission_date date,
	grade float,
	constraint max_sagrade check (grade <= 200),
	constraint min_sagrade check (grade >= 0),
	constraint comp_key primary key (assignment_id, studentID),
	constraint foreign1_sa foreign key(assignment_id) references assignment(assignment_id),
	constraint foreign2_sa foreign key(studentID) references student(studentID)

)
