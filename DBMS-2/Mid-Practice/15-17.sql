CREATE OR REPLACE FUNCTION assign_loan_category (p_customer_id IN NUMBER)
RETURN VARCHAR2
AS
   v_total_transaction NUMBER;
   v_loan_category VARCHAR2(3);
BEGIN
   -- Calculate the total transaction for the last 12 months for the customer
   SELECT SUM(amount) INTO v_total_transaction
   FROM transactions
   WHERE customer_id = p_customer_id
   AND transaction_date BETWEEN ADD_MONTHS(SYSDATE, -12) AND SYSDATE;

   -- Assign the loan category based on the total transaction
   IF v_total_transaction >= 2000000 THEN
      v_loan_category := 'S-A';
   ELSIF v_total_transaction >= 1000000 THEN
      v_loan_category := 'S-B';
   ELSIF v_total_transaction >= 500000 THEN
      v_loan_category := 'S-C';
   ELSE
      v_loan_category := 'NA';
   END IF;

   RETURN v_loan_category;
END;


--
CREATE OR REPLACE PROCEDURE schedule_loan (p_cust_id NUMBER)
AS
  l_loan_scheme VARCHAR2(10);
  l_installments NUMBER;
  l_service_charge NUMBER;
  l_amount NUMBER;
  l_start_date DATE;
  l_due_date DATE;
BEGIN
  -- Get the customer's loan scheme
  SELECT loan_scheme, installments, service_charge, amount
  INTO l_loan_scheme, l_installments, l_service_charge, l_amount
  FROM customers
  WHERE id = p_cust_id;

  -- Calculate the start date and due date for each installment
  l_start_date := SYSDATE;
  FOR i IN 1..l_installments LOOP
    l_due_date := l_start_date + INTERVAL '3' MONTH;
    INSERT INTO loan_schedule (cust_id, installment_no, start_date, due_date, amount)
    VALUES (p_cust_id, i, l_start_date, l_due_date, l_amount * (1 + l_service_charge));
    l_start_date := l_due_date;
  END LOOP;
END;
