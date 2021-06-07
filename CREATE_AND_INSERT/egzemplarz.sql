CREATE TYPE statuses AS ENUM ('wolny', 'zajety');


CREATE TABLE egzemplarz( egzemplarz_id SERIAL PRIMARY KEY, 
						ksiazka_id INTEGER NOT NULL REFERENCES ksiazka(ksiazka_id),
						wydawnictwo_id INTEGER REFERENCES wydawnictwo(wydawnictwo_id),
						rok_wydania INTEGER,
						status statuses DEFAULT 'wolny');
											

CREATE OR REPLACE FUNCTION zwieksz_ilosc() RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
	IF ((SELECT ilosc_calkowita from ksiazka_ilosc WHERE ksiazka_id = NEW.ksiazka_id) < 
        (SELECT ilosc_wypozyczona from ksiazka_ilosc WHERE ksiazka_id = NEW.ksiazka_id))
	THEN
	     RAISE EXCEPTION 'Nie zgadza sie ilosc ksiazek o ID %  !!!', NEW.ksiazka_id;
	ELSE
		UPDATE ksiazka_ilosc SET ilosc_calkowita=ilosc_calkowita+1 where
		NEW.ksiazka_id = ksiazka_ilosc.ksiazka_id;
	END IF;
RETURN NEW;
END;
$$;


CREATE TRIGGER zliczacz_egzemplarzy AFTER INSERT ON egzemplarz
FOR EACH ROW EXECUTE PROCEDURE zwieksz_ilosc(); 	

INSERT INTO egzemplarz(ksiazka_id, wydawnictwo_id, rok_wydania) values(8,1,2019);					
INSERT INTO egzemplarz(ksiazka_id, wydawnictwo_id, rok_wydania) values(8,1,2019);					
INSERT INTO egzemplarz(ksiazka_id, wydawnictwo_id, rok_wydania) values(7,2,2015);					
INSERT INTO egzemplarz(ksiazka_id, wydawnictwo_id, rok_wydania) values(7,2,2015);					
INSERT INTO egzemplarz(ksiazka_id, wydawnictwo_id, rok_wydania) values(7,2,2015);					
INSERT INTO egzemplarz(ksiazka_id, wydawnictwo_id, rok_wydania) values(7,2,2015);					
INSERT INTO egzemplarz(ksiazka_id, wydawnictwo_id, rok_wydania) values(7,2,2015);					
INSERT INTO egzemplarz(ksiazka_id, wydawnictwo_id, rok_wydania) values(7,2,2015);					
INSERT INTO egzemplarz(ksiazka_id, wydawnictwo_id, rok_wydania) values(7,2,2015);					
INSERT INTO egzemplarz(ksiazka_id, wydawnictwo_id, rok_wydania) values(6,3,2003);					
INSERT INTO egzemplarz(ksiazka_id, wydawnictwo_id, rok_wydania) values(6,3,2003);					
INSERT INTO egzemplarz(ksiazka_id, wydawnictwo_id, rok_wydania) values(6,3,2003);					