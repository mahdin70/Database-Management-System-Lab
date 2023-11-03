CREATE OR REPLACE PROCEDURE calculate_profit AS
    CURSOR account_cursor IS
        SELECT a.ID, a.OPENINGDATE, p.PROFITRATE, p.GRACEPERIOD
        FROM ACCOUNT a
        JOIN ACCOUNTPROPERTY p
        ON a.ACCCODE = p.ID;

    v_accno ACCOUNT.ID%TYPE;
    v_openingdate ACCOUNT.OPENINGDATE%TYPE;
    v_profitrate ACCOUNTPROPERTY.PROFITRATE%TYPE;
    v_graceperiod ACCOUNTPROPERTY.GRACEPERIOD%TYPE;
    v_duration NUMBER;
    v_profit NUMERIC(10,2);
    v_principal NUMERIC(10,2);
    v_balance NUMERIC(10,2);

BEGIN
    FOR account_rec IN account_cursor
    LOOP
        v_accno := account_rec.ID;
        v_openingdate := account_rec.OPENINGDATE;
        v_profitrate := account_rec.PROFITRATE;
        v_graceperiod := account_rec.GRACEPERIOD;
        v_duration := MONTHS_BETWEEN(SYSDATE, v_openingdate);

        IF v_duration >= v_graceperiod THEN
            v_profit := (SELECT SUM(AMOUNT) FROM TRANSACTION WHERE ACCNO = v_accno) * (v_profitrate/100) * (v_duration/12);
            v_principal := (SELECT PRINCIPALAMOUNT FROM BALANCE WHERE ACCNO = v_accno);
            v_balance := v_principal + v_profit;

            INSERT INTO AMOUNTS (ACCNO, PRINCIPALAMOUNT, PROFITAMOUNT, BALANCE)
            VALUES (v_accno, v_principal, v_profit, v_balance);
        END IF;
    END LOOP;
END;
/