
--Gets a payment

CREATE FUNCTION getpayment(p_pay_id numeric) RETURNS refcursor AS
$$
DECLARE
 v_cursor_pay refcursor;
BEGIN
 OPEN v_cursor_pay FOR SELECT pay_id,pay_amount FROM payments
 WHERE pay_id = p_pay_id;
 return v_cursor_pay;
END $$
LANGUAGE plpgsql;
