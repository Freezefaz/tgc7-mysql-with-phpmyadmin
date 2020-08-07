-- create database
create database library

-- only InnoDB supports foreign keys

create table books (
    book_id int unsigned primary key auto_increment,
    title varchar(200) not null
) engine = InnoDB;

create table publishers (
    publisher_id int unsigned primary key auto_increment,
    name varchar(100) not null,
    address varchar(255) not null,
    email varchar(50) not null
) engine = InnoDB;

create table members (
    member_id int unsigned primary key auto_increment,
    fname varchar(100) not null,
    lname varchar(100) not null,
    address varchar(255) not null
) engine = InnoDB;

create table authors (
    author_id int unsigned primary key auto_increment,
    fname varchar(100) not null,
    lname varchar(100) not null,
    date_of_birth datetime
) engine = InnoDB;

create table editions(
    edition_id int unsigned primary key auto_increment,
    ISBN varchar(13) not null,
    publisher_id int unsigned not null,
    foreign key(publisher_id) references publishers (publisher_id),
    book_id int unsigned not null,
    foreign key(book_id) references books (book_id)
) engine = InnoDB;

create table writing_credits(
    writing_credits_id int unsigned primary key auto_increment,
    author_id int unsigned not null,
    foreign key(author_id) references authors (author_id),
    book_id int unsigned not null,
    foreign key(book_id) references books (book_id)
) engine = InnoDB;

create table reservations(
    reservations_id int unsigned primary key auto_increment,
    member_id int unsigned not null,
    foreign key(member_id) references members (member_id)
) engine = InnoDB;

create table copies(
    copies_id int unsigned primary key auto_increment,
    book_id int unsigned not null,
    foreign key(book_id) references books (book_id),
    quality tinyint unsigned,
    reservations_id int unsigned not null,
    foreign key(reservations_id) references reservations (reservations_id)
) engine = InnoDB;

create table loans(
    loan_id int unsigned primary key auto_increment,
    date_due date,
    date_returned date,
    copies_id int unsigned not null,
    foreign key(copies_id) references copies (copies_id),
    member_id int unsigned not null,
    foreign key(member_id) references members (member_id)
) engine = InnoDB;


-- select all rows with specific columns
select firstname, lastname, email from employees

-- select rows with specific criteria
select * from employees where employeenumber = 1088;

-- get specific details with specific criteria
select firstname, lastname, email from employees where officecode = 1;

-- Compund criteria like if else
-- And has higher priority than or 
select * from employees where officecode = 1 and jobtitle = "Sales rep";
select * from employees where officecode = 1 or officecode = 4;

-- officecode 1 will have all the job title but officecode 4 will only have sales rep
select * from employees where officecode = 1 or officecode = 4 and jobtitle = "Sales rep";

-- Brackets means 1 or 4 only sales rep
select * from employees where (officecode = 1 or officecode = 4) and jobtitle = "Sales rep";

-- for any jobs that starts with criteria, NOT CASE SENSITIVE BUT MUST USE LIKE
select * from employees where jobtitle like "Sales%";
select * from employees where jobtitle like "%Sales";
select * from employees where jobtitle like "%Sales%";

-- to combine 2 tables into 1 base on matching criteria
-- office code will be repeated
select * from employees join office on
    employees.officecode = office.officecode;
select firstname, lastname, email from employees join office on
    employees.officecode = office.officecode;

