CREATE TABLE ksiazka
             (
                          ksiazka_id SERIAL
                        , autor_id   INTEGER NOT NULL REFERENCES autor(autor_id)
                        , tytul      VARCHAR(32) NOT NULL
                        , gatunek_id INTEGER REFERENCES gatunek(gatunek_id)
                        , rok        INTEGER
                        , CONSTRAINT ksiazka_pk PRIMARY KEY(ksiazka_id)
             )
;




CREATE OR REPLACE FUNCTION dodaj_dane()
    RETURNS TRIGGER LANGUAGE plpgsql
AS
    $$
BEGIN
    INSERT INTO ksiazka_ilosc
           (ksiazka_id
           )
           values
           (NEW.ksiazka_id
           )
    ;
    
    RETURN NEW;
END;
$$;
CREATE TRIGGER dane_o_ksiazce AFTER
INSERT
ON
       ksiazka FOR EACH ROW EXECUTE PROCEDURE dodaj_dane()
;


INSERT INTO ksiazka(autor_id, tytul, gatunek_id, rok)
       values(1, 'Krzyzacy', 11, 1897);
	   
INSERT INTO ksiazka(autor_id, tytul, gatunek_id, rok)
       values(2, 'Lokomotywa', 15, 1938);
	   
INSERT INTO ksiazka(autor_id, tytul, gatunek_id, rok)
       values(1, 'Potop', 11, 1886);