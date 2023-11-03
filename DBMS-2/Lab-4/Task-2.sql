CREATE OR REPLACE FUNCTION CALCULATE_PROFIT(ACCNO INT)
RETURN NUMERIC
IS
  BALANCE NUMERIC(10,2);
  PROFIT NUMERIC(10,2);
  PROFIT_RATE NUMERIC(10,2);
  PRINCIPAL NUMERIC(10,2);
  OPENING_DATE DATE;
  DURATION INT;

BEGIN
  SELECT SUM(AMOUNT), PROFITRATE, OPENINGDATE
  INTO BALANCE,PROFIT_RATE,OPENING_DATE
  FROM TRANSACTION
  JOIN ACCOUNT ON ACCOUNT.ID = TRANSACTION.ACCNO
  JOIN ACCOUNTPROPERTY ON ACCOUNTPROPERTY.ID = ACCOUNT.ACCCODE
  WHERE ACCNO = ACCNO;

  DURATION := ROUND((SYSDATE - OPENING_DATE));
  PROFIT := BALANCE*PROFIT_RATE*DURATION/365;
  PRINCIPAL := BALANCE - PROFIT;

  RETURN PROFIT,PRINCIPAL,BALANCE;
END;
/