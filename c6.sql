--- PL/SQL

DECLARE
	-- Jak puste, to nie dajemy declare
BEGIN
	-- Nie za działa
END;
/


BEGIN
	NULL;
END;
/


DBMS_OUTPUT.PUT_LINE('KILOF');

-- Parsowanie napisów
||

-- Włączenie wypisywania na konsolę
SET SERVEROUTPUT ON -- polecenie sqlplusa


-- Deklaracje zmiennych
DECLARE
	x NUMBER(7) := 5;
BEGIN
	x := 81;
	DBMS_OUTPUT.PUT_LINE(x);
END;
/

-- Typy
DECLARE
	y OSOBA.IMIE % TYPE;
	z OSOBA % ROWTYPE;
BEGIN
	NULL;
END;
/


-- To samo
Kilof, KILOF, kilof

-- Różne
"Kilof", "KILOF", "kilof"


-- jeśli 1 wiersz, to zapisane do zmiennych
-- jeśli więcej, to wyjątek
-- jeśli 0, to wyjątek
SELECT x, y, z
	INTO a, b, c
	FROM ...

SELECT *
	INTO z
	FROM ...

DECLARE
	TYPE name_rec
		IS RECORD(first_name VARCHAR(17),
				  last_name VARCHAR(18));
	var_x name_rec;


IF THEN ... 
ELSE  ... 
END IF;

IF ... THEN ... 
ELSIF ... THEN ... 
ELSIF ... THEN ... 
ELSIF ... THEN ... 
END IF;

LOOP
	EXIT WHEN ... ;
END LOOP;

WHILE ... LOOP
	...
END LOOP;

-- Nie trzeba deklarować x
FOR x in 0..17 LOOP
	...
END LOOP;

-- Kursor (tu go nie widać)
-- Nie trzeba deklarować r
FOR r IN (SELECT ... ) LOOP
	...
END LOOP;

-- Widoczne kursory
DECLARE
	CURSOR x SELECT * FROM osoba;
BEGIN
	OPEN x;
	LOOP
		FETCH x INTO y; -- Jak się nie uda to nie ma wyjątku, tylko NOTFOUND, a y ma starą
		EXIT WHEN x % NOTFOUND;
		...
	END LOOP;
	CLOSE x;
END;
/

-- Atrybuty kursorów
% ISOPER -- sprawdzenie, czy jest otwarty
% FOUND -- czy aktualnie w kursorze coś widać
% NOTFOUND -- to samo, ale na odwrót
% ROWCOUNT -- liczenie

-- Programy składowane
-- CREATE tworzy
-- REPLACE podmienia
-- DROP
-- CREATE OR REPLACE - bezpieczne
CREATE OR REPLACE PROCEDURE -- Tak, jak void w C
				  FUNCTION	-- Obowiązek napisania RETURN 
	nazwa(y INTEGER, x INOUT VARCHAR(18)) -- Niezadeklarowany jest IN; jest jeszcze OUT i INOUT
		RETURN OSOBA.DATA_URODZENIA % TYPE
IS
	DECLARE -- Nieobowiązkowe
		...
	BEGIN
		...
		RETURN ... -- w funkcj coś, a w procedurze nic
	END;
/
--- Będzie skompilowane zawsze! Nawet jak są błędy, ale będzie informacja o błędzie wykonania.
-- Obsługa błędów kompilacji
SHOW ERRORS PROCEDURE nazwa;
SHOW ERRORS FUNCTION nazwa;

-- Pakiety
-- Zrobić pakiet z funkcjami do bazy danych 
CREATE OR REPLACE PACKAGE zaliczenie AS
	...
END zaliczenie;
/

CREATE PACKAGE zaliczenie AS
	FUNCTION x (y INTEGER) RETURN VARCHAR(7);
	PROCEDURE o (y INOUT VARCHAR(7));
	...
END zaliczenie;
/

CREATE PACKAGE BODY zaliczenie AS
	FUNCTION x (y INTEGER) RETURN VARCHAR(7) 
	IS BEGIN
		RETURN y||"moj";
	END;
END zaliczenie;
/

-- Wyjątki - są rozumiane tyko w PLSQL. Na zewnąrz wychodzi kod numeryczny
-- Deklaracja
EXCEPTION nazwa;
-- Rzucanie
RAISE nazwa;
-- Łapanie


DECLARE
	...
BEGIN
	...
EXCEPTION
	WHEN ... THEN ...
	WHEN ... THEN ...
	WHEN OTHERS THEN ...
END;

-- BEGIN, END można umieć w dowolnym miejscu

-- Wysyłanie wyjątku na stronę urzytkownika (jemne kody! -20000 to kody użytkownika)
RAISE_APPLICATION_ERROR
	-20017




CREATE OR REPLACE FUNCTION 
	aaa(y INTEGER) 
		RETURN INTEGER
IS
	BEGIN
		RETURN y;
	END;
/


CREATE OR REPLACE FUNCTION 
	bbb(y INTEGER) 
		RETURN INTEGER
IS
	BEGIN
		RETURN aaa(y);
	END;
/

BEGIN
	DBMS_OUTPUT.PUT_LINE(bbb(1));
END;
/

CREATE OR REPLACE FUNCTION 
	aaa(y INTEGER) 
		RETURN INTEGER
IS
	BEGIN
		RETURN y + 1;
	END;
/

BEGIN
	DBMS_OUTPUT.PUT_LINE(bbb(1));
END;
/

BEGIN
	CREATE OR REPLACE FUNCTION 
		aaaa(y INTEGER) 
			RETURN INTEGER
	IS
		BEGIN
			RETURN bbbb(y);
		END;
	

	CREATE OR REPLACE FUNCTION 
		bbbb(y INTEGER) 
			RETURN INTEGER
	IS
		BEGIN
			RETURN aaaa(y);
		END;
	
END;
/