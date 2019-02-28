	-- Typy danych
NUMBER(x, y)	-- x - liczba znaków ogólnie, y - liczba znaków po przecinku
NUMBER(4, 1)	-- od -9.9 do 99.9
VARCHAR(x)		-- zmienna długość, max x
CHAR(x)			-- stała długość, reszta dopełniana śmieciami
DATE			-- data
INTEGER			-- stała całkowitoliczbowa NUMBER(38)

	-- constrainty:
NOT NULL	-- nie null
CHECK (...)	-- warunek do sprawdzenia
PRIMARY KEY <jakie pola>	-- kluopencz główny
FOREIGN KEY <jakie pola> REFERENCES <jaka tabela>	-- odwołanie się do zewnętrznego klucza obcego
REFERENCES <nazwa tabeli	-- jeśli nie inline, to po FOREIGN KEY, odwołanie się do zewnętrznej tabeli
DEFAULT <wartość>	-- wartość domyślna

	działanie przy usunięciu referencji nadrzędnej
ON DELETE CASCADE	-- Usuwaj wiersze podrzędne po usunięciu nadrzędnego
ON DELETE SET NULL	-- Wstaw NULL-a po usunięciu
ON DELETE SET DEFAULT	-- wstaw domyślną (nie zawsze dostępna)

	operacje na constraintach
CONSTRAINT <nazwa constrainta>	-- do nazwania constraintów
ALTER TABLE <nazwa tabeli> <opcja> <nazwa constrainta>	-- brak sprawdzania więzów integralności
<opcja>	-- DISABLE/ENABLE/DROP/ADD

	-- w SELECT można użyć:
COUNT	- policz (COUNT (*), COUNT (<nazwa kolumny>)	-- tam, gdzie wartość to nie null, COUNT (DISTINCT <kolumna>) - różne wartości)
SUM	-- suma,
AVG	-- średnia
MIN	-- minumum
MAX	-- maximum

	-- polecenia na tabelach:
CREATE TABLE <nazwa> (<pola>)	-- tworzy
ALTER TABLE	<nazwa> <opcje zmiany tabeli>	-- zmienia, dodaje, usuwa, zmienia kolumny więzy integralności
DROP TABLE <nazwa>	-- niszczy
		-- <opcje zmiany tabeli>:
	ADD <>
	DROP <>
	ALTER/MODIFY
	DROP COLUMN

||	-- sklejanie znaków

	-- na końcu zapytania:
ORDER BY (<nazwy kolumn>)	-- rosnąca ASCENDING
ORDER BY (<nazwy kolumn>) ASCENDING	-- rosnąca
ORDER BY (<nazwy kolumn>) DESCENDING	-- malejąca
ORDER BY (<nazwy kolumn>) ASC	-- rosnąca
ORDER BY (<nazwy kolumn>) DESC	-- malejąca

	-- wstawienie tabeli:
INSERT INTO <tabela> (<nazwy pól) VALUES (<wartości pól>);	-- dodanie do tabeli

	-- przykładowe polecenia:
SELECT * FROM lasy WHERE wielkosc >= (SELECT MAX(wielkosc) FROM lasy);
SELECT * FROM lasy WHERE wielkosc >= ALL (SELECT wielkosc FROM lasy);
SELECT * FROM lasy WHERE wielkosc >= ANY (SELECT wielkosc FROM lasy);