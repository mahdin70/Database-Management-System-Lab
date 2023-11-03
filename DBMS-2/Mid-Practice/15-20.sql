CREATE OR REPLACE FUNCTION get_current_balance(p_acc_no NUMBER)
RETURN NUMBER
IS
  l_current_balance NUMBER := 0;
BEGIN
  SELECT SUM(CASE WHEN transctionType = 'deposit' THEN amount ELSE -amount END)
  INTO l_current_balance
  FROM transactions
  WHERE accNo = p_acc_no;

  RETURN l_current_balance;
END;



--
CREATE OR REPLACE PROCEDURE CALCULATE_PROFIT AS
  CURSOR account_cursor IS
    SELECT ID, AccCode, LastDateInterest
    FROM Accounts;
  account_record account_cursor%ROWTYPE;
  GP NUMBER;
  PR NUMBER;
  duration NUMBER;
  interest NUMBER;
  current_date DATE := SYSDATE;
BEGIN
  OPEN account_cursor;
  LOOP
    FETCH account_cursor INTO account_record;
    EXIT WHEN account_cursor%NOTFOUND;
    
    SELECT GP, profitRate INTO GP, PR
    FROM AccountProperties
    WHERE ID = account_record.AccCode;
    
    duration := NUMTODSINTERVAL(current_date - account_record.LastDateInterest, 'DAY');
    
    IF GP = 1 THEN --daily
      interest := account_record.Balance * PR * duration;
    ELSIF GP = 2 THEN --monthly
      interest := account_record.Balance * PR * (duration/30);
    ELSIF GP = 3 THEN --quarterly
      interest := account_record.Balance * PR * (duration/90);
    ELSIF GP = 4 THEN --biyearly
      interest := account_record.Balance * PR * (duration/180);
    ELSIF GP = 5 THEN --yearly
      interest := account_record.Balance * PR * (duration/365);
    END IF;
    
    INSERT INTO Amounts (AccNo, PrincipalAmount, ProfitAmount, dt)
    VALUES (account_record.ID, account_record.Balance, interest, current_date);
    
  END LOOP;
  CLOSE account_cursor;
END;
