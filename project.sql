--database students
--show all students with their courses

create database students;
use students;
create table students
(
student_id int primary key auto_increment,
name varchar(100),
age int,
email varchar(100)
);
create table enrollments
(
enrollment_id int primary key auto_increment,
student_id int,
course_name varchar(100),
marks int,
foreign key (student_id) references 
students(student_id)
);

insert into students(name,age,email) values
('Rahul Sharma',20,'rahul@gmail.com'),
('Priya Mehta', 21,'Priya@gmail.com'),
('Amit Singh',19,'Amit@gmail.com');

insert into enrollments(student_id,course_name,marks) values
(1,'Maths',85),
(1,'Science',90),
(1,'English',88),
(2,'Maths',78),
(2,'English',42),
(3,'Science',88);

show databases;
--------------------------------------------------------------------------------------------------------------------------
use students;
select * from students;
insert into students(name,age,email) values
('Sneha Patil',22,'sneha@gmail.com'),
('Arjun Varma', 20,'arjun@gmail.com'),
('Neha Kapoor',21,'neha@gmail.com');
select * from students;
insert into enrollments(student_id,course_name,marks) values
(2,'science',80),
(3,'Maths',75),
(4,'Maths',88),
(4,'science',91),
(5,'English',84),
(5,'Maths',79),
(6,'Science',87);
select * from enrollments;
--Topic1- Basic select queries,used to retrieve and filter data from table based on conditions
like age,name pattern and sorting order
select * from students;
select name,email from students;
--students older than 20
select * from students where age>20;
--students whose name starts with R
select * from students where name like 'R%';
--students sorted by age descending
select * from students order by age desc;
--students sorted by age ascending
select * from students order by age asc;
--display only two students
select * from students limit 2;

--Topic2 Aggregate functions
use students;
select count(*) as total_students from students;
--average age
select avg(age) as avg_age from students;
--max,min marks
select max(marks) as highest_marks from enrollments;
select min(marks) as lowest_marks from enrollments;
--total marks
select sum(marks) as total_marks from enrollments;
--count number of courses taken by each student
select student_id,count(course_name) as total_courses
from enrollments
group by student_id;
select student_id,course_name, count(course_name) as total_courses
from enrollments
group by student_id,course_name;
--avg marks of each student
select student_id,avg(marks) as avg_marks from enrollments
group by student_id;
-----------------------------------------------------------------------------------------------------------
use students;
--average marks
select student_id, avg(marks) as avg_marks
from enrollments
group by student_id;
--avg marks >80
select student_id, avg(marks) as avg_marks
from enrollments
group by student_id
having avg(marks)>80;
--count number of courses
select student_id, count(*) as
total_courses from enrollments group by student_id;
--more than 2 courses
select student_id, count(*) as
total_courses from enrollments group by student_id
having count(*)>2;
--highest total marks per student
select student_id, sum(marks) as total_marks from enrollments 
group by student_id
order by total_marks desc;
--total marks>200
select student_id, sum(marks) as total_marks from enrollments 
group by student_id
having sum(marks) >200;

-------------------------------------------------------------------------------------------------------
use students;
--students scored more than avg marks
select student_id,marks from enrollments where marks>(select avg(marks) from enrollments);
--students with highest marks
select student_id, marks from enrollments where marks=(select max(marks) from enrollments); 
--students took same course as student_id=1
select distinct student_id from enrollments
where course_name in(select course_name from enrollments where student_id=1);
-- find students whose total marks is above average total marks
select student_id from enrollments 
group by student_id
having sum(marks) > (
select avg(total marks)
from(
select sum(marks) as total_marks from enrollments 
group by select_id
) as temp
);
--names of students who scored highest marks
select name from students
where student_id in(
select student_id from enrollments
where marks=(select max(marks) from enrollments)
);
-------------------------------------------------------------------------------------------------------------
use students;
create table student1
( 
student_id int primary key auto_increment,
name varchar(100),
age int,
email varchar(100)
);


--views
--create a view for student report

create view Student_Report as
select s.name, e.course_name, e.marks
from students s
join Enrollments e on s.student_id = e.student_id;

--Display data from view

SELECT * FROM Student_Report;
--View students with marks > 80

CREATE VIEW Top_Students AS
SELECT s.name, e.course_name, e.marks
FROM students s
JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.marks > 80;
--delete
DROP VIEW Student_Report;




