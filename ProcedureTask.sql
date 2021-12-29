Create Database ProcedureTask

use ProcedureTask

create table Authors(
	Id int primary key identity,
	[Name] nvarchar(40) not null,
	Surname nvarchar(50) not null
)

Create Table Books(
	Id int primary key identity,
	[Name] nvarchar(100) check(LEN([Name])>=2),
	AuthorId int constraint FK_AuthorID foreign key (AuthorId) references Authors(Id),
	[PageCount] int check([PageCount]>=10)
)

Insert into Authors
values ('William','Shakespeare'),
('Leo','Tolstoy'),
('Charles','Dickens'),
('Jack','London'),
('Franz','Kafka'),
('Sabahattin','Ali'),
('Cemal','Sureya'),
('Victor','Hugo'),
('Grigory','Petrov'),
('Richard','Bach')


Insert into Books
values ('Romeo and Juliet',1,300),
		('Kumarbaz',2,250),
		('Issiz Ada',3,450),
		('Beyaz Dis',4,400),
		('Donusum',5,270),
		('Kurk Mantolu Madonna',6,500),
		('Sicak Nal',7,130),
		('Melancholia',8,210),
		('Idealist Ogretmen',9,300),
		('A gift of wings',10,170)



insert into Books
values('Roman12',6,500),
		('Seirler',7,130),
		('Melodiya',8,210),
		('Ogretmen',9,300),
		('Lord of ring',10,170)
insert into Books
values('Boyuk Iskender',6,1500),
		('Suc ve ceza',7,1230),
		('Bizimkiler',8,780),
		('Su ve Ates',9,600),
		('Dasli Qala',10,370)

Select b.id,b.Name,b.PageCount,(a.Name + ' ' + a.Surname) as AuthorFullName from Books b
join Authors a
on b.AuthorId=a.Id


create view vw_showall
as 
Select b.id,b.Name,b.PageCount,(a.Name + ' ' + a.Surname) as AuthorFullName from Books b
join Authors a
on b.AuthorId=a.Id


Select * from vw_showall

Create procedure usp_showDetails
@Name nvarchar(70),
@AuthorFullName nvarchar(120)
as
Select * from vw_showall where Name=@Name and AuthorFullName=@AuthorFullName

exec usp_showDetails 'Kumarbaz','Leo Tolstoy'


Create procedure usp_SearchNameFullName
@Name nvarchar(70),
@AuthorFullName nvarchar(120)
as
Select * from vw_showall where [Name] like'%'+@Name+'%' and AuthorFullName like'%'+@AuthorFullName+'%'


exec usp_SearchNameFullName 'Kumar','Leo'

--Delete Procedure
Create procedure usp_DeleteInfo
@Name nvarchar(60)
as
Delete from Books
where Name=@Name

exec usp_DeleteInfo 'Sicak Nal'


--Insert Procedure
Create procedure usp_InsertInfo
@Name nvarchar(100),
@PageCount int,
@AuthorId int
as
If(Len(@Name)>=2 and (@PageCount)>=10)
Begin
Insert into Books(Name,AuthorId,PageCount)
values (@Name,@AuthorId,@PageCount)
End

exec usp_InsertInfo 'Sicak Nal',7,125

create procedure usp_update
@Id int,
@Name nvarchar(40)
as 
update Books
set Name=@Name
where Id=@Id

exec usp_update 2,'sefiller'

create view vw_showAuthorDetails
as 
Select a.Id as Id,(a.Name+ ' ' + a.Surname) as AuthorFullName,Count(b.Id) as BookCount,Max(PageCount) as MaxPage from Books b
join Authors a
on b.AuthorId=a.Id
group by a.Id,(a.Name+ ' ' + a.Surname)

select * from vw_showAuthorDetails

