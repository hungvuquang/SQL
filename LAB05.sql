IF EXISTS (SELECT * FROM sys.databases WHERE Name='Lab05')
DROP DATABASE Lab05
GO
CREATE DATABASE Lab05
GO
-- Bang Book
CREATE TABLE Book(
	BookCode INT NOT NULL PRIMARY KEY,
	BookTitle VARCHAR(100) UNIQUE,
	--Person_ID uniqueidentifier DEFAULT NEWID() NOT NULL,
	Author VARCHAR(50) UNIQUE,
	Edition INT,
	BookPrice MONEY NOT NULL DEFAULT (100),
	Copies INT
)
GO
INSERT INTO BOOK(BookCode, BookTitle,Author,Edition,BookPrice,Copies) VALUES (1, 'Story', 'Hung', 2022, 10, 10) 
INSERT INTO BOOK(BookCode, BookTitle,Author,Edition,BookPrice,Copies) VALUES (2, 'Book', 'Thi', 2022, 10, 10)
INSERT INTO BOOK(BookCode, BookTitle,Author,Edition,BookPrice,Copies) VALUES (3, 'Economy', 'Eric', 2021,10, 20)
INSERT INTO BOOK(BookCode, BookTitle,Author,Edition,BookPrice,Copies) VALUES (4, 'Sience', 'Alex', 2020, 10, 10)
INSERT INTO BOOK(BookCode, BookTitle,Author,Edition,BookPrice,Copies) VALUES (5, 'History', 'Tom', 2019, 11, 30)

-- Bang Member
CREATE TABLE Member(
		MemberCode INT PRIMARY KEY,
		Name VARCHAR(50) UNIQUE,
		Address VARCHAR(100) UNIQUE,
		PhoneNumber INT
)
GO 

INSERT INTO Member(MemberCode,Name,Address,PhoneNumber) VALUES (1,'Hung','75 DTH', 888263999)
INSERT INTO Member(MemberCode,Name,Address,PhoneNumber) VALUES (2,'Thi','FPT', 888263990)
INSERT INTO Member(MemberCode,Name,Address,PhoneNumber) VALUES (3,'Trang','TT9', 888263991)
GO
-- Bang IssueDetails:

CREATE TABLE IssueDetails(
		BookCode INT PRIMARY KEY,
		MemberCode INT,
		IssueDate DATE,
		ReturnDate DATE,
		CONSTRAINT fk1 FOREIGN KEY (BookCode) REFERENCES Book(BookCode),
		CONSTRAINT fk2 FOREIGN KEY (MemberCode) REFERENCES Member(MemberCode)
)
insert into  IssueDetails values (1,1,'2022-05-27','2022-06-27')
insert into  IssueDetails values (3,3,'2022-05-25','2022-06-25')
GO

select * from IssueDetails 
drop table IssueDetails
-- Xoa, them bot cac rang buoc:
--Xoa rang buoc khoa ngoai cua bang IssueDetails
ALTER TABLE IssueDetails DROP CONSTRAINT FK1
ALTER TABLE IssueDetails DROP CONSTRAINT FK2
-- Xoa rang buoc khoa chinh
ALTER TABLE Member DROP PRIMARY KEY
ALTER TABLE Book DROP PRIMARY KEY
--Them moi rang buoc khoa chinh cho bang book, member
ALTER TABLE Member ADD CONSTRAINT MemberCode  PRIMARY KEY 
ALTER TABLE Book ADD CONSTRAINT BookCode PRIMARY KEY 

--Them moi rang buoc ngoai khoa cho bang IssueDetails
ALTER TABLE IssueDetails ADD CONSTRAINT FK1 FOREIGN KEY BookCode REFERENCES Book(BookCode)

-- Bo sung giang buoc  gia ban sachs >0
ALTER TABLE Book ADD CONSTRAINT BookPrice CHECK (BookPrice >0)

-- Bổ sung thêm Ràng buộc duy nhất cho PhoneNumber của bảng Member
--ALTER TABLE Member DROP PhoneNumber PRIMARY KEY
ALTER TABLE Member ADD CONSTRAINT PhoneNumber PRIMARY KEY

Bổ sung thêm ràng buộc NOT NULL cho BookCode, MemberCode trong bảng IssueDetails
ALTER TABLE IssueDetails ADD COLUMN BookCode NOT NULL
ALTER TABLE IssueDetails ADD COLUMN MemberCode NOT NULL

DROP TABLE MEMBER

SELECT * FROM IssueDetails
SELECT * FROM Book
SELECT * FROM Member