
-- Gets an invoice

CREATE FUNCTION getinvoice(p_inv_id numeric) RETURNS refcursor AS 
$$
DECLARE 
 v_cursor_inv refcursor;
BEGIN
 OPEN v_cursor_inv FOR SELECT invoice_id,invoice_total FROM invoices 
 WHERE invoice_id = p_inv_id;
 return v_cursor_inv;
END $$
LANGUAGE plpgsql;
