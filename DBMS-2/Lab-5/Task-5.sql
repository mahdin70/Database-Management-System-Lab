CREATE OR REPLACE TRIGGER update_balance_principal_amount
AFTER INSERT ON TRANSACTION
FOR EACH ROW
BEGIN
  UPDATE BALANCE SET PRINCIPALAMOUNT = PRINCIPALAMOUNT + :new.AMOUNT
  WHERE ACCNO = :new.ACCNO;
END;
/