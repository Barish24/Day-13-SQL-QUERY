CREate Database CollegeDB;
Use CollegeDB;
Create TABLE Student(
StudentID INT Primary key,
FullNAME VARCHAR(100) NOT NULL, 
Email VARCHAR(100) Unique NOT NULL,
Age INT CHECK( AGE >= 18)
);
CREATE TABLE Instructor(
InstructorID INT Primary KEY,
FullName VARCHAR(100),
Email VARCHAR(100) UNIQUE
);
Create TABLE Course(
courseID INT PRIMARY KEY,
FullName VARCHAR(100),
Email VARCHAR(100) UNIQUE
);
Drop Table Course; -- Dropping table will not work as F.K is implemented ;
Create Table Course(
CourseID INT PRIMARY KEY,
CourseName VARCHAR(100),
InstructorID INT,
Foreign KEY (InstructorID) References Instructor( InstructorID)
);
Create TABLE Enrollment(
EnrollmentID int Primary Key,
StudentID INT,
CourseID INT,
EnrollmentDate Date Default GETDATE(),
FOREIGN KEY(StudentID) REFERENCES Student(StudentID),
FOREIGN KEY(CourseID) REFERENCES Course(CourseID)
);
-- Inserting into above tables
Insert into Instructor values(1,'Dr. Smith','smith@gmail.comm');
Insert into Instructor values(2,'Prof. Rajesh','rajesh@gmail.com');
Insert into Course values(101,'Data Science');
  SELECT name 
FROM sys.key_constraints 
WHERE parent_object_id = OBJECT_ID('Cource');

ALTER TABLE Cource DROP CONSTRAINT UQ__Cource__A9D10534E6ABC9C2;
ALTER TABLE Cource DROP COLUMN Email;
select * from Course;

EXEC sp_rename 'Enrollment.Enrollment', 'EnrollmentDate', 'COLUMN';

insert into student values(1,'rohit','Rohit@ucla.uk',19);

insert into student values(2,'rashi','rashi@ucla.uk',20);

--inserting into Enrollment

insert into Enrollment values( 1001,1,101,GEtDATe());

-- Grand and Revoke
grant select on student to auditor;
grant select on Enrollment to auditor;

IF NOT EXISTS (SELECT * FROM sys.sql_logins WHERE name = 'auditor')
    CREATE LOGIN auditor WITH PASSWORD = 'StrongPassword123';

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'auditor')
    CREATE USER auditor FOR LOGIN auditor;

Revoke select on student from auditor;
select * from student;
-- Implementing a transaction with commit and roll back
begin transaction;
insert into student values(3, 'Alex ', 'Alex@hwd.edu',20);
insert into Enrollment values(1003,2,101,GETDATE());
commit;

-- rollback
Begin transaction;
Insert into Student values(4,'Angel','Angel@gmail.com',20);
rollback;

select * from Student;
Select * from Enrollment;
select * from Course;
select * from Instructor;
--inserting into student
insert into Student values(4,'Parth' ,'Parth@gmail.com',20);
insert into Student values(5,'Tushar' ,'Tushar@gmail.com',20);

-- inserting into instructor first;
insert into Instructor values( 3,'Prof. Navneet','navneet@gmail.com');
-- inserting into cource
insert into Course values(101,'data science',1);
insert into Course values(102,'Computer Applications',3);
insert into Course values(103,'C# using .net',2);

-- insert into enrollment
insert into Enrollment values(1001, 1,101,GETDATE());
insert into Enrollment values(1002, 4,101,GETDATE());

insert into Enrollment values(1003,5,102,GETDATE());

-- which student enrolled in which cource
SELECT 
    s.FullName, 
    c.CourseName
FROM 
    Student s
Left JOIN 
    Enrollment e ON s.StudentId = e.StudentId
left JOIN 
    Course c ON e.CourseId = c.CourseID;

-- Who is teaching the each cource 

Select i.FullName , c.CourseName from Instructor i
join 
   Course c on i.InstructorID= c.InstructorID;


   -- Create Procedure to view Student data by id
CREATE PROCEDURE GetStudentInfoById
    @StudentId INT
AS
BEGIN
    SELECT *
    FROM dbo.Students WHERE StudentId = @StudentId;
END;
GO   -- Marks end of the batch

-- Separate batch 2 (execution)
EXEC GetStudentInfoById @StudentId = 4;