CREATE SEQUENCE ACCOUNT_ID_SEQ START WITH 100001 INCREMENT BY 1;
CREATE OR REPLACE FUNCTION generate_account_id (p_name IN VARCHAR2, p_acccode IN INT, p_openningdate IN DATE)
RETURN VARCHAR2
AS
  v_serialno INT;
  v_firstthreeletters VARCHAR2(3);
  v_accountid VARCHAR2(20);
BEGIN
  SELECT SEQ_ACCOUNT_ID.NEXTVAL INTO v_serialno FROM DUAL;
  v_firstthreeletters := SUBSTR(p_name, 1, 3);
  v_accountid := LPAD(p_acccode, 4, '0') || TO_CHAR(p_openningdate, 'YYYYMMDD') || '.' || v_firstthreeletters || '.' || v_serialno;
  RETURN v_accountid;
END;
/
