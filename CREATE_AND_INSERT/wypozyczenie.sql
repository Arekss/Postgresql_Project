CREATE TABLE wypozyczenie( 
						wypozyczenie_id SERIAL PRIMARY KEY,
						czytelnik_id INTEGER NOT NULL REFERENCES czytelnik(czytelnik_id),
						egzemplarz_id INTEGER NOT NULL REFERENCES egzemplarz(egzemplarz_id),
						data_wypozyczenia DATE DEFAULT  current_date,
						wymagana_data_oddania DATE DEFAULT current_date + integer '14');
						


CREATE OR REPLACE FUNCTION Wypozycz(id_czytelnika INTEGER, tytul_ksiazki VARCHAR(32) )
      RETURNS TEXT AS
      $BODY$
          BEGIN
            INSERT INTO wypozyczenie (czytelnik_id, egzemplarz_id)
			SELECT id_czytelnika, egzemplarz_id FROM egzemplarz
			WHERE ksiazka_id = (SELECT ksiazka_id from ksiazka WHERE tytul = tytul_ksiazki )
			AND status = 'wolny' LIMIT 1;
			  IF NOT FOUND THEN
				INSERT INTO kolejka(czytelnik_id, ksiazka_id)
				SELECT id_czytelnika, ksiazka_id from ksiazka WHERE tytul = tytul_ksiazki;
				
				RAISE INFO 'Ksiazka % obecnie nie jest dostepna - dodano do kolejki', tytul_ksiazki;
				ELSE
				UPDATE egzemplarz SET status = 'zajety' WHERE egzemplarz_id = ANY(select egzemplarz_id FROM wypozyczenie);
				UPDATE ksiazka_ilosc SET ilosc_wypozyczona=ilosc_wypozyczona+1 WHERE
				(SELECT ksiazka_id from ksiazka WHERE tytul = tytul_ksiazki ) = ksiazka_ilosc.ksiazka_id;
				RAISE INFO 'Pomyslnie wypozyczono ksiazke %', tytul_ksiazki;
			  END IF;
			  RETURN 'OK';
          END;
      $BODY$
      LANGUAGE 'plpgsql' VOLATILE
      COST 100;	 
	  
/* SELECT Wypozycz(1,'Potop');
SELECT Wypozycz(1,'Krzyzacy'); */

CREATE OR REPLACE FUNCTION sprawdz_termin() RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
UPDATE czytelnik SET naliczone_oplaty = 2 where czytelnik_id = 
 ANY(SELECT czytelnik_id FROM wypozyczenie WHERE current_date > wymagana_data_oddania);
 RETURN NEW;
END;
$$;

CREATE TRIGGER trig_oplaty_BI AFTER INSERT OR UPDATE OR DELETE ON wypozyczenie
FOR EACH STATEMENT EXECUTE PROCEDURE sprawdz_termin(); 


CREATE OR REPLACE FUNCTION sprawdz_kolejke() RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN 
 INSERT INTO wypozyczenie (czytelnik_id, egzemplarz_id)
 
 SELECT czytelnik_id, OLD.egzemplarz_id FROM kolejka WHERE
 (SELECT ksiazka_id from egzemplarz WHERE OLD.egzemplarz_id = egzemplarz.egzemplarz_id)
  = kolejka.ksiazka_id ORDER BY kolejka.czytelnik_id, kolejka.ksiazka_id LIMIT 1;
  IF NOT FOUND THEN
  UPDATE egzemplarz SET status = 'wolny' WHERE egzemplarz.egzemplarz_id = OLD.egzemplarz_id;
  UPDATE ksiazka_ilosc SET ilosc_wypozyczona=ilosc_wypozyczona-1 WHERE ksiazka_ilosc.ksiazka_id = 
  (SELECT ksiazka_id from egzemplarz where egzemplarz_id = OLD.egzemplarz_id);   
  ELSE
  DELETE FROM kolejka  WHERE ctid IN (SELECT ctid FROM kolejka WHERE (SELECT ksiazka_id from egzemplarz WHERE
  OLD.egzemplarz_id = egzemplarz.egzemplarz_id) = kolejka.ksiazka_id ORDER BY kolejka.czytelnik_id, kolejka.ksiazka_id LIMIT 1);
  END IF;
 RETURN OLD;
END;
$$;

CREATE TRIGGER trig_kolejka_BI AFTER DELETE ON wypozyczenie
FOR EACH ROW EXECUTE PROCEDURE sprawdz_kolejke(); 