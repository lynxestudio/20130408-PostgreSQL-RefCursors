--Joins the payment with invoice and update the balance

CREATE OR REPLACE FUNCTION setpaymentdoc(p_inv_id numeric,p_pay_id numeric) 
RETURNS int AS
$$
DECLARE
 resp int;
 v_payment refcursor;
 v_invoice refcursor;
 v_invoice_id int;
 v_invoice_total numeric(9,2);
 v_pay_id int;
 v_pay_amount numeric(9,2);
 v_balance numeric(11,2);
 
BEGIN
 v_invoice := getinvoice(p_inv_id);
 FETCH v_invoice INTO v_invoice_id,v_invoice_total;
 CLOSE v_invoice;
 raise NOTICE 'inv id: %', v_invoice_id;
 
 v_payment := getpayment(p_pay_id);
 FETCH v_payment INTO v_pay_id,v_pay_amount;
 CLOSE v_payment;
 raise NOTICE 'pay id: %',v_pay_id;
 
 v_balance := v_invoice_total - v_pay_amount;
 raise NOTICE 'balance : %',v_balance;
 INSERT INTO payments_docs(pay_id,inv_id,balance,date_created)
 VALUES(v_pay_id,v_invoice_id,v_balance,now());
 resp := currval('payments_docs_payments_docs_id_seq');
 return resp;
END; $$
LANGUAGE plpgsql;