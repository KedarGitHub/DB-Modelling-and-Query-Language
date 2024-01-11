1. The tables in the PostgreSQL database were created using the following "CREATE TABLE" commands.

CREATE TABLE author(author_id int, name varchar(255) not null, primary key(author_id));

CREATE TABLE category( category_id int, category_name varchar(255) not null, primary key(category_id));

CREATE TABLE book_type( book_type_id int, book_type varchar(255) not null, primary key(book_type_id));

CREATE TABLE book( book_id int, book_title varchar(255) not null, book_type_id int, price float not null, primary key(book_id), foreign key(book_type_id) references book_type(book_type_id));

CREATE TABLE book_copy( unique_book_id int, published_year DATE not null, book_id int, published_by varchar(255) not null, available varchar(20) not null, primary key(unique_book_id), foreign key(book_id) references book(book_id));

CREATE TABLE book_category_relation( book_id int,category_id int,primary key(book_id,category_id),foreign key(category_id) references category(category_id),foreign key(book_id) references book(book_id));

CREATE TABLE book_author_relation(book_id int,author_id int,primary key(book_id,author_id),foreign key(author_id) references author(author_id),foreign key(book_id) references book(book_id));

CREATE TABLE Customer( customer_id_card_number serial, customer_first_name text not null, customer_last_name text not null, customer_age int not null, customer_address varchar(255) not null, customer_email varchar(255) unique, customer_status varchar(10) not null, primary key(customer_id_card_number));

CREATE TABLE checkout( checkout_id serial, issue_date DATE not null, due_date DATE not null,  actual_return_date date, fine float, unique_book_id int, customer_id_card_number int, primary key(checkout_id), foreign key(unique_book_id) references book_copy(unique_book_id), foreign key(customer_id_card_number) references Customer(customer_id_card_number)); 

2. The random dummy data was generated using the Python Faker package. Nine CSV files were created, and Python scripts were used to load the generated data into these files. The list of CSV files is as follows:

author.csv 
Book.csv 
book_author_relation.csv 
book_category_relation.csv 
book_copy.csv 
book_type.csv 
Category.csv 
Customer.csv 
checkout.csv 

The generated csv files are present in the .zip file under the folder "CSV Files using Python" 

3. Python scripts were utilized to establish a connection with the PostgreSQL database. Subsequently, the data from the CSV files was loaded into the database using these scripts. The .ipynb file is also present in the .zip file.

4. HTML5 templates are utilized to manage the front end of the website, while the back end functionalities are implemented using the Python libraries Flask and Flask-SQLAlchemy through the app.py file.

NOTE : Please refer to the project report for further details and references regarding the aforementioned information.
