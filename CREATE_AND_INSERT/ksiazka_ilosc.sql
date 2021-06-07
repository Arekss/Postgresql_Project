CREATE TABLE ksiazka_ilosc
             (
                          ksiazka_id        INTEGER NOT NULL REFERENCES ksiazka(ksiazka_id) ,
                          ilosc_calkowita   INTEGER DEFAULT 0                               ,
                          ilosc_wypozyczona INTEGER DEFAULT 0
             )
;