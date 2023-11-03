--Write a function, that given a genre (gen_id) will return genre status, 
--additionally the reviewcount and average rating of that genre

GENRE TABLE:
GEN_ID NUMBER;
GEN_TITLE VARCHAR2(50);

MTYPE TABLE:
MOV_ID NUMBER;
GEN_ID NUMBER;

RATING TABLE: 
REV_ID NUMBER;
MOV_ID NUMBER;
REV_STARS NUMBER;


CREATE OR REPLACE FUNCTION genre_status (gen_id IN NUMBER)
RETURN VARCHAR2
AS
    genre VARCHAR2(50);
    reviewcount NUMBER;
    avg_rating NUMBER;
BEGIN
    SELECT gen_title INTO genre FROM genre WHERE gen_id = gen_id;
    SELECT COUNT(*) INTO reviewcount FROM rating JOIN mtype ON rating.mov_id = mtype.mov_id WHERE mtype.gen_id = gen_id;
    SELECT AVG(rev_stars) INTO avg_rating FROM rating JOIN mtype ON rating.mov_id = mtype.mov_id WHERE mtype.gen_id = gen_id;
    RETURN 'Genre: ' || genre || ' Review Count: ' || reviewcount || ' Average Rating: ' || avg_rating;
END;
/