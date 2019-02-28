start <nazwa pliku>	-- ładowanie komend z pliku
@  <nazwa pliku>	-- ładowanie komend z pliku


SELECT COUNT(*), SUM(wielkosc), AVG(wielkosc), MIN(wielkosc), MAX(wielkosc) 
	FROM lasy;


	-- grupowanie:
SELECT rodzaj, COUNT(*), SUM(wieSELECT 
	d.kto
FROM 
	(SELECT g1.nr AS kto
		FROM gatunki g1, pozeranie p 
			WHERE g1.nr = p.kto 
			AND EXISTS (
				SELECT *
				FROM lasy l, wystapienia wy
				WHERE l.nr = wy.nr_lasu
				AND wy.nr_gatunku = g1.nr
				AND NOT EXISTS (
					SELECT * 
					FROM pozeranie po, wystapienia wy2
					WHERE l.nr = wy2.nr_lasu
					AND po.kogo = wy2.nr_gatunku
					AND po.kto = g1.nr
				)
			)
	) d
GROUP BY d.kto;lkosc), AVG(wielkosc), MIN(wielkosc), MAX(wielkosc) 
	FROM lasy GROUP BY rodzaj;

GROPU BY <po czym grupować>	-- grupuje po;
GROPU BY cos, cos2, cos3;

SELECT karma, nr_lasu, COUNT(*) 
	FROM pasniki GROUP BY karma, nr_lasu;


	-- złączenia (tworzy iloczyn kartezjański i po nim przechodzi):
SELECT karma, nr_lasu, COUNT(*) 
	FROM pasniki, lasy 
	GROUP BY karma, nr_lasu;

SELECT karma, nr_lasu, COUNT(*), SUM(wielkosc) 
	FROM pasniki, lasy 
	GROUP BY karma, nr_lasu;	-- błąd, nie wiadomo skąd wielkosc

SELECT karma, nr_lasu, COUNT(*), SUM(pasniki.wielkosc) 
	FROM pasniki, lasy 
	GROUP BY karma, nr_lasu;	-- brak błędu

SELECT karma, nr_lasu, SUM(pasniki.wielkosc) AS ich_wielkosc 
	FROM pasniki, lasy 
	GROUP BY karma, nr_lasu;	-- brak błędu

AS <alias>	-- nowa nazwa

SELECT p.karma, p.nr_lasu, SUM(l.wielkosc) AS ich_wielkosc 
	FROM pasniki as p, lasy as l 
	GROUP BY p.karma, p.nr_lasu;

SELECT p.karma, p.nr_lasu, SUM(p.wielkosc) AS ich_wielkosc 
	FROM pasniki p, lasy l GROUP BY p.karma, p.nr_lasu;

SELECT p.karma, p.nr_lasu, SUM(p.wielkosc) AS ich_wielkosc 
	FROM pasniki p, lasy l WHERE p.nr_lasu = l.nr 
	GROUP BY p.karma, p.nr_lasu;	-- tylko tam, gdzie p.nr_lasu = l.nr

SELECT p.karma, l.nazwa, SUM(p.wielkosc) AS ich_wielkosc 
	FROM pasniki p, lasy l 
	WHERE p.nr_lasu = l.nr 
	GROUP BY p.karma, p.nr_lasu, l.nazwa;	-- nie możemy wybrać atrybutu, którego nie ma w GROUP BY <tu>

SELECT p.karma, l.nazwa, SUM(p.wielkosc) AS ich_wielkosc 
	FROM pasniki p, lasy l 
	WHERE p.nr_lasu = l.nr 
	GROUP BY p.karma, p.nr_lasu, l.nazwa;

	-- nazwa_lasu, nazwa_gatunu, liczba garunku

SELECT l.nazwa, g.nazwa, SUM(w.ilosc) 
	FROM lasy l, gatunki g, wystapienia w 
	WHERE l.nr = w.nr_lasu 
		AND w.nr_gatunku = g.nr
	GROUP BY l.nazwa, g.nazwa;

SELECT l.nazwa, g.nazwa, w.ilosc
	FROM lasy l, gatunki g, wystapienia w 
	WHERE l.nr = w.nr_lasu 
		AND w.nr_gatunku = g.nr;

SELECT g1.nazwa AS pozerajacy, g2.nazwa as pozerany
	FROM gatunki g1, gatunki g2, pozeranie p 
	WHERE g1.nr = p.kto 
		AND g2.nr = p.kogo;


	-- agregacja:
SUM()
COUNT()
MIN()
MAX()
AVG()