drop table book_author_relation;
drop table author;
drop table book_category_relation;
drop table checkout;
drop table book_copy;
drop table book;
drop table category;
drop table book_type;
drop table Customer;

ALTER TABLE book
DROP COLUMN category_id;


CREATE TABLE author(
 author_id int,
 name varchar(255) not null,
 primary key(author_id)
);

CREATE TABLE category(
 category_id int,
 category_name varchar(255) not null,
 primary key(category_id)
);

CREATE TABLE book_type(
 book_type_id int,
 book_type varchar(255) not null,
 primary key(book_type_id)
);

CREATE TABLE book(
 book_id int,
 book_title varchar(255) not null,
 book_type_id int,
 price float not null,
 primary key(book_id),
 foreign key(book_type_id) references book_type(book_type_id)
);

CREATE TABLE book_copy(
 unique_book_id int,
 published_year DATE not null,
 book_id int,
 published_by varchar(255) not null,
 available varchar(20) not null,
 primary key(unique_book_id),
 foreign key(book_id) references book(book_id)
);

/*CREATE TABLE book_type_relation(
book_type_id int,
book_id int,
primary key(book_id,book_type_id),
foreign key(book_type_id) references book_type(book_type_id),
foreign key(book_id) references book(book_id)
);*/

CREATE TABLE book_category_relation(
book_id int,
category_id int,
primary key(book_id,category_id),
foreign key(category_id) references category(category_id),
foreign key(book_id) references book(book_id)
);

CREATE TABLE book_author_relation(
book_id int,
author_id int,
primary key(book_id,author_id),
foreign key(author_id) references author(author_id),
foreign key(book_id) references book(book_id)
);

CREATE TABLE Customer(
 customer_id_card_number serial,
 customer_first_name text not null,
 customer_last_name text not null,
 customer_age int not null,
 customer_address varchar(255) not null,
 customer_email varchar(255) unique,
 customer_status varchar(10) not null,
 primary key(customer_id_card_number)
);

CREATE TABLE checkout(
 checkout_id serial,
 issue_date DATE not null,
 due_date DATE not null, 
 actual_return_date date,
 fine float,
 unique_book_id int,
 customer_id_card_number int,
 primary key(checkout_id),
 foreign key(unique_book_id) references book_copy(unique_book_id),
 foreign key(customer_id_card_number) references Customer(customer_id_card_number)
); 

