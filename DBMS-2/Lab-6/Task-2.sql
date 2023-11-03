CREATE OR REPLACE FUNCTION calculate_charge(p_sim_no IN NUMBER, p_call_begin IN DATE, p_call_end IN DATE)
RETURN NUMBER
IS
  v_plan_charge_per_min NUMBER;
  v_duration_in_sec NUMBER;
  v_duration_in_min NUMBER;
  v_duration_rounded_min NUMBER;
  v_charge NUMBER;
BEGIN
  SELECT charge_per_min
  INTO v_plan_charge_per_min
  FROM plans
  WHERE sim_no = p_sim_no;
  
  v_duration_in_sec := EXTRACT(SECOND FROM p_call_end - p_call_begin) + 60 * EXTRACT(MINUTE FROM p_call_end - p_call_begin);
  v_duration_in_min := v_duration_in_sec / 60;
  v_duration_rounded_min := CEIL(v_duration_in_min);
  v_charge := v_plan_charge_per_min * v_duration_rounded_min;

  RETURN v_charge;
END;
