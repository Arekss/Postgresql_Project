CREATE VIEW ksiazka_pelne_dane AS
select
       tytul
     , imie     imie_autora
     , nazwisko nazwisko_autora
     , rok      rok_powstania
     , nazwa_gatunku
     , ilosc_calkowita
     , ilosc_wypozyczona
from
       ksiazka       k
     , autor         a
     , gatunek       g
     , ksiazka_ilosc ki
WHERE
       k.autor_id       =a.autor_id
       AND ki.ksiazka_id=k.ksiazka_id
       AND g.gatunek_id = k.gatunek_id
;