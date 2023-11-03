CREATE OR REPLACE FUNCTION disburse_merit_scholarship(
    p_total_amount IN NUMBER, 
    p_per_student_amount IN NUMBER
)
RETURN VARCHAR2
IS
    v_student_count NUMBER := 0;
    v_selected_count NUMBER := 0;
    v_remaining_amount NUMBER := p_total_amount;
BEGIN
    FOR student IN (SELECT id, cgpa FROM students WHERE program = 'Software Engineering' AND year = 2 AND cgpa >= 3.5
                    MINUS
                    SELECT m.student_id, s.cgpa FROM misconducts m JOIN students s ON m.student_id = s.id)
    LOOP
        v_selected_count := v_selected_count + 1;
       
        IF v_remaining_amount >= p_per_student_amount THEN
            v_student_count := v_student_count + 1;
            
            -- Recording the scholarship transaction
            INSERT INTO student_transactions (student_id, date_time, amount_paid)
            VALUES (student.id, SYSDATE, p_per_student_amount);
            
            v_remaining_amount := v_remaining_amount - p_per_student_amount;
        END IF;
    END LOOP;

    RETURN 'Number of students who received MS: ' || v_student_count || ', Number of students who were initially selected but did not receive MS: ' || (v_selected_count - v_student_count);
END;
