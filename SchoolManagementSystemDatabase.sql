create database SchoolManagementSystem;
use SchoolManagementSystem;

create table student(
ID int primary key,
name varchar(50),
dateOfBirth date,
address varchar(50),
);

create table family_info(
ID int primary Key,
name varchar(50),
phoneNumber varchar(50),
studentID int unique,
FOREIGN KEY (studentID) REFERENCES student(ID)
);
create table classes(
ID int primary Key,
classCode int ,
roomNumber int,
schedule varchar(50)
);
create table courses(
ID int primary Key,
name varchar(50),
description varchar(50),
resource varchar(50),
classID int ,
FOREIGN KEY (classID) REFERENCES classes(ID),
);
create table student_class(
studentID int,
classID int,
FOREIGN KEY (studentID) REFERENCES student(ID),
FOREIGN KEY (classID) REFERENCES classes(ID),

);


create table student_courses(
studentID int ,
coursesID int,
FOREIGN KEY (studentID) REFERENCES student(ID),
FOREIGN KEY (coursesID) REFERENCES courses(ID),
);

create table assignment(
ID int primary Key,
name varchar(50),
description varchar(50),
dueDate date ,
statuse varchar(50),
courseID int,
FOREIGN KEY (courseID) REFERENCES courses(ID),
);
create table student_assignment(
studentID int ,
assignmentID int,
FOREIGN KEY (studentID) REFERENCES student(ID),
FOREIGN KEY (assignmentID) REFERENCES assignment(ID),
);

create table attendence(
ID int primary Key,
attdate date,
absence varchar(50),
studentID int,
FOREIGN KEY (studentID) REFERENCES student(ID),

);

INSERT INTO student (ID, name, dateOfBirth, address)
VALUES 
(1, 'yara', '2005-06-15', 'Irbid'),
(2, 'sama', '2006-08-22', 'Amman'),
(3, 'lana', '2004-12-10', 'Irbid');

INSERT INTO family_info (ID, name, phoneNumber, studentID)
VALUES 
(1, 'Aws', '555-1234', 1),
(2, 'Eyad', '555-5678', 2),
(3, 'Zaid', '555-9101', 3);

INSERT INTO classes (ID, classCode, roomNumber, schedule)
VALUES 
(1, 101, 201, 'Mon-Wed-Fri 10:00 AM'),
(2, 102, 202, 'Tue-Thu 2:00 PM'),
(3, 103, 203, 'Mon-Fri 9:00 AM');


INSERT INTO courses (ID, name, description, resource, classID)
VALUES 
(1, 'Arabic', 'Poem', 'Textbook', 1),
(2, 'Physics', 'Newtonian Mechanics', 'Lab Equipment', 2),
(3, 'English', 'Literature and Writing', 'Library Books', 3);

INSERT INTO student_class (studentID, classID)
VALUES 
(1, 1),
(1, 2),
(2, 1),
(3, 3),
(3, 2);

INSERT INTO student_courses (studentID, coursesID)
VALUES 
(1, 1),
(1, 2),
(2, 3),
(3, 2),
(3, 1);

INSERT INTO assignment (ID, name, description, dueDate, statuse, courseID)
VALUES 
(1, 'Arabic Assignment', 'Poem Homework', '2024-02-20', 'Pass', 1),
(2, 'Physics Lab Report', 'Projectile Motion Experiment', '2024-03-05', 'Failed', 2),
(3, 'Essay Writing', 'Shakespeare Analysis', '2024-03-10', 'Pass', 3);

INSERT INTO student_assignment (studentID, assignmentID)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(1, 3),
(2, 1);

INSERT INTO attendence (ID, attdate, absence, studentID)
VALUES 
(1, '2024-01-02', 'Leaving', 1),
(2, '2024-01-03', 'Absent', 2),
(3, '2024-01-04', 'Late', 3),
(4, '2024-01-05', 'Leaving', 1),
(5, '2024-01-06', 'Absent', 2);

select name
from student
where dateOfBirth='2006-08-22';

select description
from courses
where name='Physics';

alter table student add email varchar(50);

INSERT INTO student (ID, name, dateOfBirth, address)
VALUES 
(5, 'Layla', '2001-11-12', 'Irbid');


SELECT  student.name,family_info.name  
FROM student
INNER JOIN family_info ON student.ID = family_info.studentID;

select student.name,courses.name
from student 
INNER JOIN student_courses ON student.ID = student_courses.studentID
INNER JOIN courses ON student_courses.coursesID = courses.ID
where courses.name='English';

select student.name,assignment.statuse
from student
inner join student_assignment on student.ID=student_assignment.studentID
inner join assignment on student_assignment.assignmentID=assignment.ID
where assignment.name='Essay Writing'
And assignment.statuse='pass';

select student.name,attendence.absence
from student
inner join attendence on student.ID=attendence.studentID
WHERE attendence.attdate BETWEEN '2024-01-01' AND '2024-01-05'
AND attendence.absence = 'Leaving';

