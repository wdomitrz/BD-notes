-- Zadanie 1. (stopnie rozwiązania)
-- Końcowa tabela (połączenie dwóch tabel)
WITH helper1 AS
		(SELECT g.nr AS gnr, l.nr AS lnr, SUM(w.ilosc) AS ilosc
			FROM gatunki g, lasy l, wystapienia w
			WHERE g.nr = w.nr_gatunku
			AND l.nr = w.nr_lasu
			GROUP BY g.nr, l.nr),
	helper2 AS
	(SELECT t1.gnr AS gnr, t1.lnr AS lnr
		FROM helper1 t1, helper1 t2
		WHERE t1.gnr = t2.gnr
		GROUP BY t1.gnr, t1.lnr, t1.ilosc
		HAVING t1.ilosc = MIN(t2.ilosc))
SELECT g.nr, g.nazwa, g.ilosc, gil.lnr
	FROM
		(SELECT g.nr AS nr, g.nazwa AS nazwa, SUM(w.ilosc) AS ilosc
			FROM gatunki g, wystapienia w
			WHERE g.nr = w.nr_gatunku
			GROUP BY g.nr, g.nazwa) g -- LEFT JOIN, żeby gatunki, które nigdzie nie występują też wypisać
	LEFT JOIN (SELECT m1.gnr AS gnr, m1.lnr AS lnr
			FROM helper2 m1, helper2 m2
			WHERE m1.gnr = m2.gnr
			GROUP BY m1.gnr, m1.lnr
			HAVING m1.lnr = MIN(m2.lnr)) gil
	ON g.nr = gil.gnr;

-- Zadanie 2.
SELECT g.nr, g.nazwa 
	FROM gatunki g 
	LEFT JOIN pozeranie p -- iloczyn kartezjański, z on zamiASt where i jeśli po prawej nic nie ma, to po prawej jest nic
	ON g.nr = p.kto 
	GROUP BY g.nr, g.nazwa
	HAVING COUNT(p.kto) = 0;

-- Zadanie 3.
SELECT g1.nr, g1.nazwa, g2.nr, g2.nazwa
	FROM gatunki g1, gatunki g2, pozeranie p 
	WHERE p.kto = g1.nr 
	AND p.kogo = g2.nr 
	AND g1.wielkosc < g2.wielkosc;

-- Zadanie 4.
SELECT l.nr, l.nazwa, g.nr, g.nazwa
	FROM lasy l 
	JOIN wystapienia w2
	ON w2.nr_lasu = l.nr 
	JOIN pozeranie p
	ON p.kogo = w2.nr_gatunku 
	JOIN gatunki g
	ON w2.nr_gatunku = g.nr
	LEFT JOIN wystapienia w1
	ON w1.nr_lasu = l.nr  
	AND p.kto = w1.nr_gatunku 
	GROUP BY l.nr, l.nazwa, g.nr, g.nazwa
	HAVING COUNT(w1.nr_gatunku) = 0;

-- Zadanie 5.
SELECT pas.nr 
	FROM pasniki pas, wystapienia w1, wystapienia w2, pozeranie p, gatunki g1, gatunki g2 
	WHERE w1.nr_lasu = w2.nr_lasu 
	AND w1.nr_lasu = pas.nr_lasu 
	AND p.kto = w1.nr_gatunku 
	AND p.kogo = w2.nr_gatunku 
	AND g1.nr = w1.nr_gatunku 
	AND g2.nr = w2.nr_gatunku 
	AND g2.karma = g1.karma 
	AND pas.karma = g1.karma
	GROUP BY pas.nr;

-- Zadanie 6.
SELECT l.nr, l.nazwa
	FROM lasy l, wystapienia w, gatunki g 
	WHERE l.nr = w.nr_lasu 
	AND w.nr_gatunku = g.nr 
	GROUP BY l.nr, l.nazwa, l.wielkosc
	HAVING SUM(g.wielkosc * w.ilosc) > l.wielkosc;

-- Zadanie 7.
SELECT l.nazwa, l.nr, g.nazwa, g.nr
	FROM lasy l, gatunki g, wystapienia w, pozeranie p, wystapienia wp
	WHERE l.nr = w.nr_lasu 
	AND g.nr = w.nr_gatunku 
	AND p.kogo = g.nr 
	AND wp.nr_gatunku = p.kto
	AND wp.nr_lasu = l.nr
	GROUP BY l.nr, l.nazwa, g.nr, g.nazwa
	HAVING SUM(w.ilosc) * 105 < 100 * (SUM(w.ilosc) + SUM(g.rozrodczosc) - SUM(g.smiertelnosc) - SUM(wp.ilosc * p.jak_duzo))
	OR SUM(w.ilosc) * 95 > 100 * (SUM(w.ilosc) + SUM(g.rozrodczosc) - SUM(g.smiertelnosc) - SUM(wp.ilosc * p.jak_duzo));

-- Zadanie 8.
SELECT lk.nr, lk.nazwa
	FROM 
		(SELECT DISTINCT l.nr, l.nazwa, g.karma 
			FROM lasy l, wystapienia w, gatunki g 
			WHERE l.nr = w.nr_lasu 
			AND g.nr = w.nr_gatunku) lk 
	LEFT JOIN pasniki p 
	ON p.nr_lasu = lk.nr  
	AND lk.karma = p.karma 
	GROUP BY lk.nr, lk.nazwa
	HAVING COUNT(*) > COUNT(p.nr);

-- Zadanie 9.
WITH 
	karma AS
	(SELECT l.nr AS nr, p.karma AS karma, SUM(p.wielkosc) AS ilosc 
		FROM lasy l, pasniki p 
		WHERE l.nr = p.nr_lasu 
		GROUP BY l.nr, p.karma),
	zapotrzebowanie AS
	(SELECT l.nr AS nr, l.nazwa AS nazwa, g.karma AS karma, SUM(g.wielkosc * w.ilosc) AS ilosc 
		FROM lasy l, wystapienia w, gatunki g 
		WHERE l.nr = w.nr_lasu 
		AND g.nr = w.nr_gatunku 
		GROUP BY l.nr, l.nazwa, g.karma)
SELECT z.nazwa 
	FROM zapotrzebowanie z 
	LEFT JOIN karma k -- Jak nie ma w ogóle karmy to też jest źle
	ON z.nr = k.nr 
	AND z.karma = k.karma 
	WHERE k.ilosc IS NULL OR z.ilosc > k.ilosc 
	GROUP BY z.nr, z.nazwa;


-- Zadanie 10.
WITH 
	roslinozercy AS 
	(SELECT g.nr, g.nazwa 
		FROM gatunki g 
		LEFT JOIN pozeranie p -- iloczyn kartezjański, z on zamiASt where i jeśli po prawej nic nie ma, to po prawej jest nic
		ON g.nr = p.kto 
		GROUP BY g.nr, g.nazwa
		HAVING COUNT(p.kto) = 0),
	bez_wrogow AS 
	(SELECT g.nr, g.nazwa
		FROM gatunki g 
		LEFT JOIN pozeranie p
		ON g.nr = p.kogo
		GROUP BY g.nr, g.nazwa
		HAVING COUNT(p.kto) = 0)
SELECT COUNT(*) AS llpdd2 -- liczba łanczuchów pokarmowych długości dokładnie 2
	FROM roslinozercy r, bez_wrogow b, pozeranie p 
	WHERE r.nr = p.kogo 
	AND b.nr = p.kto;