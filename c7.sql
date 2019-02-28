--- PL/SQL


-- Wyzwalacze
---- Uwzględnić w projekcie

CREATE TABLE rodo (data DATE DEFAULT SYSDATE, id_osoby INTEGER, user_upd varchar(100));

CREATE OR REPLACE TRIGGER onupd_osoba
AFTER UPDATE OR DELETE ON osoba 
FOR EACH ROW
BEGIN
	INSERT INTO rodo(id_osoby, user_upd) values (:old.id, user);
END;
/

SHOW ERRORS TRIGGER onupd_osoba;


AFTER -- dostęp do new i old
-- Bez AFTER -- nie ma new

SELECT user FROM osoba WHERE id < 10;

UPDATE osoba SET imie = 'Wielki' WHERE id < 10;

SELECT * FROM rodo;


CREATE OR REPLACE TRIGGER insert_osoba_dummy
AFTER INSERT OR UPDATE ON osoba
BEGIN
	raise_application_error(-20999, 'Dziś mam zły dzień');
END;
/

SHOW ERRORS TRIGGER insert_osoba_dummy;

INSERT INTO osoba VALUES(1234234, 'a', 'b', SYSDATE, NULL, NULL);


-- Ostatni etap:
	-- Plan wykonania zapytania + poprawić

-- obejżyj zapytanie - opisz
-- uruchom analizę
-- jeszcze raz zapytanie
