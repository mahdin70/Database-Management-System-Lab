CREATE OR REPLACE FUNCTION calculate_yearly_earning (mov_title IN VARCHAR2)
RETURN NUMBER
AS
    mov_releasedate DATE;
    mov_id NUMBER;
    rev_stars NUMBER;
    total_earning NUMBER;
    total_year NUMBER;

BEGIN
    SELECT mov_releasedate, mov_id INTO mov_releasedate, mov_id FROM movie WHERE mov_title = mov_title;
    STARS NUMBER := COUNT(SELECT * FROM rating WHERE mov_id = mov_id AND rev_stars >= 6);
    total_earning := STARS * 10;
    total_year := TRUNC(SYSDATE - mov_releasedate);
    RETURN total_earning / total_year;
END;
