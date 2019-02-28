
-- S
	SELECT -- to podzapytanie musi zwrócić dokładnie jednen wiersz i jedną kolumnę
SELECT 
	(SELECT nazwa FROM lasy WHERE nr = pasniki.nr_lasu)
	FROM pasniki;

-- R
		FROM (DOWLONE) alias

-- R, S, W, K
		WHERE 
SELECT 
	* 
	FROM lasy 
		WHERE 
			wielkosc 
			>= ALL (SELECT wielkosc FROM lasy);

-- nic
		GROUP BY

-- R, S, W, K
		HAVING COUNT(*) > 5

-- nic
		ORDER BYIN

-- R - dowolne relacje
-- S - pojedyncze wartości
-- W - wiersz
-- K - kolumna
IN
(w1, w2, w3) IN (SELECT v1, v2, v3 FROM asd)

IN --to 
	= ANYSELECT 
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
GROUP BY d.kto;

> ANY (wektory się porównuje leksykograficznie)

EXIST (SELECT ...)

0 < (SELECT COUNT(*) FROM ...))

SELECT 
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
GROUP BY d.kto;


INSERT INTO gatunki VALUES (12, 'pozeracz 1', 1, 'a', 'b', 1); 
INSERT INTO gatunki VALUES (13, 'nie pozeracz 1', 1, 'a', 'b', 1); 

INSERT INTO lasy VALUES (123, 'las 1','a', 1); 
INSERT INTO pozeranie VALUES(12, 13, 3);
INSERT INTO pozeranie VALUES(13, 12, 3);
INSERT INTO wystapienia VALUES(123, 12, 1);


Dla każdego lasu liczbę pozeranych w nim osobników w jednostce czasu.

Krok symulacji czasu dla danego czasu (najpierw rozmnażanie, potem pożeranie).

