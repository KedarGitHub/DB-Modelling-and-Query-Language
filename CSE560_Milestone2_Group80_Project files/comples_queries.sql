/* retrieves information about book checkouts for active customers, including the book title, author name, category name, customer name, issue date, due date, actual return date, and fine*/

SELECT
  b.book_title AS "Book Title",
  a.name AS "Author Name",
  cat.category_name AS "Category Name",
  CONCAT(cust.customer_first_name, ' ', cust.customer_last_name) AS "Customer Name",
  ch.issue_date AS "Issue Date",
  ch.due_date AS "Due Date",
  ch.actual_return_date AS "Actual Return Date",
  ch.fine AS "Fine"
FROM
  book_copy bc
  INNER JOIN book b ON bc.book_id = b.book_id
  INNER JOIN book_author_relation ba ON b.book_id = ba.book_id
  INNER JOIN author a ON a.author_id = ba.author_id
  INNER JOIN book_category_relation bcat ON b.book_id = bcat.book_id
  INNER JOIN category cat ON bcat.category_id = cat.category_id
  INNER JOIN checkout ch ON bc.unique_book_id = ch.unique_book_id
  INNER JOIN customer cust ON ch.customer_id_card_number = cust.customer_id_card_number
WHERE
  cust.customer_status = 'Active';

/*Retrieves information about books, authors, and their respective categories in ascending order based on the book title where
Book Type- "For Adults",Category - either "Fiction" or "Non-Fiction" , book price> 20.*/

SELECT
  b.book_title AS "Book Title",
  a.name AS "Author Name",
  cat.category_name AS "Category Name"
FROM
  book b
  INNER JOIN book_author_relation ba ON b.book_id = ba.book_id
  INNER JOIN author a ON a.author_id = ba.author_id
  INNER JOIN book_category_relation bcat ON b.book_id = bcat.book_id
  INNER JOIN category cat ON bcat.category_id = cat.category_id
WHERE
  b.book_type_id = 2
  AND cat.category_name IN ('Fiction', 'Non-Fiction')
  AND b.price > 20
ORDER BY
  b.book_title ASC;
  
/*Calculate the total number of books written by each author, the average and maximum fine amount for the checkouts associated with each book*/
SELECT
  a.name AS "Author Name",
  COUNT(DISTINCT b.book_id) AS "Total Books",
  AVG(ch.fine) AS "Average Fine",
  MAX(ch.fine) AS "Max Fine"
FROM
  author a
  INNER JOIN book_author_relation bar ON a.author_id = bar.author_id
  INNER JOIN book b ON bar.book_id = b.book_id
  INNER JOIN book_copy bc ON b.book_id = bc.book_id
  INNER JOIN checkout ch ON bc.unique_book_id = ch.unique_book_id
GROUP BY
  a.name;
  
/*Calculate the total number of books in each category, the average and maximum price of the books in each category*/ 
SELECT
  cat.category_name AS "Category",
  COUNT(DISTINCT b.book_id) AS "Total Books",
  AVG(b.price) AS "Average Price",
  MAX(b.price) AS "Max Price"
FROM
  category cat
  INNER JOIN book_category_relation bcr ON cat.category_id = bcr.category_id
  INNER JOIN book b ON bcr.book_id = b.book_id
  INNER JOIN book_copy bc ON b.book_id = bc.book_id
GROUP BY
  cat.category_name;
  

/*Retrieve information about customers and their checkouts count for each customer in descending order.*/
SELECT
  cust.customer_id_card_number AS "Customer ID",
  CONCAT(cust.customer_first_name, ' ', cust.customer_last_name) AS "Customer Name",
  COUNT(ch.checkout_id) AS "Checkouts Made"
FROM
  customer cust
  LEFT JOIN checkout ch ON cust.customer_id_card_number = ch.customer_id_card_number
GROUP BY
  cust.customer_id_card_number, cust.customer_first_name, cust.customer_last_name
Order By "Checkouts Made" desc