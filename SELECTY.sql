SELECT tytul, nazwa_gatunku FROM ksiazka JOIN gatunek ON ksiazka.gatunek_id=gatunek.gatunek_id;
select tytul,nazwa_wydawnictwa from ksiazka k , wydawnictwo_ksiazki wk where k.ksiazka_id=wk.ksiazka_id;

SELECT * FROM ksiazka_pelne_dane;



UPDATE wypozyczenie SET wymagana_data_oddania = (current_date - integer '28')
WHERE wypozyczenie_id < ${tu_cos_wpisac};
DELETE FROM wypozyczenie WHERE egzemplarz_id  = ${tu_cos_innego_wpisac};
SELECT * from czytelnik;

WITH RECURSIVE cte
AS ( SELECT nazwa_gatunku, gatunek_nadrzedny, 1 lvl, ''::text as path from gatunek
WHERE nazwa_gatunku = 'epika' 
UNION ALL 
SELECT e.nazwa_gatunku, e.gatunek_nadrzedny, c.lvl+1, concat( c.path, '->', c.nazwa_gatunku) 
FROM gatunek e INNER JOIN cte c on e.gatunek_nadrzedny = c.nazwa_gatunku 
WHERE e.gatunek_nadrzedny IS NOT NULL )
SELECT DISTINCT nazwa_gatunku, lvl, path FROM cte ORDER BY lvl;

select tytul, count(*) from egzemplarz,ksiazka where ksiazka.ksiazka_id = egzemplarz.ksiazka_id group by tytul
ORDER BY count DESC;

