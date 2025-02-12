create database LibrarySystem;
use LibrarySystem;


create table Categories(
ID int primary key,
name varchar(50),
description varchar(50)
);

create table Members(
ID int primary key,
name varchar(50),
contactInfo varchar(50),
MembershipType varchar(50),
regestrationDate date

);

create table libraryStaff(
ID int primary key,
name varchar(50),
contactInfo varchar(50),
assignedSection varchar(50),
employmentDate date

);


create table Books(
ID int primary key,
title varchar(50),
author varchar(50),
genre varchar(50),
publicationYear date,
availabilityStatus varchar(50),
category_id int,
FOREIGN KEY (category_id) REFERENCES Categories(ID)

);


create table Borrowing(
ID int primary key,
member_id int,
book_id int,
borrowingDate date,
dueDate date,
returnDate date,
FOREIGN KEY (member_id) REFERENCES Members(ID),
FOREIGN KEY (book_id) REFERENCES Books(ID)

);



create table Reservation (
ID int primary key,
member_id int,
book_id int,
reservationDate date,
status varchar(50),
FOREIGN KEY (member_id) REFERENCES Members(ID),
FOREIGN KEY (book_id) REFERENCES Books(ID)
);

-- إدراج بيانات في جدول Categories
INSERT INTO Categories (ID, name, description) VALUES
(1, 'Science Fiction', 'Books related to Sci-Fi'),
(2, 'Databases', 'Books related to Database Management'),
(3, 'Programming', 'Books related to Coding'),
(4, 'History', 'Historical Books'),
(5, 'Philosophy', 'Books about philosophical thoughts');

-- إدراج بيانات في جدول Members
INSERT INTO Members (ID, name, contactInfo, MembershipType, regestrationDate) VALUES
(1, 'Ali', '123456789', 'Student', '2025-01-01'),
(2, 'Sara', '987654321', 'Regular', '2024-06-10'),
(3, 'Omar', '111222333', 'Premium', '2023-11-15'),
(4, 'Laila', '444555666', 'Student', '2024-08-20'),
(5, 'Hassan', '777888999', 'Regular', '2025-02-05');

-- إدراج بيانات في جدول libraryStaff
INSERT INTO libraryStaff (ID, name, contactInfo, assignedSection, employmentDate) VALUES
(1, 'Ahmed', '123123123', 'Science Fiction', '2022-05-10'),
(2, 'Mona', '321321321', 'Databases', '2021-09-15'),
(3, 'Khalid', '456456456', 'Programming', '2023-03-01'),
(4, 'Fatima', '789789789', 'History', '2020-12-05'),
(5, 'Ziad', '159159159', 'Philosophy', '2024-07-30');

-- إدراج بيانات في جدول Books
INSERT INTO Books (ID, title, author, genre, publicationYear, availabilityStatus, category_id) VALUES
(1, 'Dune', 'Frank Herbert', 'Science Fiction', '1965-01-01', 'Available', 1),
(2, 'Database Fundamentals', 'C.J. Date', 'Databases', '2010-01-01', 'Borrowed', 2),
(3, 'Clean Code', 'Robert C. Martin', 'Programming', '2008-01-01', 'Available', 3),
(4, 'Sapiens', 'Yuval Noah Harari', 'History', '2011-01-01', 'Available', 4),
(5, 'The Republic', 'Plato', 'Philosophy', '0380-01-01', 'Borrowed', 5);

insert into Books values(9, 'Database Fundamentals', 'C.J. Date', 'Databases', '2010-05-01', 'Available', 2);

-- إدراج بيانات في جدول Borrowing
INSERT INTO Borrowing (ID, member_id, book_id, borrowingDate, dueDate, returnDate) VALUES
(1, 1, 2, '2025-01-02', '2025-01-12', NULL),
(2, 2, 3, '2024-07-01', '2024-07-10', '2024-07-08'),
(3, 3, 1, '2023-12-20', '2023-12-30', '2023-12-31'),
(4, 4, 5, '2024-08-22', '2024-09-01', NULL),
(5, 5, 4, '2025-02-06', '2025-02-16', NULL);

insert into Borrowing values(7, 3, 9, '2023-11-20', '2023-12-29', '2023-12-31');
insert into Borrowing values(8, 3, 2, '2023-11-20', '2023-12-29', '2023-12-31');
insert into Borrowing values(9, 4, 2, '2023-9-20', '2023-10-29', '2023-12-31');
-- إدراج بيانات في جدول Reservation
INSERT INTO Reservation (ID, member_id, book_id, reservationDate, status) VALUES
(1, 1, 2, '2025-01-05', 'Pending'),   -- Ensure book_id = 2 exists
(2, 2, 1, '2024-06-15', 'Confirmed'), -- Ensure book_id = 1 exists
(3, 3, 5, '2023-11-20', 'Cancelled'), -- Ensure book_id = 5 exists
(4, 4, 3, '2024-08-25', 'Confirmed'), -- Ensure book_id = 3 exists
(5, 5, 4, '2025-02-07', 'Pending');   -- Ensure book_id = 4 exists


select* from Members
where regestrationDate='2023-11-15';

select* from Books
where title='Database Fundamentals';

alter table Members add email varchar(50);

INSERT INTO Members (ID, name, contactInfo, MembershipType, regestrationDate, email) VALUES
(7, 'Omar', '9876543210', 'Student', '2025-02-01','Omar@gmail.com');


SELECT DISTINCT Members.name
FROM Members
INNER JOIN Reservation ON Members.ID = Reservation.member_id;


select Members.name , Books.title
from Members
inner join Borrowing on Members.ID=Borrowing.member_id
inner join Books on Books.ID=Borrowing.book_id
where Books.title='Clean Code';

select Members.name,Books.title
from Members
inner join Borrowing on Members.ID=Borrowing.member_id
inner join Books on Books.ID=Borrowing.book_id
WHERE Books.title = 'Database Fundamentals' AND Borrowing.returnDate IS NOT NULL;

select *
from Members
inner join Borrowing on Members.ID=Borrowing.member_id
where returnDate>dueDate
;

SELECT Books.title, COUNT(Borrowing.book_id) 
FROM Borrowing
INNER JOIN Books ON Books.ID = Borrowing.book_id
GROUP BY Books.title
HAVING COUNT(Borrowing.book_id) > 3;


select *
from Members
inner join Borrowing on Members.ID=Borrowing.member_id
WHERE Borrowing.borrowingDate BETWEEN '2023-12-20' AND '2024-08-22';

select COUNT(*)
from Books 
where availabilityStatus='Available';

SELECT DISTINCT Members.name
FROM Members
INNER JOIN Borrowing ON Members.ID = Borrowing.member_id
WHERE Borrowing.returnDate IS NULL;

SELECT DISTINCT Members.name
FROM Members
INNER JOIN Borrowing ON Members.ID = Borrowing.member_id
INNER JOIN Books ON Borrowing.book_id = Books.ID
INNER JOIN Categories ON Books.category_id = Categories.ID
WHERE Categories.name = 'Science Fiction';
