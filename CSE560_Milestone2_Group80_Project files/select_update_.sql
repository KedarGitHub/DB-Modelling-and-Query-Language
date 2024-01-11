select b.book_title, Max(issue_date) from checkout c, book_copy bc, book b 
where c.unique_book_id=bc.unique_book_id and bc.book_id=b.book_id group by b.book_title order by Max(issue_date) desc limit 1;

select b.book_title, count(c.book_id) as books from book b, book_copy c 
where b.book_id=c.book_id group by b.book_title order by count(c.book_id) desc;

select b.book_title, count(c.book_id) as books from book b, book_copy c 
where b.book_id=c.book_id and available='Available' group by b.book_title order by count(c.book_id) desc

select unique_book_id, Max(issue_date) from checkout group by unique_book_id order by Max(issue_date) desc limit 1
select * from customer

/* Find the count of number of copies of the books which are available in the library currently*/

select b.book_title, count(c.book_id) as books from book b, book_copy c where b.book_id=c.book_id 
and available='Available' group by b.book_title order by b.book_title

/* Update the date of one tuple in the table in the Check out Table */

UPDATE checkout 
SET 
    issue_date = '2023-03-03',
	due_date= '2023-04-01',
	actual_return_date=Null
WHERE
    issue_date= '2023-04-03'

/* Query to update a copy of the book to null if it is not returned yet*/
UPDATE book_copy 
SET 
    available = 'Not'
WHERE
    unique_book_id = (select unique_book_id from checkout where actual_return_date Is Null)


/* Query to generate fine of the book, we charge 5% for each day extended*/
UPDATE checkout 
SET 
    fine = (actual_return_date-due_date)*0.05*(select b.price from book as b, book_copy as c 
			where b.book_id=c.book_id and c.unique_book_id in 
			(select unique_book_id from checkout) LIMIT 1)
WHERE
    actual_return_date>due_date

/* This query or the query below

select book_id,price from book where book_id in (
	select book_id from book_copy where unique_book_id in (
		select unique_book_id from checkout WHERE
    actual_return_date>due_date)) */

/* (select b.price,c.book_id,c.unique_book_id from book as b, book_copy as c where b.book_id=c.book_id and c.unique_book_id in (
		select unique_book_id from checkout WHERE
    actual_return_date>due_date))*/