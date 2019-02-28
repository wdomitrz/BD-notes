-- sqlplus

desc user_tables
all_tables
dba_tables
user_constraints


SELECT table_name FROM user_tables;

select * from emp
where
sal > 5000;

SELECT COUNT(*) from EMP;

	DEPT
ROWID

select CONSTRAINT_NAME, CONSTRAINT_TYPE from user_constraints where table_name = 'EMP';


INSER INTO emp
VALUES(...)


INSER INTO emp (sal, ENAME)
VALUES(...);

insert into emp (sal, ename, empno, mgr)
  2  values(-2, NULL, 421, 123);

-- '', a nie ""

COMMIT;
ROLLBACK;

DELETE FROM ...
WHERE ...;