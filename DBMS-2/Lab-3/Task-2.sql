CREATE OR REPLACE PROCEDURE top_n_movies (n IN NUMBER)
AS
    CURSOR top_movies IS
        SELECT movie.mov_title, AVG(rating.rev_stars) as avg_stars
        FROM movie
        JOIN rating ON movie.mov_id = rating.mov_id
        GROUP BY movie.mov_title
        ORDER BY avg_stars DESC;

    top_movie top_movies%ROWTYPE;
    counter NUMBER := 0;
BEGIN
    OPEN top_movies;
    LOOP
        FETCH top_movies INTO top_movie;
        EXIT WHEN top_movies%NOTFOUND OR counter = n;
        DBMS_OUTPUT.PUT_LINE(top_movie.mov_title);
        counter := counter + 1;
    END LOOP;

    CLOSE top_movies;

    IF counter = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Error: There are not enough movies in the database.');
    END IF;
END;
/
