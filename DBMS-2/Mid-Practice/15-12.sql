CREATE OR REPLACE PROCEDURE update_customer_balance (p_cid IN NUMBER)
AS
  l_accno NUMBER;
  l_interest NUMBER;
  l_gracep NUMBER;
  l_lastdtigiven DATE;2
  l_today DATE := SYSDATE;
  l_months_diff NUMBER;
BEGIN
  -- Get the customer's account information
  SELECT accno, acc_type, lastdtigiven
  INTO l_accno, l_gracep, l_lastdtigiven
  FROM accounts
  WHERE cid = p_cid;

  -- Get the interest rate and grace period based on the account type
  SELECT irate, gracep
  INTO l_interest, l_gracep
  FROM acc_type
  WHERE id = l_gracep;

  -- Calculate the number of months between today and the last date of interest given
  l_months_diff := NUMTODSINTERVAL(l_today - l_lastdtigiven, 'MONTH');

  -- Update the customer's current balance if today is between 1 and 3 months or between 3 and 6 months
  -- compared to the last date of interest given
  IF (l_months_diff >= 1 AND l_months_diff <= 3) OR (l_months_diff > 3 AND l_months_diff <= 6) THEN
    UPDATE accounts
    SET current_balance = current_balance + (current_balance * l_interest * l_months_diff / 12)
    WHERE accno = l_accno;

    -- Record the transaction
    INSERT INTO transactions (dt, accno, tp, amount)
    VALUES (l_today, l_accno, 'Interest', (current_balance * l_interest * l_months_diff / 12));
  END IF;
END;
