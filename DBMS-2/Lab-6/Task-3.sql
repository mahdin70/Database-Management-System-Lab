CREATE OR REPLACE FUNCTION CALL_ID_GENERATOR(p_call_begin DATE)
RETURN VARCHAR2(20)
AS
  v_callBegin date;
  v_callId varchar2(20);


CREATE SEQUENCE callid_seq
  START WITH 100000
  MINVALUE 100001
  MAXVALUE 999999
  INCREMENT BY 1
  NOCACHE;
BEGIN
  v_callID := TO_CHAR(p_call_begin, 'YYYYMMDD') || '.' || callid_seq.NEXTVAL;
  RETURN v_callID;
END;
/

CREATE OR REPLACE TRIGGER callid_trigger
BEFORE INSERT ON Transactions
FOR EACH ROW
BEGIN
  :new.CallID := CALL_ID_GENERATOR(CallBegin);
END;
/
