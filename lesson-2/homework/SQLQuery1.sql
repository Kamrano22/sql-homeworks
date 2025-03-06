select  * from sys.databases;
create database exams_db;
create schema subjects;

create table subjects.students (
student_id int identity(1,1) primary key,
student_name varchar(250),
student_grade varchar(100),
subjects varchar(150),
)
insert into subjects.students
(student_grade,student_name,subjects)
values
('B','Azizbek','Physics')
select * from subjects.students;
delete from subjects.students;
Alter table subjects.students
add score int;
 delete from subjects.students where score = 'marks';
 insert into subjects.students (score)  values ('50')
 delete from subjects.students where score = '50';
  truncate table  subjects.students
  drop table subjects.students;
  select * from information_schema.tables