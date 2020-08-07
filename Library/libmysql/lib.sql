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
