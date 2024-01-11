/* Drop Trigger*/
DROP TRIGGER after_checkout_insert ON checkout;

/* Drop Fucntion*/
DROP FUNCTION calculate_fine();


/* Function which calculates the fine for each entry in the checkout table*/
CREATE OR REPLACE FUNCTION calculate_fine()
    RETURNS TRIGGER AS
$$
BEGIN
    UPDATE checkout 
    SET 
        fine = (NEW.actual_return_date - NEW.due_date) * 0.05 * (
            SELECT b.price FROM book AS b, book_copy as c 
			where b.book_id=c.book_id 
			and c.unique_book_id in 
			(select unique_book_id from checkout) LIMIT 1)
	WHERE actual_return_date>due_date and NEW.checkout_id = checkout_id;
    
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER after_checkout_insert
AFTER INSERT ON checkout
FOR EACH ROW
EXECUTE FUNCTION calculate_fine();