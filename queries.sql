-- login to SQL
mysql -u root

-- show all databases
show databases;

-- to create a new database
create database <database-name>;

-- switch to existing database
use <database-name>;

-- to see tables in a database
show tables;

-- see all rows on a table
select * from vets;

-- Type out here before  doing on command line
create table if not exists vets (
    vet_id int unsigned auto_increment primary key,
    fname varchar(100),
    lname varchar(100)
)engine = innodb;

-- add `` to prevent sql from getting confuse if name and type are the same
create table if not exists medicines (
    medicine_id int unsigned auto_increment primary key,
    `name` varchar(100), 
    description text
)engine = innodb;

-- inserting data
-- vet_id will be automatically set by auto increment
insert into vets (fname, lname) values("Willaim", "Tan"), ("Ashley", "Wong"), ("David", "Teo");
-- Need to insert all the values together cannot have any blank as not null
insert into pet_owners (fname, lname, email) values("Tom", "Tan", "tom.tan@gmail.com"), ("Wendy", "Wong", "wendy.wong.gmail.com"), ("Ted", "Teo", "ted.teo@gmail.com");
insert into pet_owners (email) values("tom.tan@gmail.com"), ("wendy.wong.gmail.com"), ("ted.teo@gmail.com");

-- to see all columns in a table
describe pet_owners;

-- to delete table
drop table vets;

-- update
update pet_owners set email="andy@gmail.com" where pet_owner_id=1;

-- delete
delete from pet_owners where pet_owner_id=1;

-- alter existing table
alter table pet_owners add contact_number varchar(20);
alter table vets modify fname varchar(255) not null;

-- remove columns
alter table pet_owners drop contact_number;

-- add phone number but it does not exist so set default to n/a
alter table vets add contact_number varchar(20) not null default "n/a";

-- Create pet
create table if not exists pets (
    pet_id int unsigned  primary key auto_increment,
    name varchar(100) not null
)engine = InnoDB;

-- Add foreign key
-- Create pet table 
-- Describe the table to get the exact type
alter table pets add pet_owner_id int unsigned;
alter table pets add constraint fk_pet_owner_id foreign key (pet_owner_id) references pet_owners(pet_owner_id);
alter table pet_owners modify pet_owner_id int unsigned; -- coz it was tinyint so need to change back to int
-- Insert new pet
insert into pets (name, pet_owner_id) values ("Tiger", 3);

-- Create tables with fks
create table shifts (
    shift_id int unsigned primary key auto_increment,
    day tinyint not null,
    start time not null,
    end time not null,
    vet_id int unsigned not null,
    foreign key(vet_id)
        references vets (vet_id)
) engine =InnoDB;

-- insert shift for vet
insert into shifts (day, start, end, vet_id) values (1, "17:00", "19:00", 1);

-- to change pet owner to customer
-- foreign key type must be same as the original table
create table appointments (
    appointment_id int unsigned primary key auto_increment,
    customer_id int unsigned not null,
    foreign key (customer_id) references pet_owners (pet_owner_id),
    pet_id int unsigned not null,
    foreign key (pet_id) references pets (pet_id),
    vet_id int unsigned not null,
    foreign key (vet_id) references vets (vet_id),
    `datetime` datetime not null
) engine = InnoDB;

-- modify table to point to itself
alter table appointments add preceding_appointment_id int unsigned;
alter table appointments add constraint fk_preceding_appointment_id 
    foreign key (preceding_appointment_id) references appointments(appointment_id);
