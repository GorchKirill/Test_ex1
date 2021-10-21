create database Library;
use Library;
CREATE TABLE publishing (
id serial PRIMARY KEY, 
publishing varchar(100)
);
CREATE TABLE student (
id serial PRIMARY KEY,
Name_student varchar(100),
faculty_student varchar(100),
Number_phone int 
);
CREATE TABLE author (
id serial PRIMARY KEY,
FIO_author varchar(100)
);
CREATE TABLE books (
id_book serial PRIMARY KEY,
id_author integer references author(id),
id_publishing integer references publishing(id), 
year date
);
CREATE TABLE author_book (
ID integer references author(id),
book_id integer references books(id)
);
CREATE TABLE issue_book (
id serial PRIMARY KEY,
student_id integer references student(id),
book_id integer references books(id), 
date_of_issue date, 
date_of_return date
);
CREATE TABLE Exemplar (
id serial PRIMARY KEY,
book_id integer references books(id)
);
CREATE TABLE Status (
id serial PRIMARY KEY,
availability varchar(100),
availab_all int,
to_issue int
);
CREATE TABLE Exemplar_status (
exem_id integer references Exemplar(id) ,
status_id integer references Status(id)
);

insert Library.books (id_book, id_author, id_publishing, year) values (1,1,1, '1990-01-01');
insert Library.books (id_book, id_author, id_publishing, year) values (2,2,2, '1991-03-25');
insert Library.books (id_book, id_author, id_publishing, year) values (3,3,3, '1997-11-12');
insert Library.books (id_book, id_author, id_publishing, year) values (4,4,4, '1996-01-01');

replace issue_book (id, student_id, book_id, date_of_issue, date_of_return) values (1,1,1, '2020-01-01', '2020-02-15');
replace issue_book (id, student_id, book_id, date_of_issue, date_of_return) values (2,2,2, '2020-01-01', '2020-02-01');
replace issue_book (id, student_id, book_id, date_of_issue, date_of_return) values (3,3,3, '2020-01-01', '2020-01-15');
replace issue_book (id, student_id, book_id, date_of_issue, date_of_return) values (4,4,4, '2020-01-01', '2020-01-27');
replace issue_book (id, student_id, book_id, date_of_issue, date_of_return) values (1,1,1, '2020-03-01', '2020-03-27');
insert issue_book (id, student_id, book_id, date_of_issue, date_of_return) values (6,1,1, '2020-05-01', '2020-05-27');
replace issue_book (id, student_id, book_id, date_of_issue, date_of_return) values (6,1,1, '2020-05-01', '2020-05-27');

insert author (id,FIO_author) values (1, 'Пушкин');
insert author (id,FIO_author) values (2, 'Грибоедов');
insert author (id,FIO_author) values (3, 'Достоевский');
insert author (id,FIO_author) values (4, 'Гоголь');

insert author_book (ID,book_id) values (1,1);
insert author_book (ID,book_id) values (2,2);
insert author_book (ID,book_id) values (3,3);
insert author_book (ID,book_id) values (4,4);
select*from status;
replace exemplar (id,book_id) values (1,1);
replace exemplar (id,book_id) values (2,2);
replace exemplar (id,book_id) values (3,3);
replace exemplar (id,book_id) values (4,4);

replace status (id,availability,availab_all,to_issue) values (1,'yes',10,5);
replace status (id,availability,availab_all,to_issue) values (2,'yes',11,3);
replace status (id,availability,availab_all,to_issue) values (3,'yes',4,1);
replace status (id,availability,availab_all,to_issue) values (4,'yes',23,4);
 
 insert exemplar_status (exem_id,status_id) values (1,1);
 insert exemplar_status (exem_id,status_id) values (2,2);
 insert exemplar_status (exem_id,status_id) values (3,3);
 insert exemplar_status (exem_id,status_id) values (4,4);
 
  replace student (id,Name_student,faculty_student,Number_phone) values (1,'Вася Пупкин Антонов','ФМА',12645);
  insert student (id,Name_student,faculty_student,Number_phone) values (2,'Антон Редькин Васильевич','ФЛА',14345);
  insert student (id,Name_student,faculty_student,Number_phone) values (3,'Андрей Никитич Павлов','ФГО',12336);
  insert student (id,Name_student,faculty_student,Number_phone) values (4,'Анна Мешкова Андреевна','ФБ',12674);
  
  replace publishing(id,publishing) values (1,'ЭМО');
  insert publishing(id,publishing) values (2,'ФСО');
  insert publishing(id,publishing) values (3,'МГМО');
  insert publishing(id,publishing) values (4,'УФОГ');
# Запрос для Злостного автора
select Name_student, count(issue_book.id) as Count  
from student 
join issue_book
on student.id = issue_book.student_id 
where issue_book.date_of_issue between '2020-01-01' and '2021-01-01' 
group by Name_Student 
having sum(date_of_return - date_of_issue)>30  
order by count(Name_student) desc limit 1;
#Запрос для популярного автора
SELECT  
FIO_author
FROM author
JOIN author_book 
ON author.id=author_book.ID
JOIN books
ON author_book.book_id=books.id_author
JOIN issue_book
ON books.id_book = issue_book.book_id
WHERE date_of_issue BETWEEN '2020-01-01' AND '2021-01-01'  
GROUP BY FIO_author
ORDER BY count(*) desc
limit 1;








