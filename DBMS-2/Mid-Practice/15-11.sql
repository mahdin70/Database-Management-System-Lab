CREATE OR REPLACE FUNCTION evaluate_status(p_citizen_id NUMBER)
RETURN VARCHAR2
AS
  v_average_salary NUMBER;
  v_total_departures NUMBER;
  v_status VARCHAR2(10);
BEGIN
  -- Calculate average salary for last 5 years
  SELECT AVG(Amount) INTO v_average_salary
  FROM Salary
  WHERE CID = p_citizen_id
  AND Dt BETWEEN ADD_MONTHS(SYSDATE, -60) AND SYSDATE;

  -- Calculate total departures in last 5 years
  SELECT COUNT(*) INTO v_total_departures
  FROM AirportsLog
  WHERE PName IS NOT NULL
  AND Dt BETWEEN ADD_MONTHS(SYSDATE, -60) AND SYSDATE;

  -- Evaluate status based on the average salary and total departures
  IF v_average_salary > 100000 AND v_total_departures >= 10 THEN
    v_status := 'CIP';
  ELSIF v_average_salary BETWEEN 50000 AND 100000 AND v_total_departures >= 5 THEN
    v_status := 'VIP';
  ELSE
    v_status := 'ORDINARY';
  END IF;

  RETURN v_status;
END evaluate_status;