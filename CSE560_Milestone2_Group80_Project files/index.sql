/* Query Optimization 1 using B-tree indexing: */
create index index_customer_id on customer(customer_id_card_number);
explain analyze select * from customer where customer_status = 'Active' and customer_age>50;

/* Query Optimization 2 using hash indexing */
create index ind1 on book USING hash(book_id);
create index ind2 on category USING hash(category_name);

explain analyze
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