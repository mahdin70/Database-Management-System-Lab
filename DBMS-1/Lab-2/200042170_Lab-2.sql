
conn SYSTEM/7445;

create user mukit_200042170 identified by mahdin70;

GRANT ALL PRIVILEGES TO mukit_200042170;

connect mukit_200042170/mahdin70;

create table INSTRUCTOR(
  2  ID number not null,
  3  NAME varchar2(20),
  4  DEPT_NAME varchar2(20),
  5  salary number
  6  );

INSERT INTO INSTRUCTOR VALUES(10101,'Srinivasan','Comp. Sci.',65000);
INSERT INTO INSTRUCTOR VALUES(12121,'Wu','Finance',90000);
INSERT INTO INSTRUCTOR VALUES(15151,'Mozart','Comp. Sci.',40000);
INSERT INTO INSTRUCTOR VALUES(22222,'Einstein','Physics',95000);
INSERT INTO INSTRUCTOR VALUES(32343,'El Said','History',60000);
INSERT INTO INSTRUCTOR VALUES(33456,'Gold','Physics',87);
INSERT INTO INSTRUCTOR VALUES(45565,'Katz','Comp. Sci',75000);
INSERT INTO INSTRUCTOR VALUES(58583,'Califieri','History',62000);
INSERT INTO INSTRUCTOR VALUES(76543,'Singh','Finance',80000);
INSERT INTO INSTRUCTOR VALUES(76766,'Crick','Biology',72000);
INSERT INTO INSTRUCTOR VALUES(83821,'Brandt','Comp. Sci',92000);
INSERT INTO INSTRUCTOR VALUES(98345,'Kim','Elec. Eng.',80000);

select * from INSTRUCTOR;

select ID,Name from INSTRUCTOR;

select * from INSTRUCTOR
 where salary>70000;

select Name,DEPT_NAME from INSTRUCTOR
 where salary BETWEEN 80000 and 100000;

select ID,Name from INSTRUCTOR 
 where DEPT_Name ='Comp. Sci.';

select Name,salary from INSTRCTOR
 where DEPT_NAME='Finance';

select ID,Name from INSTRUCTOR 
 where DEPT_NAME='Comp. Sci.' AND salary>75000;

select DISTINCT DEPT_NAME from INSTRUCTOR;