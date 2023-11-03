--Task-1--
CREATE TABLESPACE TBS1
 DATAFILE 'tbs1_data.dbf' SIZE 1m;
         
CREATE TABLESPACE TBS2
 DATAFILE 'tbs2_data.dbf' SIZE 1m;


--Task-2--
CREATE USER TESTUSER IDENTIFIED BY 123;

ALTER USER TESTUSER
QUOTA 1M ON TBS1;

ALTER USER TESTUSER
QUOTA 1M ON TBS2;

GRANT QUOTA ON TBS1 TO TESTUSER;
GRANT QUOTA ON TBS2 TO TESTUSER;


--Task-3--

CREATE TABLE DEPARTMENT(
    ID NUMBER PRIMARY KEY,
    DEPT_NAME VARCHAR(32)
) TABLESPACE TBS1;

CREATE TABLE STUDENT(
    ID NUMBER PRIMARY KEY,
    STUDENT_NAME VARCHAR2(32),
    DEPT NUMBER,
    CONSTRAINT FK_DEPARTMENT FOREIGN KEY(DEPT) REFERENCES DEPARTMENT(ID)
) TABLESPACE TBS1;

--Task-4--

CREATE TABLE COURSE(
    CODE INT PRIMARY KEY,
    NAME VARCHAR(50),
    CREDIT INT,
    OFFERED_BY INT,
    CONSTRAINT FK_DEPT FOREIGN KEY(OFFERED_BY) REFERENCES DEPARTMENT(ID)
) TABLESPACE TBS2;


--Task-5--

BEGIN
  INSERT INTO department (id, dept_name) VALUES (0, 'CIVIL');
  INSERT INTO department (id, dept_name) VALUES (1, 'Computer Science');
  INSERT INTO department (id, dept_name) VALUES (2, 'Mechanical Engineering');
  INSERT INTO department (id, dept_name) VALUES (3, 'Electrical Engineering');
  INSERT INTO department (id, dept_name) VALUES (4, 'Biology');
  INSERT INTO department (id, dept_name) VALUES (5, 'Chemistry');
END;
/

DECLARE
  i NUMBER := 0;
BEGIN
  FOR i IN 1..2000 LOOP
    INSERT INTO student (id, student_name, dept)
    VALUES (i, 'student' || i, MOD(i,6));
  END LOOP;
END;
/

DECLARE
  i NUMBER := 1;
BEGIN
  FOR i IN 1..2000 LOOP
    INSERT INTO course (code, name, credit, offered_by)
    VALUES (i, 'course' || i, 4, MOD(i,6));
  END LOOP;
END;
/

--Task-6--

SELECT tablespace_name , bytes /1024/1024 MB
FROM dba_free_space
WHERE tablespace_name ='TBS1';

SELECT tablespace_name , bytes /1024/1024 MB
FROM dba_free_space
WHERE tablespace_name ='TBS2';


--Task-7--

ALTER TABLESPACE TBS1
ADD DATAFILE 'tbs1_extra1.dbf' SIZE 5M;

--Task-8--

ALTER DATABASE
DATAFILE 'tbs2_data.dbf' RESIZE 10m;


--Task-9--
SELECT tablespace_name , bytes /1024/1024 MB
FROM dba_data_files
WHERE tablespace_name ='TBS1';

SELECT tablespace_name , bytes /1024/1024 MB
FROM dba_data_files
WHERE tablespace_name ='TBS2';

--Task-10--

DROP TABLESPACE tbs1 INCLUDING CONTENTS AND DATAFILES;

--Task-11--

DROP TABLESPACE tbs2 INCLUDING CONTENTS;