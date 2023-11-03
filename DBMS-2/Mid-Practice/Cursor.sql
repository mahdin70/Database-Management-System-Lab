DECLARE
 V_NAME VARCHAR2(20);

 CURSOR CUR_EMP IS
 SELECT FIRST_NAME FROM EMPLOYEES
 WHERE EMPLOYEE_ID < 105;

BEGIN
 OPEN CUR_EMP;
 LOOP
  FETCH CUR_EMP INTO V_NAME;
   DBMS_OUTPUT.PUT_LINE(V_NAME);
   EXIT WHEN CUR_EMP%NOTFOUND;
  END LOOP;
  CLOSE CUR_EMP;
END;
/
 

--PARAMETERIZED CURSOR
DECLARE
  V_NAME VARCHAR2(30);
  CURSOR CUR_EMP(V_PARAM_EID VARCHAR2) IS --HERE IS THE PARAMETER
  SELECT FIRST_NAME FROM EMPLOYEE
  WHERE EMPLOYEE_ID < V_PARAM_EID;
BEGIN
  OPEN CUR_EMP(105);
  LOOP
   FETCH CUR_EMP INTO V_NAME
   DBMS_OUTPUT.PUT_LINE(V_NAME);
   EXIT WHEN CUR_EMP%NOTFOUND;
  END LOOP;
  CLOSE CUR_EMP;
END;
/


--CURSOR FOR LOOP

DECLARE 
  CURSOR SHEI_CURSOR IS
  SELECT FIRST_NAME, LAST_NAME FROM SHEI_TABLE
  WHERE SHEI_ID > 200;
BEGIN
  FOR SHEI_INDEX IN SHEI_CURSOR
  LOOP
    DBMS_OUTPUT.PUT_LINE(SHEI_INDEX.FIRST_NAME||' '||SHEI_INDEX.LAST_NAME);
  END LOOP;
END;
/
