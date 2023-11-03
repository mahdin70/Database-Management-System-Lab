CREATE OR REPLACE PROCEDURE calculate_movie_time (mov_title IN VARCHAR2)
AS
    mov_length NUMBER;
BEGIN
    SELECT mov_time INTO mov_length FROM movie WHERE mov_title = mov_title;
    intermissions NUMBER := CEIL(mov_length / 70);
    remainder NUMBER := MOD(mov_length, 70);
    
    IF (intermissions > 0 AND remainder > 30 ) THEN
         total_time NUMBER := mov_length + (intermissions * 15);
         hours NUMBER := TRUNC(total_time / 60);
         minutes NUMBER := MOD(total_time, 60);

         DBMS_OUTPUT.PUT_LINE('Movie: ' || mov_title);
         DBMS_OUTPUT.PUT_LINE('Total Runtime: ' || hours || ' hours ' || minutes || ' minutes');
    END IF;

    ELSE 
        total_time NUMBER := mov_length;
        hours NUMBER := TRUNC(total_time / 60);
        minutes NUMBER := MOD(total_time, 60);

        DBMS_OUTPUT.PUT_LINE('Movie: ' || mov_title);
        DBMS_OUTPUT.PUT_LINE('Total Runtime: ' || hours || ' hours ' || minutes || ' minutes');
    END IF;
END;
/